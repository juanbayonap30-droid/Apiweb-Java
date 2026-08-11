package com.registro.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.registro.model.Usuario;

public class UsuarioDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/registro_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // XAMPP MySQL no tiene password por defecto

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    /**
     * Registra un nuevo usuario en la base de datos.
     * Usa PreparedStatement para prevenir SQL injection.
     */
    public boolean registrar(Usuario usuario) throws SQLException {
        String sql = "INSERT INTO usuarios (nombre, apellido, email, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getPassword()); // En producción: usa hash (BCrypt)

            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Verifica credenciales y retorna el usuario si son correctas.
     */
    public Usuario login(String email, String password) throws SQLException {
        String sql = "SELECT id, nombre, apellido, email FROM usuarios WHERE email = ? AND password = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setEmail(rs.getString("email"));
                return u;
            }
        }
        return null;
    }

    /**
     * Lista todos los usuarios.
     */
    public List<Usuario> listar() throws SQLException {
        String sql = "SELECT id, nombre, apellido, email FROM usuarios ORDER BY id";
        List<Usuario> lista = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setEmail(rs.getString("email"));
                lista.add(u);
            }
        }
        return lista;
    }

    /**
     * Busca un usuario por ID.
     */
    public Usuario buscarPorId(int id) throws SQLException {
        String sql = "SELECT id, nombre, apellido, email FROM usuarios WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNombre(rs.getString("nombre"));
                u.setApellido(rs.getString("apellido"));
                u.setEmail(rs.getString("email"));
                return u;
            }
        }
        return null;
    }

    /**
     * Actualiza los datos de un usuario.
     */
    public boolean actualizar(Usuario u) throws SQLException {
        String sql = (u.getPassword() != null && !u.getPassword().isEmpty())
            ? "UPDATE usuarios SET nombre=?, apellido=?, email=?, password=? WHERE id=?"
            : "UPDATE usuarios SET nombre=?, apellido=?, email=? WHERE id=?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getEmail());
            if (u.getPassword() != null && !u.getPassword().isEmpty()) {
                ps.setString(4, u.getPassword());
                ps.setInt(5, u.getId());
            } else {
                ps.setInt(4, u.getId());
            }
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Elimina un usuario por ID.
     */
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM usuarios WHERE id = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    /**
     * Verifica si un email ya está registrado.
     */
    public boolean emailExiste(String email) throws SQLException {
        String sql = "SELECT COUNT(*) FROM usuarios WHERE email = ?";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }
}

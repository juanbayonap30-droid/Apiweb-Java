package com.registro.servlet;

import com.registro.dao.UsuarioDAO;
import com.registro.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // Mostrar formulario
        req.getRequestDispatcher("/registro.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String nombre   = req.getParameter("nombre").trim();
        String apellido = req.getParameter("apellido").trim();
        String email    = req.getParameter("email").trim();
        String password = req.getParameter("password");
        String confirmar = req.getParameter("confirmar");

        // Validaciones básicas
        if (nombre.isEmpty() || apellido.isEmpty() || email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Todos los campos son obligatorios.");
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmar)) {
            req.setAttribute("error", "Las contraseñas no coinciden.");
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 8) {
            req.setAttribute("error", "La contraseña debe tener al menos 8 caracteres.");
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            return;
        }

        try {
            if (usuarioDAO.emailExiste(email)) {
                req.setAttribute("error", "El email ya está registrado.");
                req.getRequestDispatcher("/registro.jsp").forward(req, resp);
                return;
            }

            Usuario usuario = new Usuario(nombre, apellido, email, password);
            boolean registrado = usuarioDAO.registrar(usuario);

            if (registrado) {
                req.setAttribute("nombre", nombre);
                req.getRequestDispatcher("/exito.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Error al registrar. Intenta de nuevo.");
                req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            req.setAttribute("error", "Error de base de datos: " + e.getMessage());
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
        }
    }
}

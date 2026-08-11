package com.registro.servlet;

import com.registro.dao.UsuarioDAO;
import com.registro.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {

    private final UsuarioDAO dao = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Proteger con sesión
        if (req.getSession().getAttribute("usuario") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "listar";

        try {
            switch (action) {
                case "nuevo":
                    req.getRequestDispatcher("/form-usuario.jsp").forward(req, resp);
                    break;
                case "editar":
                    int id = Integer.parseInt(req.getParameter("id"));
                    Usuario u = dao.buscarPorId(id);
                    req.setAttribute("usuario", u);
                    req.getRequestDispatcher("/form-usuario.jsp").forward(req, resp);
                    break;
                case "eliminar":
                    dao.eliminar(Integer.parseInt(req.getParameter("id")));
                    resp.sendRedirect(req.getContextPath() + "/usuarios");
                    break;
                default:
                    List<Usuario> lista = dao.listar();
                    req.setAttribute("lista", lista);
                    req.getRequestDispatcher("/lista-usuarios.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String idParam = req.getParameter("id");
        String nombre   = req.getParameter("nombre").trim();
        String apellido = req.getParameter("apellido").trim();
        String email    = req.getParameter("email").trim();
        String password = req.getParameter("password");

        Usuario u = new Usuario();
        u.setNombre(nombre);
        u.setApellido(apellido);
        u.setEmail(email);
        u.setPassword(password);

        try {
            if (idParam == null || idParam.isEmpty()) {
                dao.registrar(u);
            } else {
                u.setId(Integer.parseInt(idParam));
                dao.actualizar(u);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
        resp.sendRedirect(req.getContextPath() + "/usuarios");
    }
}

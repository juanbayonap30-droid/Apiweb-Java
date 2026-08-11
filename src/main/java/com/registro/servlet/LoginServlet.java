package com.registro.servlet;

import com.registro.dao.UsuarioDAO;
import com.registro.model.Usuario;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        String email    = req.getParameter("email").trim();
        String password = req.getParameter("password");

        if (email.isEmpty() || password.isEmpty()) {
            req.setAttribute("error", "Todos los campos son obligatorios.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        try {
            Usuario usuario = usuarioDAO.login(email, password);
            if (usuario != null) {
                HttpSession session = req.getSession();
                session.setAttribute("usuario", usuario);
                resp.sendRedirect(req.getContextPath() + "/bienvenido.jsp");
            } else {
                req.setAttribute("error", "Email o contraseña incorrectos.");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            req.setAttribute("error", "Error de base de datos: " + e.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
}

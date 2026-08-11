<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.registro.model.Usuario" %>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login"); return;
    }
    List<Usuario> lista = (List<Usuario>) request.getAttribute("lista");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Usuarios</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .content { padding: 2rem; }
        h2 { margin-bottom: 1.5rem; color: #2c3e50; }
        table { width: 100%; border-collapse: collapse; background: #fff; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #2c3e50; color: #fff; padding: 0.8rem 1rem; text-align: left; }
        td { padding: 0.75rem 1rem; border-bottom: 1px solid #eee; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #f8f9fa; }
        .btn { padding: 0.35rem 0.8rem; border-radius: 4px; text-decoration: none; font-size: 0.85rem; border: none; cursor: pointer; }
        .btn-edit { background: #f39c12; color: #fff; }
        .btn-delete { background: #e74c3c; color: #fff; }
        .empty { text-align: center; padding: 2rem; color: #888; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="content">
    <h2>Lista de Usuarios</h2>
    <table>
        <thead>
            <tr>
                <th>#</th><th>Nombre</th><th>Apellido</th><th>Email</th><th>Acciones</th>
            </tr>
        </thead>
        <tbody>
        <% if (lista == null || lista.isEmpty()) { %>
            <tr><td colspan="5" class="empty">No hay usuarios registrados.</td></tr>
        <% } else { for (Usuario u : lista) { %>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getNombre() %></td>
                <td><%= u.getApellido() %></td>
                <td><%= u.getEmail() %></td>
                <td>
                    <a href="usuarios?action=editar&id=<%= u.getId() %>" class="btn btn-edit">Editar</a>
                    <a href="usuarios?action=eliminar&id=<%= u.getId() %>" class="btn btn-delete"
                       onclick="return confirm('¿Eliminar este usuario?')">Eliminar</a>
                </td>
            </tr>
        <% } } %>
        </tbody>
    </table>
</div>
</body>
</html>

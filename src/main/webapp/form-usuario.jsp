<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.registro.model.Usuario" %>
<%
    if (session.getAttribute("usuario") == null) {
        response.sendRedirect("login"); return;
    }
    Usuario u = (Usuario) request.getAttribute("usuario");
    boolean esEdicion = (u != null);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title><%= esEdicion ? "Editar" : "Nuevo" %> Usuario</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .content { padding: 2rem; display: flex; justify-content: center; }
        .card { background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 100%; max-width: 440px; }
        h2 { margin-bottom: 1.5rem; color: #2c3e50; }
        .form-group { margin-bottom: 1rem; }
        label { display: block; margin-bottom: 0.3rem; color: #555; font-size: 0.9rem; }
        input { width: 100%; padding: 0.6rem 0.8rem; border: 1px solid #ccc; border-radius: 4px; font-size: 1rem; }
        input:focus { outline: none; border-color: #4a90e2; }
        .hint { font-size: 0.78rem; color: #999; margin-top: 0.2rem; }
        button { width: 100%; padding: 0.75rem; background: #4a90e2; color: #fff; border: none; border-radius: 4px; font-size: 1rem; cursor: pointer; margin-top: 0.5rem; }
        button:hover { background: #357abd; }
        .btn-cancel { display: block; text-align: center; margin-top: 0.8rem; color: #888; text-decoration: none; font-size: 0.9rem; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="content">
    <div class="card">
        <h2><%= esEdicion ? "Editar Usuario" : "Nuevo Usuario" %></h2>
        <form action="usuarios" method="post">
            <% if (esEdicion) { %>
                <input type="hidden" name="id" value="<%= u.getId() %>">
            <% } %>
            <div class="form-group">
                <label>Nombre</label>
                <input type="text" name="nombre" required value="<%= esEdicion ? u.getNombre() : "" %>">
            </div>
            <div class="form-group">
                <label>Apellido</label>
                <input type="text" name="apellido" required value="<%= esEdicion ? u.getApellido() : "" %>">
            </div>
            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" required value="<%= esEdicion ? u.getEmail() : "" %>">
            </div>
            <div class="form-group">
                <label>Contraseña</label>
                <input type="password" name="password" <%= esEdicion ? "" : "required" %>>
                <% if (esEdicion) { %><p class="hint">Dejar vacío para no cambiar la contraseña.</p><% } %>
            </div>
            <button type="submit"><%= esEdicion ? "Guardar cambios" : "Crear usuario" %></button>
            <a href="usuarios" class="btn-cancel">Cancelar</a>
        </form>
    </div>
</div>
</body>
</html>

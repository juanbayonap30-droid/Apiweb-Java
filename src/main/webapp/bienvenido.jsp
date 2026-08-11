<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.registro.model.Usuario" %>
<%
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    if (usuario == null) { response.sendRedirect("login"); return; }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Bienvenido</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .content { display: flex; justify-content: center; align-items: center; min-height: calc(100vh - 50px); }
        .card { background: #fff; padding: 2rem; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; max-width: 400px; }
        .icon { font-size: 3rem; margin-bottom: 1rem; }
        h2 { color: #27ae60; margin-bottom: 0.5rem; }
        p { color: #555; margin-bottom: 0.5rem; }
        .btn { display: inline-block; margin-top: 1rem; padding: 0.6rem 1.5rem; background: #4a90e2; color: #fff; border-radius: 4px; text-decoration: none; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="content">
    <div class="card">
        <div class="icon">👋</div>
        <h2>Bienvenido/a</h2>
        <p>Hola, <strong><%= usuario.getNombre() %> <%= usuario.getApellido() %></strong></p>
        <p style="font-size:0.85rem;color:#888;"><%= usuario.getEmail() %></p>
        <a href="usuarios" class="btn">Ver usuarios</a>
    </div>
</div>
</body>
</html>

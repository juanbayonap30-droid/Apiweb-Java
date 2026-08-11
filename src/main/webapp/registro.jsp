<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuario</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .card {
            background: #fff;
            padding: 2rem;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 420px;
        }
        h2 { margin-bottom: 1.5rem; color: #333; text-align: center; }
        .form-group { margin-bottom: 1rem; }
        label { display: block; margin-bottom: 0.3rem; color: #555; font-size: 0.9rem; }
        input {
            width: 100%;
            padding: 0.6rem 0.8rem;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 1rem;
        }
        input:focus { outline: none; border-color: #4a90e2; }
        button {
            width: 100%;
            padding: 0.75rem;
            background: #4a90e2;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 0.5rem;
        }
        button:hover { background: #357abd; }
        .error {
            background: #fdecea;
            color: #c0392b;
            padding: 0.7rem 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
<div class="card">
    <h2>Registro de Usuario</h2>

    <%-- Mostrar error si existe --%>
    <% if (request.getAttribute("error") != null) { %>
        <div class="error">${error}</div>
    <% } %>

    <form action="registro" method="post">
        <div class="form-group">
            <label for="nombre">Nombre</label>
            <input type="text" id="nombre" name="nombre" required
                   value="${param.nombre}" placeholder="Tu nombre">
        </div>
        <div class="form-group">
            <label for="apellido">Apellido</label>
            <input type="text" id="apellido" name="apellido" required
                   value="${param.apellido}" placeholder="Tu apellido">
        </div>
        <div class="form-group">
            <label for="email">Correo electrónico</label>
            <input type="email" id="email" name="email" required
                   value="${param.email}" placeholder="correo@ejemplo.com">
        </div>
        <div class="form-group">
            <label for="password">Contraseña</label>
            <input type="password" id="password" name="password" required
                   minlength="8" placeholder="Mínimo 8 caracteres">
        </div>
        <div class="form-group">
            <label for="confirmar">Confirmar contraseña</label>
            <input type="password" id="confirmar" name="confirmar" required
                   placeholder="Repite tu contraseña">
        </div>
        <button type="submit">Registrarse</button>
    </form>
</div>
</body>
</html>

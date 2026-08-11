<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar sesión</title>
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
            max-width: 380px;
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
        .link { text-align: center; margin-top: 1rem; font-size: 0.9rem; }
        .link a { color: #4a90e2; text-decoration: none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Iniciar sesión</h2>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error">${error}</div>
    <% } %>

    <form action="login" method="post">
        <div class="form-group">
            <label for="email">Correo electrónico</label>
            <input type="email" id="email" name="email" required
                   value="${param.email}" placeholder="correo@ejemplo.com">
        </div>
        <div class="form-group">
            <label for="password">Contraseña</label>
            <input type="password" id="password" name="password" required
                   placeholder="Tu contraseña">
        </div>
        <button type="submit">Ingresar</button>
    </form>
    <div class="link">
        ¿No tienes cuenta? <a href="registro">Regístrate</a>
    </div>
</div>
</body>
</html>

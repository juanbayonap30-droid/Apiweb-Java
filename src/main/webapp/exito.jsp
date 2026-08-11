<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro Exitoso</title>
    <style>
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
            text-align: center;
            max-width: 400px;
        }
        .icon { font-size: 3rem; margin-bottom: 1rem; }
        h2 { color: #27ae60; margin-bottom: 0.5rem; }
        p { color: #555; margin-bottom: 1.5rem; }
        a {
            display: inline-block;
            padding: 0.6rem 1.5rem;
            background: #4a90e2;
            color: #fff;
            border-radius: 4px;
            text-decoration: none;
        }
        a:hover { background: #357abd; }
    </style>
</head>
<body>
<div class="card">
    <div class="icon">✅</div>
    <h2>¡Registro exitoso!</h2>
    <p>Bienvenido/a, <strong>${nombre}</strong>. Tu cuenta fue creada correctamente.</p>
    <a href="login">Iniciar sesión</a>
</div>
</body>
</html>

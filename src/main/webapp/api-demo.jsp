<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, org.json.JSONObject" %>
<%
    List<JSONObject> items = (List<JSONObject>) request.getAttribute("items");
    int statusCode = (int) request.getAttribute("statusCode");
    String tipo = (String) request.getAttribute("tipo");
    String url  = (String) request.getAttribute("url");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>API Demo</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .content { padding: 2rem; }
        .header { display: flex; align-items: center; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap; }
        h2 { color: #2c3e50; }
        .badge { padding: 0.3rem 0.7rem; border-radius: 20px; font-size: 0.8rem; font-weight: bold;
                 background: #27ae60; color: #fff; }
        .url { font-size: 0.8rem; color: #888; background: #fff; padding: 0.3rem 0.7rem;
               border-radius: 4px; border: 1px solid #ddd; }
        .tabs { display: flex; gap: 0.5rem; margin-bottom: 1.5rem; }
        .tab { padding: 0.5rem 1.2rem; border-radius: 4px; text-decoration: none;
               background: #fff; border: 1px solid #ddd; color: #555; font-size: 0.9rem; }
        .tab.active { background: #4a90e2; color: #fff; border-color: #4a90e2; }
        table { width: 100%; border-collapse: collapse; background: #fff;
                border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #2c3e50; color: #fff; padding: 0.75rem 1rem; text-align: left; font-size: 0.9rem; }
        td { padding: 0.65rem 1rem; border-bottom: 1px solid #eee; font-size: 0.88rem; color: #444; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #f8f9fa; }
        .completed-yes { color: #27ae60; font-weight: bold; }
        .completed-no  { color: #e74c3c; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="content">
    <div class="header">
        <h2>Consumo de API Externa</h2>
        <span class="badge">HTTP <%= statusCode %></span>
        <span class="url"><%= url %></span>
    </div>

    <div class="tabs">
        <a href="api-demo?tipo=todos" class="tab <%= tipo.equals("todos") ? "active" : "" %>">Todos (todos)</a>
        <a href="api-demo?tipo=posts" class="tab <%= tipo.equals("posts") ? "active" : "" %>">Posts</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <% if (tipo.equals("todos")) { %>
                    <th>UserID</th><th>Título</th><th>Completado</th>
                <% } else { %>
                    <th>UserID</th><th>Título</th><th>Cuerpo</th>
                <% } %>
            </tr>
        </thead>
        <tbody>
        <% for (JSONObject item : items) { %>
            <tr>
                <td><%= item.getInt("id") %></td>
                <td><%= item.getInt("userId") %></td>
                <td><%= item.getString("title") %></td>
                <% if (tipo.equals("todos")) { %>
                    <td class="<%= item.getBoolean("completed") ? "completed-yes" : "completed-no" %>">
                        <%= item.getBoolean("completed") ? "✔ Sí" : "✘ No" %>
                    </td>
                <% } else { %>
                    <td><%= item.getString("body").replace("\n", " ") %></td>
                <% } %>
            </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>

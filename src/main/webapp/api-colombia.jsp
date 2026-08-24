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
    <title>API Colombia</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .content { padding: 2rem; }
        .header { display: flex; align-items: center; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap; }
        h2 { color: #2c3e50; }
        .badge { padding: 0.3rem 0.8rem; border-radius: 20px; font-size: 0.8rem;
                 font-weight: bold; background: #f39c12; color: #fff; }
        .url { font-size: 0.78rem; color: #888; background: #fff; padding: 0.3rem 0.8rem;
               border-radius: 4px; border: 1px solid #ddd; word-break: break-all; }
        .tabs { display: flex; gap: 0.5rem; margin-bottom: 1.5rem; flex-wrap: wrap; }
        .tab { padding: 0.5rem 1.1rem; border-radius: 4px; text-decoration: none;
               background: #fff; border: 1px solid #ddd; color: #555; font-size: 0.88rem; }
        .tab.active { background: #c0392b; color: #fff; border-color: #c0392b; }
        table { width: 100%; border-collapse: collapse; background: #fff;
                border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.08); }
        th { background: #c0392b; color: #fff; padding: 0.75rem 1rem; text-align: left; font-size: 0.88rem; }
        td { padding: 0.65rem 1rem; border-bottom: 1px solid #eee; font-size: 0.85rem; color: #444; vertical-align: top; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: #fdf5f5; }
        .empty { text-align: center; padding: 2rem; color: #888; }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="content">
    <div class="header">
        <h2>🇨🇴 API Colombia</h2>
        <span class="badge">HTTP <%= statusCode %></span>
        <span class="url"><%= url %></span>
    </div>

    <div class="tabs">
        <a href="api-colombia?tipo=departamentos" class="tab <%= tipo.equals("departamentos") ? "active" : "" %>">Departamentos</a>
        <a href="api-colombia?tipo=regiones"      class="tab <%= tipo.equals("regiones")      ? "active" : "" %>">Regiones</a>
        <a href="api-colombia?tipo=presidentes"   class="tab <%= tipo.equals("presidentes")   ? "active" : "" %>">Presidentes</a>
        <a href="api-colombia?tipo=turistico"     class="tab <%= tipo.equals("turistico")     ? "active" : "" %>">Atracciones turísticas</a>
    </div>

    <% if (items == null || items.isEmpty()) { %>
        <p class="empty">No se obtuvieron datos.</p>
    <% } else if (tipo.equals("departamentos")) { %>
    <table>
        <thead><tr><th>ID</th><th>Nombre</th><th>Descripción</th></tr></thead>
        <tbody>
        <% for (JSONObject o : items) { %>
            <tr>
                <td><%= o.optInt("id") %></td>
                <td><%= o.optString("name") %></td>
                <td><%= o.optString("description","—") %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <% } else if (tipo.equals("regiones")) { %>
    <table>
        <thead><tr><th>ID</th><th>Nombre</th><th>Descripción</th></tr></thead>
        <tbody>
        <% for (JSONObject o : items) { %>
            <tr>
                <td><%= o.optInt("id") %></td>
                <td><%= o.optString("name") %></td>
                <td><%= o.optString("description","—") %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <% } else if (tipo.equals("presidentes")) { %>
    <table>
        <thead><tr><th>ID</th><th>Nombre</th><th>Inicio</th><th>Fin</th><th>Partido</th></tr></thead>
        <tbody>
        <% for (JSONObject o : items) { %>
            <tr>
                <td><%= o.optInt("id") %></td>
                <td><%= o.optString("name","") %> <%= o.optString("lastName","") %></td>
                <td><%= o.optString("startPeriodDate","—") %></td>
                <td><%= o.optString("endPeriodDate","—") %></td>
                <td><%= o.optString("politicalParty","—") %></td>
            </tr>
        <% } %>
        </tbody>
    </table>

    <% } else if (tipo.equals("turistico")) { %>
    <table>
        <thead><tr><th>ID</th><th>Nombre</th><th>Descripción</th><th>Ciudad</th></tr></thead>
        <tbody>
        <% for (JSONObject o : items) { %>
            <tr>
                <td><%= o.optInt("id") %></td>
                <td><%= o.optString("name") %></td>
                <td><%= o.optString("description","—") %></td>
                <td><%= o.optString("cityName","—") %></td>
            </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>
</body>
</html>

package com.registro.servlet;

import com.registro.api.ApiModelo;
import org.json.JSONArray;
import org.json.JSONObject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/api-colombia")
public class ApiServlet extends HttpServlet {

    private static final String BASE = "https://api-colombia.com/api/v1/";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String tipo = req.getParameter("tipo");
        if (tipo == null) tipo = "departamentos";

        String url = switch (tipo) {
            case "presidentes"  -> BASE + "President";
            case "turistico"    -> BASE + "TouristicAttraction";
            case "regiones"     -> BASE + "Region";
            default             -> BASE + "Department";
        };

        ApiModelo api = new ApiModelo(url);
        api.hacer_peticion_get();

        req.setAttribute("items", api.getItems());
        req.setAttribute("statusCode", api.getStatusCode());
        req.setAttribute("tipo", tipo);
        req.setAttribute("url", url);

        req.getRequestDispatcher("/api-colombia.jsp").forward(req, resp);
    }
}

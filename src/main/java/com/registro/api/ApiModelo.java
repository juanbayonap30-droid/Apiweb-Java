package com.registro.api;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

public class ApiModelo {

    private final String api_url;
    private HttpResponse<String> respuesta_api;

    public ApiModelo(String dato_url) {
        this.api_url = dato_url;
        this.respuesta_api = null;
    }

    public void hacer_peticion_get() {
        try {
            HttpClient cliente = HttpClient.newHttpClient();
            HttpRequest peticion = HttpRequest.newBuilder()
                    .uri(URI.create(this.api_url))
                    .header("Accept", "application/json")
                    .GET()
                    .build();
            this.respuesta_api = cliente.send(peticion, HttpResponse.BodyHandlers.ofString());
        } catch (IOException | InterruptedException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
    }

    public int getStatusCode() {
        return respuesta_api != null ? respuesta_api.statusCode() : 0;
    }

    public String getBody() {
        return respuesta_api != null ? respuesta_api.body() : "";
    }

    /** Parsea el JSON y retorna lista de mapas con id y title */
    public List<JSONObject> getItems() {
        List<JSONObject> items = new ArrayList<>();
        if (respuesta_api == null) return items;
        try {
            JSONArray array = new JSONArray(respuesta_api.body());
            for (int i = 0; i < array.length(); i++) {
                items.add(array.getJSONObject(i));
            }
        } catch (Exception ex) {
            System.out.println("Error JSON: " + ex.getMessage());
        }
        return items;
    }
}

### Configuración para Nginx

Para Nginx, necesitarás agregar una configuración específica al archivo de configuración de tu sitio. Generalmente, este archivo se encuentra en `/etc/nginx/sites-available` o en una ubicación similar, dependiendo de tu sistema y configuración.

1.  **Edita el archivo de configuración de tu sitio en Nginx**.
2.  **Agrega la siguiente configuración dentro del bloque `server`**:

```
location / {
    try_files $uri $uri/ /index.php?$query_string;
}
```

    Esta configuración hará que Nginx intente servir el archivo o directorio solicitado si existe. Si no, redirigirá la solicitud a `index.php`, pasando los parámetros de la URL.

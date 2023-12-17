<?php
require __DIR__ . '/libs/vendor/autoload.php';

$router = new AltoRouter();

// Página principal
$router->map('GET', '/', function() {
    require __DIR__ . '/index.php';
});

// Dashboard del usuario
$router->map('GET', '/dashboard', function() {
    require __DIR__ . '/modules/dashboard.php';
});

// Otras rutas...
$router->map('GET', '/gestion-empleados', function() {
    require __DIR__ . '/modules/gestion_empleados/index.php';
});

// Más rutas...

// Coincidencia con la solicitud actual
$match = $router->match();

if($match && is_callable($match['target'])) {
    call_user_func_array($match['target'], $match['params']); 
} else {
    // Si no se encuentra la ruta
    header($_SERVER["SERVER_PROTOCOL"] . ' 404 Not Found');
}

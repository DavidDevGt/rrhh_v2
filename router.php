<?php
require __DIR__ . '/libs/vendor/autoload.php';

$router = new AltoRouter();

// Configura tus rutas aquí
$router->map('GET', '/', function() {
    require __DIR__ . '/index.php';
});

$router->map('GET', '/', function() {
    require __DIR__ . '/index.php';
});

// Match the current request
$match = $router->match();

if($match && is_callable($match['target'])) {
    call_user_func_array($match['target'], $match['params']); 
} else {
    // No route was matched
    header($_SERVER["SERVER_PROTOCOL"] . ' 404 Not Found');
}

<?php
// ini_set('log_errors', 1);
// ini_set('error_log', './errors.log');
// error_reporting(E_ALL);

// error_reporting(E_ALL);
// ini_set('display_errors', '1');


// Determinar si el método de la solicitud es POST o GET
$metodo_solicitud = $_SERVER['REQUEST_METHOD'];

if ($metodo_solicitud == 'POST' || $metodo_solicitud == 'GET') {
    // Obtener el parámetro 'fnc', ya sea de POST o GET
    $op = $metodo_solicitud == 'POST' ? $_POST['fnc'] : $_GET['fnc'];

    switch ($op) {

        default:
            echo '0|Operación no reconocida.';
            break;
    }
} else {
    echo '0|Ha ocurrido un error interno';
}
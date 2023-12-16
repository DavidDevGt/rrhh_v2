<?php
require_once '../../funciones.php';

function verificarRol($rolNecesario) {
    session_start();
    if (!tieneRol($rolNecesario)) {
        // Manejo de acceso no autorizado
        echo json_encode(['authorized' => false]);
        exit;
    }
}

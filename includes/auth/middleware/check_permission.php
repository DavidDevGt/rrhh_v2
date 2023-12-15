<?php
require_once '../../funciones.php';

function verificarPermiso($permisoNecesario) {
    session_start();
    if (!tienePermiso($permisoNecesario)) {
        // Manejo de acceso no autorizado
        echo json_encode(['authorized' => false]);
        exit;
    }
}
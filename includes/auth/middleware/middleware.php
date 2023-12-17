<?php
require_once 'authenticate.php';
require_once 'check_role.php';
require_once 'check_permission.php';
require_once 'check_session.php';

function verificarAcceso($rolNecesario = null, $permisosNecesarios = []) {
    // Verificar autenticación
    if (!usuarioAutenticado()) {
        echo json_encode(['error' => 'Usuario no autenticado']);
        exit;
    }

    // Verificar rol
    if ($rolNecesario !== null && !tieneRol($rolNecesario)) {
        echo json_encode(['error' => 'Acceso no autorizado por rol']);
        exit;
    }

    // Verificar permisos
    if (!empty($permisosNecesarios) && !tienePermiso($permisosNecesarios)) {
        echo json_encode(['error' => 'Acceso no autorizado por permisos']);
        exit;
    }
}


// Ejemplo de uso:

// En un archivo ajax.php específico
// require_once '../includes/auth/middleware/middleware.php';
// verificarAcceso('admin', ['lectura', 'escritura', 'edicion', 'eliminacion']);
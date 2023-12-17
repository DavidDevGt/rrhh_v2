<?php
require_once '../db/db.php';
require_once '../funciones.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'] ?? '';
    $password = $_POST['password'] ?? '';
    $email = $_POST['email'] ?? '';

    // Validar y sanitizar los datos de entrada
    $email = filter_var($email, FILTER_SANITIZE_EMAIL);

    if (!esEmailValido($email)) {
        echo json_encode(['success' => false, 'error' => 'Correo electrónico no válido']);
        exit;
    }

    // Verificar que el nombre de usuario y correo electrónico no existan
    if (usuarioExiste($username) || emailExiste($email)) {
        echo json_encode(['success' => false, 'error' => 'Nombre de usuario o correo ya existen']);
        exit;
    }

    // Hashear la contraseña
    $passwordHash = hashearContraseña($password);

    // Insertar el usuario en la base de datos
    $sql = "INSERT INTO usuarios (nombre_usuario, contrasena_hash, email) VALUES ('$username', '$passwordHash', '$email')";
    $result = dbQueryInsert($sql);

    if ($result > 0) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Error al registrar el usuario']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Método no permitido']);
}

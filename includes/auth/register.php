<?php
require_once '../db/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);
    $email = $_POST['email'];

    // TODO: Validar que el usuario no exista
    // TODO: Validar que el correo no exista y sea válido
    // TODO: Validar y sanitizar los datos de entrada

    $sql = "INSERT INTO usuarios (nombre_usuario, contrasena_hash, email) VALUES ('$username', '$password', '$email')";
    $result = dbQueryInsert($sql);

    if ($result > 0) {
        echo json_encode(['success' => true]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Error al registrar el usuario']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Método no permitido']);
}

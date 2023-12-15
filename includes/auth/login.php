<?php
session_start();
require_once '../db/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "SELECT id_usuario, nombre_usuario, contrasena_hash FROM usuarios WHERE nombre_usuario = '$username'";
    $result = dbQuery($sql);
    if (dbNumRows($result) > 0) {
        $user = dbFetchAssoc($result);
        if (password_verify($password, $user['contrasena_hash'])) {
            $_SESSION['user_id'] = $user['id_usuario'];
            $_SESSION['username'] = $user['nombre_usuario'];
            echo json_encode(['success' => true]);
        } else {
            echo json_encode(['success' => false, 'error' => 'Credenciales inválidas']);
        }
    } else {
        echo json_encode(['success' => false, 'error' => 'Usuario no encontrado']);
    }
} else {
    echo json_encode(['success' => false, 'error' => 'Método no permitido']);
}

<?php
session_start();

if (!isset($_SESSION['user_id'])) {
    // Redirecciona o maneja usuarios no autenticados
    echo json_encode(['authenticated' => false]);
    exit;
}

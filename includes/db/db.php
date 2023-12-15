<?php
// Constantes de conexión a la base de datos
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'rrhh_system');

function openConnection() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    return $conn;
}

function closeConnection($conn) {
    $conn->close();
}

function dbQuery($sql) {
    $conn = openConnection();
    $result = $conn->query($sql);
    closeConnection($conn);
    return $result;
}

function dbQueryInsert($sql) {
    $conn = openConnection();
    $conn->query($sql);
    $affectedRows = $conn->affected_rows;
    closeConnection($conn);
    return $affectedRows;
}

function dbFetchAssoc($result) {
    return $result->fetch_assoc();
}

function dbAffectedRows($conn) {
    return $conn->affected_rows;
}

function dbNumRows($result) {
    return $result->num_rows;
}

function dbFetchAll($result) {
    return $result->fetch_all(MYSQLI_ASSOC);
}

function dbLastInsertId($conn) {
    return $conn->insert_id;
}

function dbError($conn) {
    return $conn->error;
}

function dbPrepare($sql) {
    $conn = openConnection();
    $stmt = $conn->prepare($sql);
    if ($stmt === false) {
        die("Prepared Statement Error: " . dbError($conn));
    }
    closeConnection($conn);
    return $stmt;
}

function dbExecute($stmt, $params) {
    $types = str_repeat('s', count($params));
    $stmt->bind_param($types, ...$params);
    $success = $stmt->execute();
    $result = $stmt->get_result();
    $stmt->close();
    return $success ? $result : false;
}
<?php
require_once 'db/db.php';

//* FUNCIONES ÚTILES PARA EL FUNCIONAMIENTO DEL SISTEMA *//

// Función para verificar una contraseña
function verificarContraseña($contraseña, $hash)
{
    return password_verify($contraseña, $hash);
}

// Función para validar un email
function esEmailValido($email)
{
    return filter_var($email, FILTER_VALIDATE_EMAIL);
}

// Función para hashear una contraseña
function hashearContraseña($contraseña)
{
    return password_hash($contraseña, PASSWORD_DEFAULT);
}

// Función para obtener la fecha y hora actual en formato específico
function fechaHoraActual($formato = 'Y-m-d H:i:s')
{
    return date($formato);
}

// Función para redirigir a otra página
function redireccionar($url)
{
    header("Location: $url");
    exit();
}

// Función para generar un token aleatorio
function generarToken($longitud = 10)
{
    return bin2hex(random_bytes($longitud));
}

// Función para generar un nombre de documento PDF
function generarNombreDocumentoPDF($tipoDocumento, $idEmpleado)
{
    $fecha = date('Ymd');
    return $tipoDocumento . '_' . $idEmpleado . '_' . $fecha . '.pdf';
}

// Funcion para importar datos desde un archivo CSV
function importarDatosDesdeCSV($archivoCSV)
{
    $datos = array();
    if (($handle = fopen($archivoCSV, "r")) !== FALSE) {
        while (($fila = fgetcsv($handle, 1000, ",")) !== FALSE) {
            $datos[] = $fila;
        }
        fclose($handle);
    }
    return $datos;
}


// Función para exportar datos a un archivo CSV
function exportarDatosACSV($datos, $nombreArchivo)
{
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename=' . $nombreArchivo);
    $output = fopen('php://output', 'w');
    foreach ($datos as $fila) {
        fputcsv($output, $fila);
    }
    fclose($output);
}

// TODO: Roles y permisos

// Función para cargar los roles de un usuario
function cargarRoles($idUsuario)
{
    $sql = "SELECT r.nombre_rol FROM roles r JOIN usuarios_roles ur ON r.id_rol = ur.id_rol WHERE ur.id_usuario = $idUsuario";
    $result = dbQuery($sql);
    return dbFetchAll($result);
}

// Función para cargar los permisos de un usuario
function cargarPermisos($idUsuario)
{
    $sql = "SELECT p.nombre_permiso FROM permisos p JOIN roles_permisos rp ON p.id_permiso = rp.id_permiso JOIN usuarios_roles ur ON rp.id_rol = ur.id_rol WHERE ur.id_usuario = $idUsuario";
    $result = dbQuery($sql);
    return dbFetchAll($result);
}

function tieneRol($rol) {
    return in_array($rol, array_column($_SESSION['roles'], 'nombre_rol'));
}

function tienePermiso($permiso) {
    return in_array($permiso, array_column($_SESSION['permisos'], 'nombre_permiso'));
}


//* LÓGICA DE NEGOCIO *//

// Vacaciones
function calcularVacaciones($salarioMensual, $mesesTrabajados)
{
    return ($salarioMensual / 12) * ($mesesTrabajados / 12) * 15;
}


// Aguinaldo
function calcularAguinaldo($salarioMensual, $mesesTrabajados)
{
    return ($salarioMensual / 12) * $mesesTrabajados;
}

// Bono 14
function calcularBono14($salarioMensual, $mesesTrabajados)
{
    return ($salarioMensual / 12) * $mesesTrabajados;
}

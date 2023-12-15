-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS rrhh_system DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE rrhh_system;

-- Crear la tabla de empleados con los campos adicionales
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    dpi VARCHAR(20),
    fecha_nacimiento DATE,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(50),
    id_area INT,
    id_posicion INT,
    id_estado INT,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_area) REFERENCES areas(id_area),
    FOREIGN KEY (id_posicion) REFERENCES posiciones(id_posicion),
    FOREIGN KEY (id_estado) REFERENCES estados_empleado(id_estado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de áreas
CREATE TABLE areas (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nombre_area VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de posiciones
CREATE TABLE posiciones (
    id_posicion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_posicion VARCHAR(50),
    salario_base DECIMAL(10, 2),
    descripcion TEXT,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de asistencias
CREATE TABLE asistencias (
    id_asistencia INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha DATE,
    hora_entrada TIME,
    hora_salida TIME,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de vacaciones
CREATE TABLE vacaciones (
    id_vacaciones INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    dias_tomados INT,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de evaluaciones de desempeño
CREATE TABLE evaluaciones_desempeno (
    id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha_evaluacion DATE,
    puntuacion INT,
    comentarios TEXT,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de estados de empleado
CREATE TABLE estados_empleado (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de llamadas de atención
CREATE TABLE llamadas_atencion (
    id_llamada INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    fecha DATE,
    motivo TEXT,
    acciones_tomadas TEXT,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de usuarios
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50),
    contrasena_hash VARCHAR(255),
    email VARCHAR(100),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de roles
CREATE TABLE roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de permisos
CREATE TABLE permisos (
    id_permiso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_permiso VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de relación entre usuarios y roles
CREATE TABLE usuarios_roles (
    id_usuario INT,
    id_rol INT,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol)
);

-- Crear la tabla de relación entre roles y permisos
CREATE TABLE roles_permisos (
    id_rol INT,
    id_permiso INT,
    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso)
);

-- Crear la tabla de adelantos de salario
CREATE TABLE adelantos_salario (
    id_adelanto INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    monto DECIMAL(10, 2),
    fecha_solicitud DATE,
    fecha_pago DATE,
    estado VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de registro de salarios
CREATE TABLE registro_salarios (
    id_registro_salario INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    salario DECIMAL(10, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de multas
CREATE TABLE multas (
    id_multa INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT,
    monto DECIMAL(10, 2),
    motivo TEXT,
    fecha_multa DATE,
    estado VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modifica INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id_usuario)
);
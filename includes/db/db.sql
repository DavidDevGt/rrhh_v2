-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS rrhh_system DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE rrhh_system;

-- Crear la tabla de empleados con los campos adicionales
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    dpi VARCHAR(20) NOT NULL UNIQUE,
    fecha_nacimiento DATE NOT NULL,
    direccion VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(50) NOT NULL UNIQUE,
    id_area INT NOT NULL,
    id_posicion INT NOT NULL,
    id_estado INT NOT NULL,
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion INT,
    FOREIGN KEY (id_area) REFERENCES areas(id_area),
    FOREIGN KEY (id_posicion) REFERENCES posiciones(id_posicion),
    FOREIGN KEY (id_estado) REFERENCES estados_empleado(id_estado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de áreas
CREATE TABLE areas (
    id_area INT AUTO_INCREMENT PRIMARY KEY,
    nombre_area VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion INT,
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    usuario_modificacion INT,
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    usuario_modificacion INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    usuario_modificacion INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    usuario_modificacion INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
);

-- Crear la tabla de estados de empleado
CREATE TABLE estados_empleado (
    id_estado INT AUTO_INCREMENT PRIMARY KEY,
    estado VARCHAR(50),
    activo TINYINT DEFAULT 1 NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    usuario_modificacion INT,
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    usuario_modificacion INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    descripcion VARCHAR(255),
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
    usuario_modificacion INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    usuario_modificacion INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
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
    usuario_modificacion INT,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    FOREIGN KEY (usuario_modificacion) REFERENCES usuarios(id_usuario)
);

-- Índice para búsqueda por nombre y apellido en la tabla de empleados
ALTER TABLE empleados ADD INDEX idx_nombre_apellido (nombre, apellido);

-- Índice para filtrado por área y posición
ALTER TABLE empleados ADD INDEX idx_area_posicion (id_area, id_posicion);

-- Índice para optimizar las consultas en la tabla de asistencias
ALTER TABLE asistencias ADD INDEX idx_fecha (fecha);

-- Índice para la tabla de vacaciones
ALTER TABLE vacaciones ADD INDEX idx_fecha_inicio_fin (fecha_inicio, fecha_fin);

-- Vista para informe de asistencia de empleados
CREATE VIEW vista_asistencia AS
SELECT e.nombre, e.apellido, a.fecha, a.hora_entrada, a.hora_salida
FROM empleados e
JOIN asistencias a ON e.id_empleado = a.id_empleado;

-- Vista para informe de evaluaciones de desempeño
CREATE VIEW vista_evaluaciones AS
SELECT e.nombre, e.apellido, ed.fecha_evaluacion, ed.puntuacion
FROM empleados e
JOIN evaluaciones_desempeno ed ON e.id_empleado = ed.id_empleado;

-- Vista para informe de vacaciones
CREATE VIEW vista_vacaciones AS
SELECT e.nombre, e.apellido, v.fecha_inicio, v.fecha_fin, v.dias_tomados
FROM empleados e
JOIN vacaciones v ON e.id_empleado = v.id_empleado;

-- Vista para informe de salarios
CREATE VIEW vista_salarios AS
SELECT e.nombre, e.apellido, rs.salario, rs.fecha_inicio, rs.fecha_fin
FROM empleados e
JOIN registro_salarios rs ON e.id_empleado = rs.id_empleado;

-- Vista para adelantos de salario
CREATE VIEW vista_adelantos_salario AS
SELECT 
    e.nombre, e.apellido, ad.monto, ad.fecha_solicitud, ad.fecha_pago, ad.estado
FROM empleados e
JOIN adelantos_salario ad ON e.id_empleado = ad.id_empleado;

-- Vista para llamadas de atención de empleados a detalle
CREATE VIEW vista_llamadas_atencion_detalle AS
SELECT 
    e.id_empleado, e.nombre, e.apellido, l.fecha, l.motivo, l.acciones_tomadas
FROM empleados e
JOIN llamadas_atencion l ON e.id_empleado = l.id_empleado;

-- Configuración de lógica de negocio

INSERT INTO permisos (nombre_permiso, descripcion) VALUES 
('lectura', 'Permiso para leer datos'),
('escritura', 'Permiso para escribir datos'),
('edicion', 'Permiso para editar datos'),
('eliminacion', 'Permiso para eliminar datos');

INSERT INTO estados_empleado (estado) VALUES 
('activo'), 
('suspendido'),
('capacitacion'), 
('finalizado');

INSERT INTO roles (nombre_rol) VALUES 
('Administrador'), 
('Gerente'), 
('Empleado');

-- Insertar usuarios de prueba
INSERT INTO usuarios (nombre_usuario, contrasena_hash, email, activo) VALUES 
('admin', 'password123', 'admin@example.com', 1),
('gerente', 'password123', 'gerente@example.com', 1),
('empleado', 'password123', 'empleado@example.com', 1);

-- Obtener los ID de roles para referencia, aunque ya van ordenados creo :v
SELECT id_rol FROM roles WHERE nombre_rol IN ('Administrador', 'Gerente', 'Empleado');

-- Asociar cada usuario con un rol
INSERT INTO usuarios_roles (id_usuario, id_rol) VALUES 
((SELECT id_usuario FROM usuarios WHERE nombre_usuario = 'admin'), 1),
((SELECT id_usuario FROM usuarios WHERE nombre_usuario = 'gerente'), 2),
((SELECT id_usuario FROM usuarios WHERE nombre_usuario = 'empleado'), 3);

INSERT INTO roles_permisos (id_rol, id_permiso) VALUES 
(1, 1), -- Administrador tiene permiso de lectura
(1, 2), -- Administrador tiene permiso de escritura
(1, 3), -- Administrador tiene permiso de edición
(1, 4); -- Administrador tiene permiso de eliminación

-- Asignar permisos específicos a otros roles
-- Por ejemplo, el rol de Gerente (id_rol = 2) solo tiene permisos de lectura y edición
INSERT INTO roles_permisos (id_rol, id_permiso) VALUES 
(2, 1), -- Gerente tiene permiso de lectura
(2, 2), -- Gerente tiene permiso de escritura
(2, 3); -- Gerente tiene permiso de edición

-- Asignar permisos al rol de Empleado (id_rol = 3) solo permiso de lectura
INSERT INTO roles_permisos (id_rol, id_permiso) VALUES 
(3, 1); -- Empleado tiene permiso de lectura
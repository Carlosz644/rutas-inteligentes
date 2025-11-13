-- ============================================
-- PROYECTO: RUTAS DE ENTREGA - ESQUEMA
-- Archivo 1/2: Creación de tablas y estructura
-- ============================================

-- 1️⃣ Crear base de datos y usarla
DROP DATABASE IF EXISTS ruta_de_entrega;
CREATE DATABASE ruta_de_entrega;
USE ruta_de_entrega;

-- 2️⃣ Tabla: CLIENTES
CREATE TABLE clientes (
id_cliente INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
direccion VARCHAR(200),
telefono VARCHAR(20),
correo VARCHAR(100),
latitud DECIMAL(10,7),
longitud DECIMAL(10,7)
);

-- 3️⃣ Tabla: CONDUCTORES
CREATE TABLE conductores (
id_conductor INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
telefono VARCHAR(20),
licencia VARCHAR(50)
);

-- 4️⃣ Tabla: VEHÍCULOS
CREATE TABLE vehiculos (
id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
marca VARCHAR(50),
modelo VARCHAR(50),
placas VARCHAR(20),
capacidad INT
);

-- 5️⃣ Tabla: RUTAS
CREATE TABLE rutas (
id_ruta INT AUTO_INCREMENT PRIMARY KEY,
nombre_ruta VARCHAR(100),
id_conductor INT,
id_vehiculo INT,
fecha DATE,
FOREIGN KEY (id_conductor) REFERENCES conductores(id_conductor),
FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo)
);

-- 6️⃣ Tabla: ENTREGAS
CREATE TABLE entregas (
id_entrega INT AUTO_INCREMENT PRIMARY KEY,
id_ruta INT,
id_cliente INT,
estado ENUM('pendiente','en camino','entregado','retrasado') DEFAULT 'pendiente',
fecha_entrega DATE,
hora_entrega TIME,
observaciones TEXT,
FOREIGN KEY (id_ruta) REFERENCES rutas(id_ruta),
FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- 7️⃣ Tabla: PAQUETES
CREATE TABLE paquetes (
id_paquete INT AUTO_INCREMENT PRIMARY KEY,
id_entrega INT,
descripcion VARCHAR(200),
peso DECIMAL(10,2),
valor DECIMAL(10,2),
FOREIGN KEY (id_entrega) REFERENCES entregas(id_entrega)
);

-- 8️⃣ Tabla: SEGUIMIENTO
CREATE TABLE seguimiento (
id_seguimiento INT AUTO_INCREMENT PRIMARY KEY,
id_entrega INT,
fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
estado ENUM('pendiente','en camino','entregado','retrasado'),
comentario TEXT,
FOREIGN KEY (id_entrega) REFERENCES entregas(id_entrega)
);
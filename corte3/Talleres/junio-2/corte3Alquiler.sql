CREATE SCHEMA alquiler;
CREATE SCHEMA mantenimiento;

CREATE TABLE alquiler.cliente (
    id_cliente SERIAL PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE alquiler.categoria (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(50) NOT NULL
);

CREATE TABLE mantenimiento.estado_equipo (
    id_estado_equipo SERIAL PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL
);

CREATE TABLE alquiler.producto (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio_alquiler DECIMAL(10, 2) NOT NULL,
    id_categoria INTEGER NOT NULL,
    id_estado_equipo INTEGER NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES alquiler.categoria(id_categoria),
    FOREIGN KEY (id_estado_equipo) REFERENCES mantenimiento.estado_equipo(id_estado_equipo)
);

CREATE TABLE alquiler.alquiler (
    id_alquiler SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin_estimada DATE NOT NULL,
    fecha_entrega_real DATE,
    observaciones TEXT,
    FOREIGN KEY (id_cliente) REFERENCES alquiler.cliente(id_cliente)
);

CREATE TABLE alquiler.producto_alquiler (
    id_producto_alquiler SERIAL PRIMARY KEY,
    id_alquiler INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    precio_unitario_alquiler DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_alquiler) REFERENCES alquiler.alquiler(id_alquiler),
    FOREIGN KEY (id_producto) REFERENCES alquiler.producto(id_producto)
);

CREATE TABLE alquiler.devolucion (
    id_devolucion SERIAL PRIMARY KEY,
    id_alquiler INTEGER NOT NULL,
    fecha_devolucion DATE NOT NULL,
    condicion_devolucion TEXT,
    observaciones TEXT,
    FOREIGN KEY (id_alquiler) REFERENCES alquiler.alquiler(id_alquiler)
);

CREATE TABLE alquiler.pago (
    id_pago SERIAL PRIMARY KEY,
    id_alquiler INTEGER NOT NULL,
    fecha_pago TIMESTAMP NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    referencia_pago VARCHAR(100),
    FOREIGN KEY (id_alquiler) REFERENCES alquiler.alquiler(id_alquiler)
);

CREATE TABLE alquiler.disponibilidad (
    id_disponibilidad SERIAL PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    fecha_inicio_disponibilidad DATE NOT NULL,
    fecha_fin_disponibilidad DATE NOT NULL,
    estado_disponibilidad VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES alquiler.producto(id_producto)
);

CREATE TABLE mantenimiento.reporte_de_danos (
    id_reporte_danio SERIAL PRIMARY KEY,
    id_devolucion INTEGER NOT NULL,
    id_producto INTEGER NOT NULL,
    descripcion_danio TEXT NOT NULL,
    costo_reparacion_estimado DECIMAL(10, 2),
    FOREIGN KEY (id_devolucion) REFERENCES alquiler.devolucion(id_devolucion),
    FOREIGN KEY (id_producto) REFERENCES alquiler.producto(id_producto)
);

CREATE TABLE mantenimiento.mantenimiento (
    id_mantenimiento SERIAL PRIMARY KEY,
    id_producto INTEGER NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    descripcion TEXT NOT NULL,
    costo DECIMAL(10, 2),
    FOREIGN KEY (id_producto) REFERENCES alquiler.producto(id_producto)
);


INSERT INTO alquiler.cliente (cedula, nombre, direccion, telefono, email)
VALUES ('123456789', 'Juan Perez', 'Calle 123, Ciudad', '555-1234', 'juan.perez@email.com');

INSERT INTO alquiler.cliente (cedula, nombre, direccion, telefono, email)
VALUES ('987654321', 'Maria Rodriguez', 'Avenida 456, Otra Ciudad', '555-5678', 'maria.rodriguez@email.com');



INSERT INTO alquiler.categoria (nombre_categoria)
VALUES ('Cámaras');

INSERT INTO alquiler.categoria (nombre_categoria)
VALUES ('Iluminación');

INSERT INTO alquiler.categoria (nombre_categoria)
VALUES ('Sonido');




INSERT INTO mantenimiento.estado_equipo (nombre_estado)
VALUES ('Disponible');

INSERT INTO mantenimiento.estado_equipo (nombre_estado)
VALUES ('Alquilado');

INSERT INTO mantenimiento.estado_equipo (nombre_estado)
VALUES ('En Mantenimiento');




INSERT INTO alquiler.producto (nombre, descripcion, precio_alquiler, id_categoria, id_estado_equipo)
VALUES ('Cámara DSLR', 'Cámara profesional de alta resolución', 50.00, 1, 1);

INSERT INTO alquiler.producto (nombre, descripcion, precio_alquiler, id_categoria, id_estado_equipo)
VALUES ('Lente 50mm', 'Lente fijo de 50mm para retratos', 20.00, 1, 1);

INSERT INTO alquiler.producto (nombre, descripcion, precio_alquiler, id_categoria, id_estado_equipo)
VALUES ('Trípode', 'Trípode robusto para cámara', 15.00, 1, 1);

INSERT INTO alquiler.producto (nombre, descripcion, precio_alquiler, id_categoria, id_estado_equipo)
VALUES ('Foco LED', 'Foco LED de alta potencia', 30.00, 2, 1);




INSERT INTO alquiler.alquiler (id_cliente, fecha_inicio, fecha_fin_estimada, fecha_entrega_real, observaciones)
VALUES (1, '2024-07-15', '2024-07-20', NULL, 'Alquiler para evento');

INSERT INTO alquiler.alquiler (id_cliente, fecha_inicio, fecha_fin_estimada, fecha_entrega_real, observaciones)
VALUES (2, '2024-07-22', '2024-07-25', NULL, 'Alquiler para filmación');




INSERT INTO alquiler.producto_alquiler (id_alquiler, id_producto, cantidad, precio_unitario_alquiler)
VALUES (1, 1, 1, 50.00);

INSERT INTO alquiler.producto_alquiler (id_alquiler, id_producto, cantidad, precio_unitario_alquiler)
VALUES (1, 2, 1, 20.00);

INSERT INTO alquiler.producto_alquiler (id_alquiler, id_producto, cantidad, precio_unitario_alquiler)
VALUES (2, 3, 1, 15.00);

INSERT INTO alquiler.producto_alquiler (id_alquiler, id_producto, cantidad, precio_unitario_alquiler)
VALUES (2, 4, 2, 30.00);





INSERT INTO alquiler.devolucion (id_alquiler, fecha_devolucion, condicion_devolucion, observaciones)
VALUES (1, '2024-07-20', 'Equipo en buen estado', 'Sin problemas');

INSERT INTO alquiler.devolucion (id_alquiler, fecha_devolucion, condicion_devolucion, observaciones)
VALUES (2, '2024-07-25', 'Foco con un golpe menor', 'Se reportó el daño');





INSERT INTO alquiler.pago (id_alquiler, fecha_pago, metodo_pago, monto, referencia_pago)
VALUES (1, '2024-07-15 10:00:00', 'Tarjeta de Crédito', 70.00, 'TRANSACCION123');

INSERT INTO alquiler.pago (id_alquiler, fecha_pago, metodo_pago, monto, referencia_pago)
VALUES (2, '2024-07-22 14:30:00', 'Efectivo', 75.00, NULL);




INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (1, '2024-07-01', '2024-07-14', 'Disponible');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (1, '2024-07-15', '2024-07-20', 'Alquilado');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (1, '2024-07-21', '2024-07-31', 'Disponible');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (2, '2024-07-01', '2024-07-14', 'Disponible');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (2, '2024-07-15', '2024-07-20', 'Alquilado');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (2, '2024-07-21', '2024-07-31', 'Disponible');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (3, '2024-07-01', '2024-07-21', 'Disponible');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (3, '2024-07-22', '2024-07-25', 'Alquilado');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (3, '2024-07-26', '2024-07-31', 'Disponible');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (4, '2024-07-01', '2024-07-21', 'Disponible');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (4, '2024-07-22', '2024-07-25', 'Alquilado');

INSERT INTO alquiler.disponibilidad (id_producto, fecha_inicio_disponibilidad, fecha_fin_disponibilidad, estado_disponibilidad)
VALUES (4, '2024-07-26', '2024-07-31', 'Disponible');





INSERT INTO mantenimiento.reporte_de_danos (id_devolucion, id_producto, descripcion_danio, costo_reparacion_estimado)
VALUES (2, 4, 'Golpe en la carcasa', 10.00);




INSERT INTO mantenimiento.mantenimiento (id_producto, fecha_inicio, fecha_fin, descripcion, costo)
VALUES (1, '2024-08-01', '2024-08-02', 'Limpieza de sensor', 25.00);

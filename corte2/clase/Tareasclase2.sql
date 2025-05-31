-- Tabla de usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de tareas
CREATE TABLE tareas (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    estado VARCHAR(50) DEFAULT 'pendiente', -- pendiente, en_progreso, completada
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_limite DATE,
    usuario_id INTEGER REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Insertar un usuario
INSERT INTO usuarios (nombre, email)
VALUES ('Juan Pérez', 'juan@example.com');

-- Insertar una tarea
INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_id)
VALUES (
    'Terminar reporte mensual',
    'Preparar y enviar el reporte mensual de ventas.',
    '2025-05-20',
    1
);
INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_id)
VALUES (
    'Terminar reporte anual',
    'Preparar y enviar el reporte anual de ventas.',
    '2025-05-20',
    1
);
INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_id)
VALUES (
    'Terminar PIB',
    'Preparar y enviar el reporte mensual de ventas.',
    '2025-05-20',
    1
);


INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_id)
VALUES (
    'estudios',
    'Preparar y enviar el reporte mensual de ventas.',
    '2025-05-20',
    1
);
-- Tabla de prioridades
CREATE TABLE prioridades (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(20) UNIQUE NOT NULL
);

-- Insertar valores comunes
INSERT INTO prioridades (nombre) VALUES ('baja'), ('media'), ('alta');

-- Modificar la tabla tareas para agregar columna de prioridad
ALTER TABLE tareas ADD COLUMN prioridad_id INTEGER REFERENCES prioridades(id);



-- Tabla de etiquetas
CREATE TABLE etiquetas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

-- Tabla intermedia tareas-etiquetas (muchos a muchos)
CREATE TABLE tareas_etiquetas (
    tarea_id INTEGER REFERENCES tareas(id) ON DELETE CASCADE,
    etiqueta_id INTEGER REFERENCES etiquetas(id) ON DELETE CASCADE,
    PRIMARY KEY (tarea_id, etiqueta_id)
);


CREATE TABLE comentarios (
    id SERIAL PRIMARY KEY,
    contenido TEXT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tarea_id INTEGER REFERENCES tareas(id) ON DELETE CASCADE,
    usuario_id INTEGER REFERENCES usuarios(id) ON DELETE SET NULL
);


INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_id,prioridad_id)
VALUES (
    'ventas',
    'Preparar y enviar el reporte mensual de ventas.',
    '2025-05-20',
    1,
    3
);

INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_id,prioridad_id)
VALUES (
    'zapatos',
    'Preparar y enviar el reporte mensual de ventas.',
    '2025-05-20',
    1,
    3
);

create view tarea3 as select estado, titulo from tareas limit 2


create view tareaAlta2 as select p.nombre, titulo from tareas join 
prioridades p on p.id = prioridad_id
where prioridad_id = 3 limit 2


--aqui se tendria que entrar a la vista para que funcione la consulta
select * from tarea3

select * from tareaalta2

drop view tareaalta



create materialized view test
as 
select titulo, estado from tareas 



select * from test

INSERT INTO tareas (titulo, descripcion, fecha_limite, usuario_id,prioridad_id)
VALUES (
    'carrasos',
    'Preparar y enviar el reporte mensual de ventas.',
    '2025-05-20',
    1,
    3
);



refresh materialized test [concurrentry] 
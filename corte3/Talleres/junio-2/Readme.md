¿QUE SON LOS DISPARADORES?
Un disparador (trigger) en una base de datos es un procedimiento almacenado que se ejecuta automáticamente en respuesta a un evento específico, como una inserción, actualización o eliminación de datos en una tabla.



¿PARA QUE SIRVEN?
Los disparadores son útiles para automatizar tareas, mantener la integridad de los datos y auditar cambios. 



VENTAJAS Y DESVENTAJAS

entre las ventajas incluyen:
-la automatización de tareas, 
-la mejora de la integridad de los datos, 
-el tratamiento de errores 
-el registro de eventos

entre las desventajas incluyen: 
-la sobrecarga de rendimiento, 
-la complejidad en la resolución de problemas 
-el riesgo de bucles infinitos



SINTAXIS DE LOS DISPARADORES
CREATE [ CONSTRAINT ] TRIGGER nombre_del_disparador
{ BEFORE | AFTER | INSTEAD OF } { evento [ OR ... ] }
ON nombre_de_la_tabla
[ FOR [ EACH ] { ROW | STATEMENT } ]
[ WHEN ( condición ) ]
EXECUTE PROCEDURE nombre_de_la_función ( argumentos );



COMO SE UTILIZAN LOS DISPARADORES
Los disparadores se utilizan para automatizar ciertas acciones en respuesta a eventos que ocurren en una tabla. Algunos casos de uso comunes incluyen:
-Auditoría: Registrar cambios en los datos (quién, qué y cuándo se modificó).
-Validación de datos compleja: Realizar comprobaciones que van más allá de las restricciones CHECK.
-Generación de valores derivados: Calcular y actualizar automáticamente campos basados en otros datos.
-Mantenimiento de la integridad referencial: Implementar acciones personalizadas cuando se modifican tablas relacionadas (aunque las restricciones FOREIGN KEY suelen ser preferibles para esto).
-Notificaciones: Enviar alertas o iniciar otros procesos basados en cambios en los datos.
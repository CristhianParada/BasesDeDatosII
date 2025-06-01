--DISPARADORES
--Caso de Uso 1:  Mantener un Log de Observaciones en Alquileres

--Problema: Actualmente, la tabla alquiler tiene un campo observaciones de tipo TEXT.
--Si se modifica esta columna, no hay un historial de quién hizo el cambio ni cuándo.
--Solución: Crear un trigger que, cada vez que se actualice la columna observaciones
--en la tabla alquiler, añada la nueva observación a la existente, junto con una marca 
--de tiempo y el usuario (si tienes un sistema de usuarios en tu aplicación).

CREATE OR REPLACE FUNCTION alquiler.agregar_observacion_alquiler()
   RETURNS TRIGGER AS $$
   BEGIN
       IF TG_OP = 'UPDATE' AND OLD.observaciones IS DISTINCT FROM NEW.observaciones THEN
           NEW.observaciones = OLD.observaciones || '\n' ||
                                  '[' || current_timestamp || '] Usuario: ' || current_user || ': ' || NEW.observaciones;
       END IF;
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;
   
CREATE TRIGGER tr_alquiler_update_observaciones
   BEFORE UPDATE ON alquiler.alquiler
   FOR EACH ROW
   EXECUTE FUNCTION alquiler.agregar_observacion_alquiler();
   
   
   
   --aqui se hace una prueba para ver el funcionamiento del trigger
   UPDATE alquiler.alquiler
SET observaciones = 'Se ajustó la fecha de entrega con el cliente.'
WHERE id_alquiler = 1;


--aqui seleccionamos el registro que se modifico para poder visualizar el cambio hecho
SELECT observaciones FROM alquiler.alquiler WHERE id_alquiler = 1;

--respuesta ESPERADA
--Alquiler para evento\n[2025-05-31 16:11:26.598067-05] Usuario: postgres: Se ajustó la fecha de entrega con el cliente.



------------------------------------------------------------------------------------------------------------------------------------

--Caso de Uso 2:  Controlar la Fecha de Entrega Real en Alquiler

--Problema: La columna fecha_entrega_real en la tabla alquiler 
--podría ser modificada incorrectamente (ej., poniéndole una fecha anterior a la fecha_inicio).
--Solución: Crear un trigger que, al actualizar la tabla alquiler,verifique que la fecha_entrega_real
--(si se está actualizando) sea mayor o igual que la fecha_inicio. Si no lo es,
--impide la actualización. En este caso, la impediremos para mantener la integridad.

CREATE OR REPLACE FUNCTION alquiler.validar_fecha_entrega_alquiler()
   RETURNS TRIGGER AS $$
   BEGIN
       IF TG_OP = 'UPDATE' AND NEW.fecha_entrega_real IS NOT NULL AND NEW.fecha_entrega_real < NEW.fecha_inicio THEN
           RAISE EXCEPTION 'La fecha de entrega real no puede ser anterior a la fecha de inicio';
       END IF;
       RETURN NEW;
   END;
   $$ LANGUAGE plpgsql;
   
CREATE TRIGGER tr_alquiler_update_fecha_entrega
   BEFORE UPDATE ON alquiler.alquiler
   FOR EACH ROW
   EXECUTE FUNCTION alquiler.validar_fecha_entrega_alquiler();

   
   
--UPDATE alquiler.alquiler
--SET fecha_entrega_real = '2024-01-05'  --  Fecha inválida (anterior a fecha_inicio)
--WHERE id_alquiler = 1;   


--en este punto tiene que salir una excepcion porque el disparador se activa y verifca que la fecha sea mayor a fecha inicio
--y en este caso se contradice y por ende se manda esto 
--SQL Error [P0001]: ERROR: La fecha de entrega real no puede ser anterior a la fecha de inicio





------------------------------------------------------------------------------------------------------------------------------------
--Caso de uso 3: Hacer un control automatico sobre el registro del pago
--Problema: No hay un control automático sobre la creación de registros de pago.

--Solución: Crear un trigger que verifique que el monto del pago no sea negativo.

CREATE OR REPLACE FUNCTION alquiler.validar_monto_pago()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.monto < 0 THEN
        RAISE EXCEPTION 'El monto del pago no puede ser negativo.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tr_pago_insert
BEFORE INSERT
ON alquiler.pago
FOR EACH ROW
EXECUTE FUNCTION alquiler.validar_monto_pago();

--entonces este disparador valida de que el monto sea positivo o sino mandara el mensaje de exception 
--ERROR: El monto del pago no puede ser negativo.
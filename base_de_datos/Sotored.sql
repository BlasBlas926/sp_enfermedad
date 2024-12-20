CREATE OR REPLACE FUNCTION schemasye.obtener_todos_enfermedades(
	)
    RETURNS TABLE(id_enf_cronica integer, nombre character varying, descripcion character varying, fecha_registro date, fecha_inicio date, estado boolean, fecha_actualizacion date) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT t.id_enf_cronica, t.nombre, t.descripcion, t.fecha_registro, t.fecha_inicio, t.estado, t.fecha_actualizacion
    FROM schemasye."tc_enfermedad_cronica" t
    WHERE t.estado = TRUE
    ORDER BY t.id_enf_cronica ASC;
END;
$BODY$;

ALTER FUNCTION schemasye.obtener_todos_enfermedades()
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION schemasye.agregar_enfermedad(
	p_nombre character varying,
	p_descripcion character varying,
	p_fecha_registro date,
	p_fecha_inicio date,
	p_estado boolean,
	p_fecha_actualizacion date)
    RETURNS TABLE(id_enf_cronica integer, nombre character varying, descripcion character varying, fecha_registro date, fecha_inicio date, estado boolean, fecha_actualizacion date) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    INSERT INTO schemasye."tc_enfermedad_cronica" 
        (nombre, descripcion, fecha_registro, fecha_inicio, estado, fecha_actualizacion)
    VALUES
        (p_nombre, p_descripcion, p_fecha_registro, p_fecha_inicio, p_estado, p_fecha_actualizacion);
END;
$BODY$;

ALTER FUNCTION schemasye.agregar_enfermedad(character varying, character varying, date, date, boolean, date)
    OWNER TO postgres;



CREATE OR REPLACE FUNCTION schemasye.actualizar_enfermedad(
	p_id_enf_cronica integer,
	p_nombre character varying,
	p_descripcion character varying,
	p_fecha_registro date,
	p_fecha_inicio date,
	p_estado boolean,
	p_fecha_actualizacion date)
    RETURNS TABLE(id_enf_cronica integer, nombre character varying, descripcion character varying, fecha_registro date, fecha_inicio date, estado boolean, fecha_actualizacion date) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    UPDATE schemasye."tc_enfermedad_cronica" AS ec
    SET 
        nombre = p_nombre,
        descripcion = p_descripcion,
        fecha_inicio = p_fecha_inicio,
        fecha_registro = p_fecha_registro,
        estado = p_estado,
        fecha_actualizacion = p_fecha_actualizacion
    WHERE ec.id_enf_cronica = p_id_enf_cronica;
END;
$BODY$;

ALTER FUNCTION schemasye.actualizar_enfermedad(integer, character varying, character varying, date, date, boolean, date)
    OWNER TO postgres;

	CREATE OR REPLACE FUNCTION schemasye.borrar_enfermedad(
	p_id_enf_cronica integer)
    RETURNS TABLE(id_enf_cronica integer, nombre character varying, descripcion character varying, fecha_registro date, fecha_inicio date, estado boolean, fecha_actualizacion date) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    -- Actualizamos el estado de la enfermedad crónica y retornamos las tuplas afectadas
    RETURN QUERY
    UPDATE schemasye."tc_enfermedad_cronica" AS ec
    SET 
        estado = FALSE,
        fecha_actualizacion = CURRENT_DATE
    WHERE ec.id_enf_cronica = p_id_enf_cronica
    RETURNING 
        ec.id_enf_cronica, 
        ec.nombre, 
        ec.descripcion, 
        ec.fecha_registro, 
        ec.fecha_inicio, 
        ec.estado, 
        ec.fecha_actualizacion;
END;
$BODY$;

ALTER FUNCTION schemasye.borrar_enfermedad(integer)
    OWNER TO postgres;

CREATE OR REPLACE FUNCTION schemasye.obtener_id_enfermedad(
	p_id_enf_cronica integer)
    RETURNS TABLE(id_enf_cronica integer, nombre character varying, descripcion character varying, fecha_registro date, fecha_inicio date, estado boolean, fecha_actualizacion date) 
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
    ROWS 1000

AS $BODY$
BEGIN
    RETURN QUERY 
    SELECT t.id_enf_cronica, t.nombre, t.descripcion, t.fecha_registro, t.fecha_inicio, t.estado, t.fecha_actualizacion
    FROM schemasye."tc_enfermedad_cronica" t
    WHERE t.id_enf_cronica = p_id_enf_cronica;
END;
$BODY$;

ALTER FUNCTION schemasye.obtener_id_enfermedad(integer)
    OWNER TO postgres;
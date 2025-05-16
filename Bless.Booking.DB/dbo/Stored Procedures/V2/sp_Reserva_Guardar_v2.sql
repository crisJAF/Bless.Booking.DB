CREATE PROCEDURE [dbo].[sp_Reserva_Guardar_v2]
	@Nombre NVARCHAR(100),
    @Telefono NVARCHAR(20),
    @Correo NVARCHAR(100),
    @BarberoId INT,
    @ServicioId INT,
    @BarberoHorarioAtencionID INT,
    @Fecha DATE,
    @Hora TIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --TODO: Validar si el cliente existe
        -- Insertar Cliente
        INSERT INTO Cliente (Nombre, Telefono, Correo)
        VALUES (@Nombre, @Telefono, @Correo);

        DECLARE @ClienteId INT = SCOPE_IDENTITY();

        --TODO: Validar si el horario de atencion existe y esta disponible
        IF EXISTS ( SELECT 1 FROM ReservasV2 WHERE BarberoHorarioAtencionID = @BarberoHorarioAtencionID  AND Fecha = @Fecha AND Hora = @Hora)
            PRINT 'Horario ocupado';
        ELSE
            -- Insertar Reserva
            INSERT INTO ReservasV2(ClienteId, BarberoId, ServicioId, BarberoHorarioAtencionID, Fecha, Hora)
            VALUES (@ClienteId, @BarberoId, @ServicioId, @BarberoHorarioAtencionID, @Fecha, @Hora);


        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END;
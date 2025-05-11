CREATE PROCEDURE [dbo].[sp_Reserva_Guardar]
	@ClienteId INT,
    @BarberoId INT,
    @ServicioId INT,
    @Fecha DATE,
    @Hora TIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar reserva
        INSERT INTO Reservas (ClienteId, BarberoId, ServicioId, Fecha, Hora)
        VALUES (@ClienteId, @BarberoId, @ServicioId, @Fecha, @Hora);

        -- Marcar horario como no disponible
        UPDATE HorariosDisponibles
        SET Disponible = 0
        WHERE BarberoId = @BarberoId AND Fecha = @Fecha AND Hora = @Hora;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END;
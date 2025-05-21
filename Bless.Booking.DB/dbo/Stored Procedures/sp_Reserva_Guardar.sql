CREATE PROCEDURE [dbo].[sp_Reserva_Guardar]
    @Nombre NVARCHAR(100),
    @Telefono NVARCHAR(20),
    @Correo NVARCHAR(100),
    @BarberoId INT,
    @ServicioId INT,
    @Fecha DATE,
    @Hora TIME
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DiaSemana INT = DATEPART(WEEKDAY, @Fecha);

    -- Para asegurar que 2 = lunes (y 1 = domingo)
    SET DATEFIRST 7;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validar que el barbero atiende en ese día y hora
        IF NOT EXISTS (
            SELECT 1
            FROM BarberoHorario
            WHERE BarberoID = @BarberoId
              AND Dia = @DiaSemana
              AND @Hora >= HoraInicio
              AND DATEADD(MINUTE, DuracionCupoMinutos, @Hora) <= HoraFin
              AND Estado = 1
        )
        BEGIN
            RAISERROR('El barbero no atiende en ese horario.', 16, 1);
            ROLLBACK;
            RETURN;
        END

        -- Validar que el horario no esté ocupado
        IF EXISTS (
            SELECT 1
            FROM Reserva
            WHERE BarberoID = @BarberoId
              AND Fecha = @Fecha
              AND Hora = @Hora
        )
        BEGIN
            RAISERROR('Ese horario ya está reservado.', 16, 1);
            ROLLBACK;
            RETURN;
        END

        -- Insertar cliente
        INSERT INTO Cliente (Nombre, Telefono, Correo)
        VALUES (@Nombre, @Telefono, @Correo);

        DECLARE @ClienteId INT = SCOPE_IDENTITY();

        -- Insertar reserva
        INSERT INTO Reserva (ClienteId, BarberoId, ServicioId, Fecha, Hora)
        VALUES (@ClienteId, @BarberoId, @ServicioId, @Fecha, @Hora);

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH
END;
CREATE OR ALTER PROCEDURE [dbo].[sp_Reserva_Guardar]
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

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insertar Cliente
        INSERT INTO Clientes (Nombre, Telefono, Correo)
        VALUES (@Nombre, @Telefono, @Correo);

        DECLARE @ClienteId INT = SCOPE_IDENTITY();

        -- Insertar Reserva
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
CREATE PROCEDURE [dbo].[sp_ObtenerReservasPorFecha]
    @Fecha DATE,
    @BarberoId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        reserva.ReservaId,
        cliente.Nombre AS NombreCliente,
        barbero.Nombre AS NombreBarbero,
        servicio.Nombre AS NombreServicio,
        reserva.Fecha,
        reserva.Hora,
        reserva.Estado
    FROM [dbo].[Reservas] AS reserva
    INNER JOIN [dbo].[Cliente] AS cliente
        ON cliente.ClienteId = reserva.ClienteId
    INNER JOIN [dbo].[Barbero] AS barbero
        ON barbero.BarberoId = reserva.BarberoId
    INNER JOIN [dbo].[Servicio] AS servicio
        ON servicio.ServicioId = reserva.ServicioId
    WHERE reserva.Fecha = @Fecha
      AND (@BarberoId IS NULL OR @BarberoId = 0 OR reserva.BarberoId = @BarberoId)
    ORDER BY reserva.Hora;
END;

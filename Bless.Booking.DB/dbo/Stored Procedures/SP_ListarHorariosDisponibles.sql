CREATE PROCEDURE [dbo].[sp_ListarHorariosDisponibles]
	@BarberoId INT,
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

    SELECT HorarioId, Hora
    FROM HorariosDisponibles
    WHERE BarberoId = @BarberoId
      AND Fecha = @Fecha
      AND Disponible = 1
    ORDER BY Hora;
END;
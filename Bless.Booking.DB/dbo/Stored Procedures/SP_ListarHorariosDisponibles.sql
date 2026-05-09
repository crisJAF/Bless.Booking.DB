CREATE PROCEDURE [dbo].[sp_ListarHorariosDisponibles]
    @BarberoId INT,
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

    SET DATEFIRST 7;
    DECLARE @DiaSemana INT = DATEPART(WEEKDAY, @Fecha);

    SELECT 
        Cupos.HoraDesde,
        Cupos.HoraHasta
    FROM [dbo].[BarberoHorario] h
    CROSS APPLY dbo.fn_GenerarCupos(h.HoraInicio, h.HoraFin, h.DuracionCupoMinutos) AS Cupos
    WHERE h.BarberoID = @BarberoId
      AND h.Dia = @DiaSemana
      AND h.Estado = 1
      AND NOT EXISTS (
        SELECT 1
        FROM [dbo].[Reservas] r
        WHERE r.BarberoId = @BarberoId
          AND r.Fecha = @Fecha
          AND r.Hora = Cupos.HoraDesde
    )
    ORDER BY Cupos.HoraDesde;
END;

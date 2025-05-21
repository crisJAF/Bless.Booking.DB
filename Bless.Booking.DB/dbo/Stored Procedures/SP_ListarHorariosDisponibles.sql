CREATE PROCEDURE [dbo].[sp_ListarHorariosDisponibles]
    @BarberoId INT,
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @DiaSemana INT = DATEPART(WEEKDAY, @Fecha);
    SET DATEFIRST 7;

    SELECT *
    INTO #Horario
    FROM BarberoHorario
    WHERE BarberoID = @BarberoId AND Dia = @DiaSemana AND Estado = 1;

    SELECT 
        Cupos.HoraDesde,
        Cupos.HoraHasta
    FROM #Horario h
    CROSS APPLY dbo.fn_GenerarCupos(h.HoraInicio, h.HoraFin, h.DuracionCupoMinutos) AS Cupos
    WHERE NOT EXISTS (
        SELECT 1
        FROM Reservas r
        WHERE r.BarberoId = @BarberoId
          AND r.Fecha = @Fecha
          AND r.Hora = Cupos.HoraDesde
    )
    ORDER BY Cupos.HoraDesde;

    DROP TABLE #Horario;
END;
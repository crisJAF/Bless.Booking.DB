CREATE PROCEDURE [dbo].[sp_LiostarHorariosDisponibles_v2]
	@BarberoId INT,
    @Fecha DATE
AS
BEGIN
    SET NOCOUNT ON;

   SELECT bha.BarberoHorarioAtencionID, bha.HoraDesde, bha.HoraHasta
    FROM BarberoHorarioAtencion bha
    WHERE bha.BarberoID = @BarberoId
      AND bha.Dia = DATEPART(WEEKDAY, @Fecha) -- Día de la semana: 1 (domingo) a 7 (sábado)
      AND bha.Estado = 1
      AND NOT EXISTS (
          SELECT 1
          FROM ReservasV2 r
          WHERE r.BarberoHorarioAtencionID = bha.BarberoHorarioAtencionID
            AND r.Fecha = @Fecha
      )
    ORDER BY bha.HoraDesde;

END;
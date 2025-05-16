CREATE FUNCTION dbo.fn_GenerarCupos
(
    @HoraInicio TIME,
    @HoraFin TIME,
    @Duracion INT
)
RETURNS @Cupos TABLE (HoraDesde TIME, HoraHasta TIME)
AS
BEGIN
    DECLARE @Actual TIME = @HoraInicio;

    WHILE DATEADD(MINUTE, @Duracion, @Actual) <= @HoraFin
    BEGIN
        INSERT INTO @Cupos(HoraDesde, HoraHasta)
        VALUES (
            @Actual,
            DATEADD(MINUTE, @Duracion, @Actual)
        );

        SET @Actual = DATEADD(MINUTE, @Duracion, @Actual);
    END

    RETURN;
END;

CREATE PROCEDURE [dbo].[sp_Barbero_Listar]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        BarberoId,
        Nombre,
        Especialidad
    FROM [dbo].[Barbero]
    ORDER BY Nombre;
END;

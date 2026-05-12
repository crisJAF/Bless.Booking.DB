CREATE PROCEDURE [dbo].[sp_Servicio_Listar]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ServicioId,
        Nombre,
        Descripcion,
        DuracionMinutos,
        Precio
    FROM [dbo].[Servicio]
    ORDER BY Nombre;
END;

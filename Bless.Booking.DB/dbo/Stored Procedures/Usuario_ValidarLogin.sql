CREATE PROCEDURE Usuario_ValidarLogin
    @NombreUsuario NVARCHAR(50)
AS
BEGIN
    SELECT TOP 1 Id, NombreUsuario, CorreoElectronico, ContrasenaHash, Rol
    FROM Usuarios
    WHERE NombreUsuario = @NombreUsuario
END

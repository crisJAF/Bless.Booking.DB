CREATE PROCEDURE Usuario_Registrar
    @NombreUsuario NVARCHAR(50),
    @CorreoElectronico NVARCHAR(100),
    @ContrasenaHash NVARCHAR(255),
    @Rol NVARCHAR(50)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Usuarios WHERE NombreUsuario = @NombreUsuario OR CorreoElectronico = @CorreoElectronico)
    BEGIN
        RAISERROR('Usuario o correo ya existe.', 16, 1);
        RETURN;
    END

    INSERT INTO Usuarios (NombreUsuario, CorreoElectronico, ContrasenaHash, Rol)
    VALUES (@NombreUsuario, @CorreoElectronico, @ContrasenaHash, @Rol);
END
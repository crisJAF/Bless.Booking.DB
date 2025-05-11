CREATE TABLE [dbo].[Cliente]
(
	ClienteId INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) NOT NULL,
    Telefono NVARCHAR(20),
    Correo NVARCHAR(100)
)

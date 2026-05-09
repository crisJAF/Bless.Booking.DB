CREATE TABLE [dbo].[Servicio]
(
    ServicioId INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100) NOT NULL,
    Descripcion NVARCHAR(255),
    DuracionMinutos INT NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    CONSTRAINT [CK_Servicio_DuracionMinutos] CHECK (DuracionMinutos > 0),
    CONSTRAINT [CK_Servicio_Precio] CHECK (Precio >= 0)
)

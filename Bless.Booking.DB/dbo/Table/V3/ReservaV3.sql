CREATE TABLE [dbo].[ReservaV3]
(
	ReservaId INT PRIMARY KEY IDENTITY,
    ClienteId INT NOT NULL,
    BarberoId INT NOT NULL,
    ServicioId INT NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Estado NVARCHAR(20) DEFAULT 'Pendiente', -- Pendiente, Confirmada, Cancelada
    FechaCreacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ClienteId) REFERENCES Cliente(ClienteId),
    FOREIGN KEY (BarberoId) REFERENCES Barbero(BarberoId),
    FOREIGN KEY (ServicioId) REFERENCES Servicio(ServicioId),
)

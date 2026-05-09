CREATE TABLE [dbo].[Reservas]
(
    ReservaId INT PRIMARY KEY IDENTITY,
    ClienteId INT NOT NULL,
    BarberoId INT NOT NULL,
    ServicioId INT NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Estado NVARCHAR(20) NOT NULL CONSTRAINT [DF_Reservas_Estado] DEFAULT 'Pendiente', -- Pendiente, Confirmada, Cancelada
    FechaCreacion DATETIME NOT NULL CONSTRAINT [DF_Reservas_FechaCreacion] DEFAULT GETDATE(),
    CONSTRAINT [FK_Reservas_Cliente] FOREIGN KEY (ClienteId) REFERENCES [dbo].[Cliente](ClienteId),
    CONSTRAINT [FK_Reservas_Barbero] FOREIGN KEY (BarberoId) REFERENCES [dbo].[Barbero](BarberoId),
    CONSTRAINT [FK_Reservas_Servicio] FOREIGN KEY (ServicioId) REFERENCES [dbo].[Servicio](ServicioId),
    CONSTRAINT [CK_Reservas_Estado] CHECK (Estado IN ('Pendiente', 'Confirmada', 'Cancelada')),
    CONSTRAINT [UQ_Reservas_Barbero_Fecha_Hora] UNIQUE (BarberoId, Fecha, Hora)
)

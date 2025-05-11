CREATE TABLE [dbo].[DetalleReserva]
(
	DetalleId INT PRIMARY KEY IDENTITY,
    ReservaId INT NOT NULL,
    ServicioId INT NOT NULL,
    FOREIGN KEY (ReservaId) REFERENCES Reservas(ReservaId),
    FOREIGN KEY (ServicioId) REFERENCES Servicio(ServicioId)
)

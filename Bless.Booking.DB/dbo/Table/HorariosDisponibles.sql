CREATE TABLE [dbo].[HorariosDisponibles]
(
	HorarioId INT PRIMARY KEY IDENTITY,
    BarberoId INT NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Disponible BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (BarberoId) REFERENCES Barbero(BarberoId)
)

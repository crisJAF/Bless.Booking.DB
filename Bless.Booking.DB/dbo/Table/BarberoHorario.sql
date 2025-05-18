CREATE TABLE [dbo].[BarberoHorario]
(
	BarberoHorarioID INT PRIMARY KEY IDENTITY,
    BarberoID INT NOT NULL,
    Dia INT NOT NULL, -- 1 = domingo, 2 = lunes, etc.
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    DuracionCupoMinutos INT NOT NULL DEFAULT 30,
    Estado BIT NOT NULL DEFAULT 1,
    FOREIGN KEY (BarberoID) REFERENCES Barbero(BarberoID)
)

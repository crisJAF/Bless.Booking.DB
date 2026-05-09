CREATE TABLE [dbo].[BarberoHorario]
(
    BarberoHorarioID INT PRIMARY KEY IDENTITY,
    BarberoID INT NOT NULL,
    Dia INT NOT NULL, -- 1 = domingo, 2 = lunes, etc.
    HoraInicio TIME NOT NULL,
    HoraFin TIME NOT NULL,
    DuracionCupoMinutos INT NOT NULL CONSTRAINT [DF_BarberoHorario_DuracionCupoMinutos] DEFAULT 30,
    Estado BIT NOT NULL CONSTRAINT [DF_BarberoHorario_Estado] DEFAULT 1,
    CONSTRAINT [FK_BarberoHorario_Barbero] FOREIGN KEY (BarberoID) REFERENCES [dbo].[Barbero](BarberoID),
    CONSTRAINT [CK_BarberoHorario_Dia] CHECK (Dia BETWEEN 1 AND 7),
    CONSTRAINT [CK_BarberoHorario_Horario] CHECK (HoraInicio < HoraFin),
    CONSTRAINT [CK_BarberoHorario_Duracion] CHECK (DuracionCupoMinutos > 0)
)

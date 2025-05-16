CREATE TABLE [dbo].[BarberoHorarioAtencion]
(
	[BarberoHorarioAtencionID] INT NOT NULL PRIMARY KEY,
	[BarberoID] INT NOT NULL,
	[Dia] INT NOT NULL,
	[HoraDesde] TIME(0) NOT NULL,
	[HoraHasta] TIME(0) NOT NULL,
	[Estado] BIT NOT NULL,
)

/*
    Datos iniciales para ambientes de desarrollo/pruebas.
    El script es idempotente: puede ejecutarse varias veces sin duplicar registros.

    Usuario de prueba:
      usuario: admin
      clave:   password
*/

PRINT N'Aplicando datos iniciales de Bless Booking...';

SET XACT_ABORT ON;

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @Servicios TABLE
    (
        Nombre NVARCHAR(100) NOT NULL PRIMARY KEY,
        Descripcion NVARCHAR(255) NULL,
        DuracionMinutos INT NOT NULL,
        Precio DECIMAL(10, 2) NOT NULL
    );

    INSERT INTO @Servicios (Nombre, Descripcion, DuracionMinutos, Precio)
    VALUES
        (N'Corte Clasico', N'Corte basico con tijera y maquina', 30, 10.00),
        (N'Corte + Barba', N'Corte de cabello y arreglo de barba', 45, 15.00),
        (N'Barba', N'Arreglo y perfilado de barba', 20, 6.00),
        (N'Fade', N'Degradado moderno con maquina y tijera', 40, 12.00);

    UPDATE target
       SET Descripcion = source.Descripcion,
           DuracionMinutos = source.DuracionMinutos,
           Precio = source.Precio
      FROM [dbo].[Servicio] AS target
      INNER JOIN @Servicios AS source
        ON source.Nombre = target.Nombre;

    INSERT INTO [dbo].[Servicio] (Nombre, Descripcion, DuracionMinutos, Precio)
    SELECT source.Nombre, source.Descripcion, source.DuracionMinutos, source.Precio
      FROM @Servicios AS source
     WHERE NOT EXISTS
     (
        SELECT 1
          FROM [dbo].[Servicio] AS target
         WHERE target.Nombre = source.Nombre
     );

    DECLARE @Barberos TABLE
    (
        Nombre NVARCHAR(100) NOT NULL PRIMARY KEY,
        Especialidad NVARCHAR(100) NULL
    );

    INSERT INTO @Barberos (Nombre, Especialidad)
    VALUES
        (N'Andres Torres', N'Cortes clasicos'),
        (N'Jose Ruiz', N'Fade y barba'),
        (N'Marco Salazar', N'Corte moderno y diseno');

    UPDATE target
       SET Especialidad = source.Especialidad
      FROM [dbo].[Barbero] AS target
      INNER JOIN @Barberos AS source
        ON source.Nombre = target.Nombre;

    INSERT INTO [dbo].[Barbero] (Nombre, Especialidad)
    SELECT source.Nombre, source.Especialidad
      FROM @Barberos AS source
     WHERE NOT EXISTS
     (
        SELECT 1
          FROM [dbo].[Barbero] AS target
         WHERE target.Nombre = source.Nombre
     );

    DECLARE @Horarios TABLE
    (
        NombreBarbero NVARCHAR(100) NOT NULL,
        Dia INT NOT NULL,
        HoraInicio TIME(0) NOT NULL,
        HoraFin TIME(0) NOT NULL,
        DuracionCupoMinutos INT NOT NULL,
        Estado BIT NOT NULL,
        PRIMARY KEY (NombreBarbero, Dia, HoraInicio)
    );

    INSERT INTO @Horarios (NombreBarbero, Dia, HoraInicio, HoraFin, DuracionCupoMinutos, Estado)
    VALUES
        -- 1 = domingo, 2 = lunes, ..., 7 = sabado
        (N'Andres Torres', 2, '09:00', '17:00', 30, 1),
        (N'Andres Torres', 3, '09:00', '17:00', 30, 1),
        (N'Andres Torres', 4, '09:00', '17:00', 30, 1),
        (N'Andres Torres', 5, '09:00', '17:00', 30, 1),
        (N'Andres Torres', 6, '09:00', '17:00', 30, 1),

        (N'Jose Ruiz', 3, '12:00', '20:00', 30, 1),
        (N'Jose Ruiz', 4, '12:00', '20:00', 30, 1),
        (N'Jose Ruiz', 5, '12:00', '20:00', 30, 1),
        (N'Jose Ruiz', 6, '12:00', '20:00', 30, 1),
        (N'Jose Ruiz', 7, '12:00', '20:00', 30, 1),

        (N'Marco Salazar', 1, '10:00', '14:00', 30, 1),
        (N'Marco Salazar', 2, '14:00', '19:00', 30, 1),
        (N'Marco Salazar', 4, '14:00', '19:00', 30, 1),
        (N'Marco Salazar', 6, '10:00', '16:00', 30, 1);

    UPDATE target
       SET HoraFin = source.HoraFin,
           DuracionCupoMinutos = source.DuracionCupoMinutos,
           Estado = source.Estado
      FROM [dbo].[BarberoHorario] AS target
      INNER JOIN [dbo].[Barbero] AS barbero
        ON barbero.BarberoId = target.BarberoID
      INNER JOIN @Horarios AS source
        ON source.NombreBarbero = barbero.Nombre
       AND source.Dia = target.Dia
       AND source.HoraInicio = target.HoraInicio;

    INSERT INTO [dbo].[BarberoHorario] (BarberoID, Dia, HoraInicio, HoraFin, DuracionCupoMinutos, Estado)
    SELECT barbero.BarberoId,
           source.Dia,
           source.HoraInicio,
           source.HoraFin,
           source.DuracionCupoMinutos,
           source.Estado
      FROM @Horarios AS source
      INNER JOIN [dbo].[Barbero] AS barbero
        ON barbero.Nombre = source.NombreBarbero
     WHERE NOT EXISTS
     (
        SELECT 1
          FROM [dbo].[BarberoHorario] AS target
         WHERE target.BarberoID = barbero.BarberoId
           AND target.Dia = source.Dia
           AND target.HoraInicio = source.HoraInicio
     );

    IF NOT EXISTS
    (
        SELECT 1
          FROM [dbo].[Usuarios]
         WHERE NombreUsuario = N'admin'
            OR CorreoElectronico = N'admin@bless.local'
    )
    BEGIN
        INSERT INTO [dbo].[Usuarios] (NombreUsuario, CorreoElectronico, ContrasenaHash, Rol)
        VALUES
        (
            N'admin',
            N'admin@bless.local',
            N'$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
            N'Admin'
        );
    END;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRANSACTION;
    END;

    THROW;
END CATCH;

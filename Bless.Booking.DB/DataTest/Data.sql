-- INSERT INTO [dbo].[Servicio] (Nombre, Descripcion, DuracionMinutos, Precio)
-- VALUES 
-- ('Corte Clásico', 'Corte básico con tijera y máquina', 30, 10.00),
-- ('Corte + Barba', 'Corte de cabello y arreglo de barba', 45, 15.00),
-- ('Barba', 'Solo arreglo de barba', 20, 6.00),
-- ('Corte clásico', 'Corte de cabello tradicional', 30, 10.00);


-- INSERT INTO [dbo].[Barbero] (Nombre, Especialidad)
-- VALUES
-- ('Andrés Torres', 'Cortes clásicos'),
-- ('José Ruiz', 'Fade y barba');

-- Horario para Andrés Torres (BarberoID = 1): lunes a viernes de 9:00 a 17:00
-- INSERT INTO [dbo].[BarberoHorario] (BarberoID, Dia, HoraInicio, HoraFin, DuracionCupoMinutos, Estado)
-- VALUES 
-- (1, 2, '09:00', '17:00', 30, 1),  -- Lunes
-- (1, 3, '09:00', '17:00', 30, 1),  -- Martes
-- (1, 4, '09:00', '17:00', 30, 1),  -- Miércoles
-- (1, 5, '09:00', '17:00', 30, 1),  -- Jueves
-- (1, 6, '09:00', '17:00', 30, 1),  -- Viernes

-- -- Horario para José Ruiz (BarberoID = 2): martes a sábado de 12:00 a 20:00
-- (2, 3, '12:00', '20:00', 30, 1),  -- Martes
-- (2, 4, '12:00', '20:00', 30, 1),  -- Miércoles
-- (2, 5, '12:00', '20:00', 30, 1),  -- Jueves
-- (2, 6, '12:00', '20:00', 30, 1),  -- Viernes
-- (2, 7, '12:00', '20:00', 30, 1);  -- Sábado

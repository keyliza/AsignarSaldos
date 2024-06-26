USE master
GO

CREATE DATABASE AsignacionesGestores
GO

USE AsignacionesGestores
GO


-- Crear la tabla de gestores
CREATE TABLE Gestores (
    GestorID INT PRIMARY KEY,
    Nombre NVARCHAR(100)
);

-- Crear la tabla de saldos
CREATE TABLE Saldos (
    SaldoID INT PRIMARY KEY,
    Monto DECIMAL(18,2)
);

-- Crear la tabla de asignaciones
CREATE TABLE Asignaciones (
    AsignacionID INT PRIMARY KEY IDENTITY,
    GestorID INT,
    SaldoID INT,
    FOREIGN KEY (GestorID) REFERENCES Gestores(GestorID),
    FOREIGN KEY (SaldoID) REFERENCES Saldos(SaldoID)
);


-- Insertar datos de prueba en Gestores
INSERT INTO Gestores (GestorID, Nombre)
VALUES (1, 'Gestor 1'), (2, 'Gestor 2'), (3, 'Gestor 3'), (4, 'Gestor 4'),
       (5, 'Gestor 5'), (6, 'Gestor 6'), (7, 'Gestor 7'), (8, 'Gestor 8'),
       (9, 'Gestor 9'), (10, 'Gestor 10');
	GO

-- Insertar datos de prueba en Saldos
INSERT INTO Saldos (SaldoID, Monto)
VALUES (1, 2277), (2, 3953), (3, 4726), (4, 1414), (5, 627), (6, 1784),
       (7, 1634), (8, 3958), (9, 2156), (10, 1347), (11, 2166), (12, 820),
       (13, 2325), (14, 3613), (15, 2389), (16, 4130), (17, 2007), (18, 3027),
       (19, 2591), (20, 3940), (21, 3888), (22, 2975), (23, 4470), (24, 2291),
       (25, 3393), (26, 3588), (27, 3286), (28, 2293), (29, 4353), (30, 3315),
       (31, 4900), (32, 794), (33, 4424), (34, 4505), (35, 2643), (36, 2217),
       (37, 4193), (38, 2893), (39, 4120), (40, 3352), (41, 2355), (42, 3219),
       (43, 3064), (44, 4893), (45, 272), (46, 1299), (47, 4725), (48, 1900),
       (49, 4927), (50, 4011);

	   GO





CREATE PROCEDURE AsignarSaldos
AS
BEGIN

delete Asignaciones

    DECLARE @GestorID INT;
    DECLARE @SaldoID INT;
    
	DECLARE @Iteracion bit = 0;

    -- Ordenar los saldos en orden descendente
    DECLARE saldo_cursor CURSOR FOR
    SELECT SaldoID
    FROM Saldos
    ORDER BY Monto DESC;

    -- Cursor para los gestores
    DECLARE gestor_cursor CURSOR FOR
    SELECT GestorID
    FROM Gestores;

    OPEN saldo_cursor;
    FETCH NEXT FROM saldo_cursor INTO @SaldoID;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        OPEN gestor_cursor;

        WHILE @@FETCH_STATUS = 0 AND @@FETCH_STATUS = 0
        BEGIN
			if @Iteracion = 0 
             FETCH NEXT FROM gestor_cursor INTO @GestorID;

			 set @Iteracion = 0 

            IF @@FETCH_STATUS = 0
            BEGIN
                -- Asignar el saldo al gestor
                INSERT INTO Asignaciones (GestorID, SaldoID)
                VALUES (@GestorID, @SaldoID);

                FETCH NEXT FROM saldo_cursor INTO @SaldoID;

                IF @@FETCH_STATUS <> 0
                    BREAK;
            END

			else
			begin 

					CLOSE gestor_cursor;
					DEALLOCATE gestor_cursor;

					DECLARE gestor_cursor CURSOR FOR
					SELECT GestorID
					FROM Gestores;

					OPEN gestor_cursor;
					FETCH NEXT FROM gestor_cursor INTO @GestorID;
					set @Iteracion = 1
				
			end
        END

        CLOSE gestor_cursor;
    END

    CLOSE saldo_cursor;
    DEALLOCATE saldo_cursor;
    DEALLOCATE gestor_cursor;

	--Saldos Asignados
	select a.GestorID, a.SaldoID, S.Monto from 
	Asignaciones as a inner join Saldos as S on a.SaldoID = S.SaldoID

END

exec AsignarSaldos


--Query para Obtener Gestor por grupo y saldo
	--select a.GestorID, a.SaldoID, S.Monto 
	--from Asignaciones as a inner join Saldos as S on a.SaldoID = S.SaldoID
	--group by a.GestorID, a.SaldoID, S.Monto
	--order by a.GestorID, S.Monto desc
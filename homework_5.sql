DROP DATABASE IF EXISTS hw5;
CREATE DATABASE hw5;
USE hw5;


/* Урок 5. SQL – оконные функции*/




/*
 * 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов;
 */

CREATE TABLE Cars
(
    CarID INT PRIMARY KEY AUTO_INCREMENT,
    Brand VARCHAR(50),
    Model VARCHAR(50),
    Price DECIMAL(10, 2)
);



INSERT INTO Cars (Brand, Model, Price)
VALUES ('Шкода', 'Octavia', 25000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Ауди', 'A4', 30000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('BMW', 'X5', 50000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Toyota', 'Camry', 28000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Honda', 'Civic', 22000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Ford', 'Mustang', 45000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Mercedes-Benz', 'C-Class', 40000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Volkswagen', 'Golf', 20000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Hyundai', 'Elantra', 23000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Chevrolet', 'Cruze', 21000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Шкода', 'Rapid', 24000.00);

INSERT INTO Cars (Brand, Model, Price)
VALUES ('Ауди', 'Q5', 35000.00);




CREATE VIEW CarsUnder25000 AS
SELECT *
FROM Cars
WHERE Price <= 25000.00;


SELECT * FROM CarsUnder25000;


/* 
 * 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW);
 */



ALTER VIEW CarsUnder25000 AS
SELECT *
FROM Cars
WHERE Price <= 30000.00;


SELECT * FROM CarsUnder25000;




/*
 * 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)
 */


CREATE VIEW SkodaAndAudiCars AS
SELECT *
FROM Cars
WHERE Brand IN ('Шкода', 'Ауди');


SELECT * FROM SkodaAndAudiCars;



/*
 * 4. Добавьте новый столбец под названием «время до следующей станции». 
 * Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
 * Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно.
 *  Проще это сделать с помощью оконной функции LEAD . 
 * Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат.
 *  В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
 */

CREATE TABLE Stations
(
    StationID INT PRIMARY KEY AUTO_INCREMENT,
    StationName VARCHAR(50),
    Time TIME
);

INSERT INTO Stations (StationName, Time)
VALUES ('Station A', '09:00:00');

INSERT INTO Stations (StationName, Time)
VALUES ('Station B', '09:15:00');

INSERT INTO Stations (StationName, Time)
VALUES ('Station C', '09:30:00');

INSERT INTO Stations (StationName, Time)
VALUES ('Station D', '09:45:00');



ALTER TABLE Stations ADD COLUMN TimeToNextStation TIME;

UPDATE Stations s
JOIN (
    SELECT StationID, Time, 
    LEAD(Time) OVER (ORDER BY Time) AS NextTime
    FROM Stations
) AS next_station ON s.StationID = next_station.StationID
SET s.TimeToNextStation = TIMEDIFF(next_station.NextTime, s.Time);





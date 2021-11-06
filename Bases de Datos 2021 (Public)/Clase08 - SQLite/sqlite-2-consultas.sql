-- Consultas en SQLite3.
-- Exactamente lo mismo que en MySQL.
-- Select como cláusula universal de manejo de datos
SELECT strftime("%s","now"); # Similar a
SELECT datetime("now");
SELECT 1+1;

-- Usando tablas
.schema Artist; # Explica el esquema de la tabla, similar a SHOW TABLE o SHOW CREATE TABLE
SELECT * FROM Artist;
SELECT Name AS 'Artista' FROM Artist;

-- Procesando datos
SELECT Artist.Name, LENGTH(Artist.Name) FROM Artist LIMIT 10;

SELECT Artist.Name, LENGTH(Artist.Name) AS 'Length'
FROM Artist WHERE LENGTH(Artist.Name) <= 5
ORDER BY Artist.Name;

SELECT CONCAT("El artista ", Artist.Name, " tiene como ID el numero ", ArtistId) FROM Artist;

-- Distintos
.schema Invoice
SELECT DISTINCT(BillingCountry) FROM Invoice ORDER BY BillingCountry;
SELECT COUNT(DISTINCT BillingCountry) FROM Invoice;

-- Filtrado
SELECT * FROM Artist WHERE Name = 'Black Sabbath';
SELECT * FROM Artist WHERE Name LIKE 'Black%';
SELECT * FROM Artist WHERE ArtistId BETWEEN 1 AND 20;
SELECT * FROM Artist WHERE Name BETWEEN 'A' AND 'B' ORDER BY Name;

--- Agregadores
SELECT AVG(Total) AS 'Promedio',
MIN(Total) AS 'Minimo',
MAX(Total) AS 'Maximo',
SUM(Total) AS 'Suma',
COUNT(Total) AS 'Facturas'
FROM Invoice WHERE BillingCountry = 'Brazil';

--- Columna ambigua
SELECT Name, Title FROM Artist, Album ORDER BY ArtistId;

--- Inner join implícito
SELECT Artist.Name, Album.Title FROM Artist, Album
WHERE Artist.ArtistId = Album.ArtistId
ORDER BY Artist.Name
LIMIT 10;

--- Inner join explícito
SELECT Artist.Name, Album.Title
FROM Artist
JOIN Album ON (Artist.ArtistId = Album.ArtistId)
ORDER BY Artist.Name
LIMIT 10;

--- Agrupación
SELECT
BillingCountry,
AVG(Total) AS 'Promedio',
MIN(Total) AS 'Minimo',
MAX(Total) AS 'Maximo',
SUM(Total) AS 'Suma',
COUNT(Total) AS 'Facturas'
FROM Invoice
GROUP BY BillingCountry
ORDER BY BillingCountry;
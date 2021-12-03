USE `CONTROL_ACCESO`;
SELECT * FROM Puerta_estadistica
GROUP BY Puerta_estadistica.ID
ORDER BY COUNT(Puerta_estadistica.Denegados) ASC;

-- Muestra las opciones de administración
.help

-- Settings
.show
.headers
.stats

-- Modelo de datos
.tables
.schema Artist; # Explica el esquema de la tabla, similar a SHOW TABLE o SHOW CREATE TABLE

-- Resultado
.mode csv
.mode columns
.width 10 50

-- Otros comandos de admnistración (sirve para trabajar con DBs en memoria también)
.backup backup.sqlite # Genera una copia de la DB
.restore backup.sqlite # Restaura la copia de la DB

-- Entrada y salida
.read source.sql # Lee de un archivo SQL
.output FILENAME # Manda la salida a un archivo

-- Cargarse CSVs
.separator ,
.import file.csv tablename

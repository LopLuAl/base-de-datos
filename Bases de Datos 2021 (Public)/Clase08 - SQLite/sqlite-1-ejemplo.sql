# Creación
sqlite3 midb.sqlite

create table tbl1(one varchar(10), two smallint);
insert into tbl1 values('hello!',10);
insert into tbl1 values('goodbye', 20);
select * from tbl1;

# Importación
sqlite3 -init Chinook_Sqlite_AutoIncrementPKs.sql midb.sqlite

# Importación #2
sqlite3 midb.sqlite
.read Chinook_Sqlite_AutoIncrementPKs.sql

# Como me creo una nueva Chinook!?
cp Chinook.sqlite Chinook2.sqlite

# "Conectarse"
sqlite3 Chinook_Sqlite.sqlite

# Crear una base de datos SQL en memoria
# Desaparece cuando se corta la "conexión"
sqlite3 :memory:
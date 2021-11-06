CREATE USER 'apptest'@'localhost' IDENTIFIED BY 'k9s,!)Kow4*2C?5%O}".Wc(6.4{+c8C1cyG%KhE[=~lABn.>Q^=5|LXZdj:Xb*!';
CREATE USER 'admintest'@'localhost' IDENTIFIED BY 'Qu+)W+LXLp/{ou7%;>Uat7S7(@n1kPZiSSPASl7(UtM]}{h>@2g%hA+Xd1';

GRANT SELECT,INSERT,UPDATE,DELETE ON Chinook.* TO 'apptest'@'localhost' WITH GRANT OPTION;

GRANT ALL PRIVILEGES ON Chinook.* TO 'admintest'@'localhost' WITH GRANT OPTION;

SELECT DISTINCT(user) from mysql.user;
SELECT * FROM mysql.user;

# "%" means "any host"

SHOW GRANTS FOR 'apptest'@'localhost';
SHOW GRANTS FOR 'admintest'@'localhost';

REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'apptest'@'localhost';
DROP USER 'apptest'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'admintest'@'localhost';
DROP USER 'admintest'@'localhost';
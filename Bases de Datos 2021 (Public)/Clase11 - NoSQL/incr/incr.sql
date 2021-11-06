drop database if exists incr;
create database incr;
use incr;

create table incr (
name VARCHAR(50),
val INT(10) NOT NULL DEFAULT 0
) Engine=MyISAM;

insert into incr(name,val) VALUES('incr-this', 0);

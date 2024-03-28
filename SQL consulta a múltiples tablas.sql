DROP TABLE IF EXISTS bandas;
CREATE TABLE bandas
(
    id SERIAL PRIMARY KEY,
    nombre character varying(50),
    pais character varying(50)
);

insert into bandas (nombre, pais) values ('Kraftwerk', 'Alemania');
insert into bandas (nombre, pais) values ('Los prisioneros', 'Chile');
insert into bandas (nombre, pais) values ('KMFDM', 'Alemania');
insert into bandas (nombre, pais) values ('Muse', 'UK');
insert into bandas (nombre, pais) values ('The Chemical Brothers', 'UK');
insert into bandas (nombre, pais) values ('TOOL', 'USA');
insert into bandas (nombre, pais) values ('The Beatles', 'UK');
insert into bandas (nombre, pais) values ('Modeselektor', 'Alemania');

DROP TABLE IF EXISTS bandas_discos;
CREATE TABLE bandas_discos
(
    id SERIAL PRIMARY KEY,
    nombre_disco character varying(50),
    anio_disco integer,
    banda_id integer REFERENCES bandas(id)
);

-- Insertar datos en la tabla bandas_discos con los ID correspondientes
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Computer World', 1981, 1);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('The Man Machine', 1978, 1);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('La cultura de la basura', 1987, 2);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Corazones', 1990, 2);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('NIHIL', 1995, 3);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('XTORT', 1996, 3);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('ADIOS', 1999, 3);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Showbiz', 1999, 4);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Origin of symetry', 2001, 4);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Black holes and Revelations', 2006, 4);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Surrender', 1999, 5);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Born in the echoes', 2015, 5);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('No Geography', 2019, 5);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Aenima', 1996, 6);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Lateralus', 2001, 6);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Fear Inoculum', 2019, 6);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Rubber Soul', 1965, 7);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Revolver', 1966, 7);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Abbey Road', 1969, 7);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Hello Mom!', 2005, 8);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Monkeytown', 2011, 8);
INSERT INTO bandas_discos (nombre_disco, anio_disco, banda_id) VALUES ('Who Else', 2019, 8);

select * from  bandas_discos;
select * from  bandas;

--Listar todos los discos de bandas no alemanas que hayan sido publicados desde el 2000 en adelante:
SELECT b.pais AS pais_banda,bd.nombre_disco,bd.anio_disco FROM bandas_discos bd
INNER JOIN bandas b ON bd.banda_id = b.id WHERE b.pais != 'Alemania' AND bd.anio_disco >= 2000;


--Listar el disco más reciente de las bandas inglesas que terminan en 's':
SELECT nombre,anio_disco as año
FROM bandas b INNER JOIN bandas_discos bd ON b.id = bd.banda_id
WHERE nombre IN (SELECT nombre FROM bandas WHERE pais = 'UK' AND nombre LIKE '%s') ORDER BY anio_disco DESC
LIMIT 1;

--Listar todas las bandas alemanas con al menos una letra 'k' en su nombre que tenga discos publicados en 1999 o superior:
SELECT b.nombre, bd.nombre_disco, bd.anio_disco
FROM bandas b
INNER JOIN bandas_discos bd ON b.id = bd.banda_id
WHERE b.pais = 'Alemania' AND b.nombre LIKE '%k%' AND bd.anio_disco >= 1999;

--Listar todas las bandas y el número de discos registrados:
SELECT b.nombre, COUNT(bd.nombre_disco) AS numero_discos
FROM bandas b
LEFT JOIN bandas_discos bd ON b.id = bd.banda_id
GROUP BY b.nombre;

--Mostrar todos los años en que todas las bandas sacaron un disco. Ordene la lista por año:
SELECT DISTINCT anio_disco
FROM bandas_discos
ORDER BY anio_disco ;

--Listar todas las bandas que tienen un disco con nombre empezando en 'a'. Listar el nombre de la banda y del disco:
SELECT b.nombre AS nombre_banda, bd.nombre_disco
FROM bandas_discos bd
INNER JOIN bandas b ON bd.banda_id = b.id
where LOWER(bd.nombre_disco) LIKE 'a%'
ORDER BY b.nombre, bd.nombre_disco;


--Listar todas las bandas que tengan discos con más de una palabra. Listar el nombre de la banda y el disco:

select DISTINCT b.nombre AS nombre_banda, bd.nombre_disco
FROM bandas_discos bd
INNER JOIN bandas b ON bd.banda_id = b.id
where bd.nombre_disco LIKE '% %';

--Listar todas las bandas que tengan discos con más de una palabra. Listar el nombre de la banda y la cantidad de discos:
SELECT b.nombre, COUNT(bd.nombre_disco) AS cantidad_discos
FROM bandas b
INNER JOIN bandas_discos bd ON b.id = bd.banda_id
WHERE bd.nombre_disco LIKE '% %'
GROUP BY b.nombre;
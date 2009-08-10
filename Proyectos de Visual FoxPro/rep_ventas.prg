set default to j:\wapps9\digicel\inv\tablas
idowner='ZinterCODE'
open data inven shar
set cent on
set date to brit
set dele on
set stat on
SET ENGINEBEHAVIOR 70
sele 1
open data inven shar
USE inmov SHARED
SELECT 2
USE inprod SHARED
SELECT 3
USE inbod SHARED

select a.fecha, a.codbod, c.codzona, a.codtmo, a.codtcomvta, a.codprod, a.Desprod, b.codlin, sum(a.cantidad) as terminales, sum(a.valoruni)as dinero from inmov as a, inprod as b , inbod as c where codtmo='S2' AND a.codprod = b.codprod AND a.codbod = c.codbod AND a.fecha >=CTOD('01/12/2008') AND a.fecha <=CTOD('15/12/2008') group by a.fecha, a.codbod, a.codprod, b.codlin

EXPORT TO c:\exportar\ventas_dic TYPE xls
CLOSE DATABASES
CLOSE ALL 
QUIT

set default to j:\wapps9\digicel\inv\tablas
idowner='ZinterCODE'
OPEN DATABASE inven SHARED
SELECT 1
USE inmov shared
SELECT 2
USE inprod shared
SELECT 3
USE inemov SHARED
SELECT 4
USE inbod SHARED
SET ENGINEBEHAVIOR 70
SET DELETED ON
SET DATE TO brit
select distinct a.nudoc, a.fecha, b.desprod,a.imei, a.cantidad, a.valor, a.codbod, c.codtcomvta, d.codzona from inmov as a, inprod as b, inemov as c, inbod as d where a.codprod=b.codprod AND a.nudoc = c.nudoc AND c.codbod = d.codbod and d.codzona = '001' AND a.codtmo = 'S2'AND a.fecha > CTOD('07/12/2008') and a.fecha < CTOD('08/01/2009') and (b.codlin = '0101' or b.codlin = '0401') order by a.nudoc, a.codprod
EXPORT TO c:\exportar\rep_precios_tgu TYPE XL5 NOOPTIMIZE
CLOSE DATABASES
QUIT
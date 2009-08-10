m.fechai='19/11/2008'
m.fechaf='31/12/2008'
set default to j:\wapps9\digicel\inv\tablas
idowner='ZinterCODE'
OPEN DATABASE inven SHARED
SET ENGINEBEHAVIOR 70
SET STATUS on
SET DATE TO brit
SELECT 1
SET STATUS on
SET DELETED ON
USE inmov SHARED
SELECT 2
USE inprod SHARED
**select a.fecha, a.codbod, a.codtcomvta, a.codprod, a.Desprod, b.codlin, sum(a.cantidad) as cantidad, sum(a.valoruni)as valor from inmov as a, inprod as b where codtmo='S2' AND a.codprod = b.codprod AND a.fecha >=CTOD('12/01/2008') AND a.fecha <=CTOD('12/31/2008')  group by a.fecha, a.codbod, a.codprod, b.codlin
** con devoluciones
*select a.fecha, a.codbod, a.codtcomvta, a.codprod, a.Desprod, b.codlin, sum(a.cantidad) as terminal, SUM(valor) as dinero from inmov as a, inprod as b where codtmo='S2' AND a.codprod = b.codprod AND a.fecha >=CTOD(m.fechai) AND a.fecha <=CTOD(m.fechaf)  group by a.fecha, a.codbod, a.codprod, b.codlin INTO CURSOR repventa 
** Sin devoluciones
select a.fecha, a.codbod, a.codtcomvta, a.codprod, a.Desprod, b.codlin, sum(a.cantidad) as terminal, SUM(valor) as dinero from inmov as a, inprod as b where a.cantidad > 0 AND codtmo='S2' AND a.codprod = b.codprod AND a.fecha >=CTOD(m.fechai) AND a.fecha <=CTOD(m.fechaf)  group by a.fecha, a.codbod, a.codprod, b.codlin INTO CURSOR repventa 
EXPORT TO c:\exportar\reporte_ventas TYPE XL5 NOOPTIMIZE 
CLOSE DATABASES 
quit

**CLOSE D
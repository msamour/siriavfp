set default to j:\wapps9\digicel\inv\tablas
idowner='ZinterCODE'
 
SET ENGINEBEHAVIOR 70
SET DELETED ON
SET CENTURY on
SET STATUS ON
SET TALK ON
SET DATE TO brit

OPEN DATABASE inven SHARED
SELECT 1
USE inmov SHARED
SELECT 2
USE inprod SHARED

*SELECT DISTINCT a.codtmo, a.fecha,a.codprod, b.desprod,b.codlin, ALLTRIM(a.imei) as imei, alltrim(a.imeif) as sim, a.nutelef ,SUM(a.cantidad) as terminal, a.codbod FROM INMOV as a , inprod as b WHERE a.codprod=b.codprod  AND  b.codlin = '0101' AND a.fecha =>CTOD('01/11/2008') AND a.fecha =< CTOD('28/02/2009') AND len(ALLTRIM(imei))= 15 GROUP BY imei
*SELECT DISTINCT a.codtmo, a.fecha,a.codprod, b.desprod,b.codlin, ALLTRIM(a.imei) as imei, alltrim(a.imeif) as sim, a.nutelef ,SUM(a.cantidad) as terminal, a.codbod FROM INMOV as a , inprod as b WHERE a.codprod=b.codprod  AND codbod = '0900' AND  b.codlin = '0101' AND a.fecha =>CTOD('01/11/2008') AND a.fecha =< CTOD('28/02/2009') AND len(ALLTRIM(imei))= 15 GROUP BY imei
SELECT DISTINCT a.codbod,a.fecha,a.codprod, b.desprod,b.codlin, ALLTRIM(a.imei) as imei, alltrim(a.imeif) as sim, a.nutelef ,SUM(a.cantidad) as terminal, a.codbod FROM INMOV as a , inprod as b WHERE a.codprod=b.codprod  AND codtmo = 'S2' AND  b.codlin = '0101' AND a.fecha =>CTOD('01/11/2008') AND a.fecha =< CTOD('28/02/2009') AND len(ALLTRIM(imei))= 15 GROUP BY imei


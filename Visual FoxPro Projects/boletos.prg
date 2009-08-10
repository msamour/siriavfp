idowner='ZinterCODE'
SET DELETED ON
set default to j:\wapps9\digicel\inv\tablas
SET DELETED ON
SET CENTURY on
SET DATE TO brit
OPEN DATABASE inven SHARED
SELECT 1
USE inemov SHARED
SELECT 2
USE inmov SHARED
SELECT 3
USE c:\ticket\categorias
SELECT 5
USE inprod shared

SELECT a.codtcomvta,a.nudoc, a.codtmo, b.codprod, d.desprod, d.codlin,c.categoria,c.puntaje, b.nutelef, b.fecha, b.codprocli, b.cantidad, b.valor, b.fechadig, b.codbod ;
FROM inemov as a ;
LEFT JOIN  inmov  as b ;
ON a.nudoc = b.nudoc ;
LEFT JOIN categorias as c;
ON b.codprod = c.codigo ;
LEFT JOIN inprod as d ;
ON b.codprod = d.codprod ;
WHERE a.codtmo = 'S2' AND a.fecha >= CTOD('02/07/2009')  ;
AND a.fecha <= CTOD('12/07/2009') AND (codlin ='0101' OR codlin = '0201' OR codlin = '0701') ORDER BY a.fecha,b.nutelef;
INTO CURSOR ventas

SET DEFA TO j:\wapps9\digicel\inv\tablas
Idowner='ZinterCODEH'
SET DELETED ON
SET STATUS ON

OPEN DATABASE inven shared
*USE inmov SHARED
SELECT 1
USE inmov SHARED 
SELECT 2
USE inprod SHARED 
SELECT a.nudoc, a.codtmo, a.codprod, b.desprod, b.codlin, a.fecha, ;
	a.codprocli, a.codbod, a.imei, a.imeif, a.nutelef ;
	FROM inmov as a, inprod as b ;
	WHERE a.codprod = b.codprod ;
	AND (codlin ='0101' OR codlin = '0201') ;
	AND codtmo = 'S2' AND cantidad > 0 ;
	INTO CURSOR sales
	copy TO H:\REPORTES\topup\march\30\salesaff

**SELECT a.fecha as sold, ctod(SUBSTR(ALLTRIM(b.date_code),7,2)+"/"+SUBSTR(ALLTRIM(b.date_code),5,2)+"/"+SUBSTR(ALLTRIM(b.date_code),1,4)) as activated ,a.nudoc,a.codprocli, a.codbod, a.codprod,b.digicode, a.desprod, b.desprod,a.imei, a.imeif, a.nutelef,b.msisdn FROM  activations as a right JOIN dic120days as b ON a.nutelef = ALLTRIM(b.msisdn)
*	SELECT a.nudoc,a.codprod,a.fecha,b.fecha,a.codprocli, a.nutelef, ALLTRIM(b.comprador) as comprador, a.cantidad,a.vendido, b.debito FROM recargas as a inner JOIN vendido as b ON a.nutelef = ALLTRIM(comprador)
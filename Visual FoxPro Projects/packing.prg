CLOSE DATABASES
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
m.nudoc='0924000001'
*m.nudoc2='0900000192'
*m.bodent='0900'
*m.bodsal='0903'
SELECT 1
USE inemov SHARED
SET filter to nudoc=m.nudoc AND codtmo= 'ST'
*BROWSE noed
IF !EMPTY(nudoc)
	m.statuto = 'bueno'
	sele 1
	use inmov shared
	sele 2
	use inprod shared
	select a.nudoc, b.desprod, a.fecha, a.cantidad as qt, a.imei, a.imeif, a.nutelef, a.desprod as ck from inmov as a, inprod as b  Where a.codprod = b.codprod  AND codtmo= 'ST' ORDER BY NUDOC
	EXPORT TO C:\PACKING\PACKINGLIST type xl5
	
ELSE
	m.statuto = 'malo'	
endif

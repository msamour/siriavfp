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
SELECT nudoc, codtmo, fecha, codprod, imei, imeif, cantidad FROM inmov WHERE codbod ='0908' AND fecha <=CTOD('16/12/2008') AND codprod='35352902' ORDER BY imei

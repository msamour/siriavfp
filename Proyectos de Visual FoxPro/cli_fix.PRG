set default to j:\wapps9\digicel\inv\tablas
idowner='ZinterCODE'
OPEN DATABASE inven SHARED
USE cccli SHARED
UPDATE cccli;
	SET nomref1 = 'MARIO '+cccli.apecli+' '+cccli.apecli1;
	FROM cccli;
	WHERE EMPTY(nomref1)
SET TALK ON
UPDATE cccli;
	SET telcli = '222-3456';
	FROM cccli;
	WHERE EMPTY(telcli)
UPDATE cccli;
	SET telcli = '222-3678';
	FROM cccli;
	WHERE telcli= '    -     '
UPDATE cccli;
	SET dircli = 'BARRIO SAN FRANCISCO';
	FROM cccli;
	WHERE EMPTY(dircli)
UPDATE cccli;
	SET telref1 = cccli.telcli;
	FROM cccli;
	WHERE EMPTY(telref1)
UPDATE cccli;
	SET dirref1 = cccli.dircli;
	FROM cccli;
	WHERE EMPTY(dirref1)
UPDATE cccli;
	SET nomref2 = 'JOSE '+cccli.apecli+' '+cccli.apecli1;
	FROM cccli;
	WHERE EMPTY(nomref2)
UPDATE cccli;
	SET telref2 = cccli.telcli;
	FROM cccli;
	WHERE EMPTY(telref2)
UPDATE cccli;
	SET dirref2 = cccli.dircli;
	FROM cccli;
	WHERE EMPTY(dirref2)
UPDATE cccli;
	SET preguconfi = 'EQUIPO FAVORITO';
	FROM cccli;
	WHERE EMPTY(preguconfi)
UPDATE cccli;
	SET respuconfi = 'HONDURAS';
	FROM cccli;
	WHERE EMPTY(respuconfi)
**CLOSE DATABASES
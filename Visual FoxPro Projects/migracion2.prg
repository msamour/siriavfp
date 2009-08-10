WAIT 'Inciando... esper por favor...' TIMEOUT 0.0001 WINDOW NOWAIT 
SET CONSOLE OFF 
SET SAFETY OFF 
SET ENGINEBEHAVIOR 70
set default to j:\wapps9\digicel\inv\tablas
idowner='ZinterCODE'
OPEN DATABASE inven SHARED
SET DELETED ON
SET DATE TO YMD
SET CENTURY on
SET MARK to '-'
SET HOURS TO 24
SET TALK on

*m.fechai = thisform.olefechai._Value
*m.fechaf = thisform.olefechaf._Value
*m.reporte = thisform.optZona.Value
*thisform.optZona.Enabled = .F.
*thisform.cmdExportar.Enabled = .F.
mes = 07
ano = 2009


**Creamos la coneccion por ODBC. (forma chafa).
*!*	Global hCnxMySQL
*!*	Local lcDSN, lcUserID, lcUserPwd
*!*	lcDSN = "MysqlInterpos"
*!*	lcUserID = "root"
*!*	lcUserPwd = ""
*!*	hCnxMySQL = SQLConnect(lcDSN, lcUserID, lcUserPwd)

lcStringCnxRemoto = "DRIVER={MySQL ODBC 5.1 Driver};" + ;
                    "SERVER=192.168.1.2;" + ;
                    "PORT=3306;" + ;
                    "UID=root;" + ;
                    "PWD=;" + ;
                    "DATABASE=interpos;" + ;
                    "OPTIONS=131329;"

SQLSETPROP(0,"DispLogin" , 3 )
lnHandle = SQLSTRINGCONNECT(lcStringCnxRemoto)
**Borramos la data que vamos a remplazar.
TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
	DELETE FROM inmov WHERE MONTH(fecha) = <<mes>> AND YEAR(fecha) = <<ano>>
ENDTEXT
SQLEXEC(lnhandle,CSQL,"Micursor",micursor)
afectados = micursor(1,2)
**WAIT 'Records borrados '+STR(afectados) TIMEOUT 0.0001 WINDOW NOWAIT 
*WAIT 'Records borrados '+STR(afectados) TIMEOUT 0.0001 WINDOW NOWAIT 


**************************************

SELECT 1
USE inmov SHARED
GOTO top
m.mirecord = 0
SCAN FOR MONTH(fecha) = mes AND YEAR(fecha) = ano
	SCATTER NAME cinmov
	
	** Si la coneccion está abierta.
	IF lnHandle > 0 
	
		**Cambiamos los .F. a 0 NOTA: HACER ESTO MAS BONITO, DA PENA!!!!
		
		IF cinmov.cerrado = .f.
			cinmov.cerrado = 0
		ELSE
			cinmov.cerrado = 1
		ENDIF
		cinmov.IMEI = Z_ES(cinmov.IMEI)
		cinmov.IMEI = Z_ESBACK(cinmov.IMEI)
		cinmov.IMEIF = Z_ES(cinmov.IMEIF)
		cinmov.IMEIF = Z_ESBACK(cinmov.IMEIF)
		cinmov.NUTELEF = Z_ES(cinmov.NUTELEF)
		cinmov.NUTELEF = Z_ESBACK(cinmov.NUTELEF)
		cinmov.NUTELEF = Z_ESPLECA(cinmov.NUTELEF)
		cinmov.NUTELEF = Z_ESPLECA2(cinmov.NUTELEF)
		cinmov.CODPROCLI = Z_ES(cinmov.CODPROCLI)
		cinmov.CODPROCLI = Z_ESBACK(cinmov.CODPROCLI)
		TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
		INSERT INTO inmov
		(NUDOC, TIDOC, CODTMO, CODPROD, FECHA, CODPROCLI, CODSUBUNI, CANUNIDAD, CANTIDAD, PRECIOVTA, VALORUNI, VALORBRUTO, VALORNETO, VALORIVA, VALOR, VALORRETEN, PORDES, VALORDESCU, COSTO, FECHADIG, DESPROD, CODBOD, CODTCOMVTA, NUFAC, EXENTO, CERRADO, FACTORCAM, CODVEN, USUAMOD, IMEI, IMEIF, NUTELEF, VALCOSTO, CANBONI, CODDIS, PUNTOFAC, CODCAJERO, NUPIN)
		VALUES
		('<<cinmov.NUDOC>>', '<<cinmov.TIDOC>>', '<<cinmov.CODTMO>>', 
		'<<cinmov.CODPROD>>', "<<cinmov.FECHA>>", '<<cinmov.CODPROCLI>>', 
		'<<cinmov.CODSUBUNI>>', <<cinmov.CANUNIDAD>>, <<cinmov.CANTIDAD>>, 
		<<cinmov.PRECIOVTA>>, <<cinmov.VALORUNI>>, <<cinmov.VALORBRUTO>>, 
		<<cinmov.VALORNETO>>, <<cinmov.VALORIVA>>, <<cinmov.VALOR>>, 
		<<cinmov.VALORRETEN>>, <<cinmov.PORDES>>, <<cinmov.VALORDESCU>>, 
		<<cinmov.COSTO>>, "<<cinmov.FECHADIG>>", '<<cinmov.DESPROD>>', 
		'<<cinmov.CODBOD>>', '<<cinmov.CODTCOMVTA>>', '<<cinmov.NUFAC>>', 
		'<<cinmov.EXENTO>>', <<cinmov.CERRADO>>, <<cinmov.FACTORCAM>>, 
		'<<cinmov.CODVEN>>', '<<cinmov.USUAMOD>>', '<<cinmov.IMEI>>', 
		'<<cinmov.IMEIF>>', '<<cinmov.NUTELEF>>', <<cinmov.VALCOSTO>>, 
		<<cinmov.CANBONI>>, '<<cinmov.CODDIS>>', '<<cinmov.PUNTOFAC>>', 
		'<<cinmov.CODCAJERO>>', <<cinmov.NUPIN>>)		
	ENDTEXT
		SQLEXEC(lnhandle,CSQL,"Micursor",micursor)
		IF micursor(1,2) < 1
			m.lcStrErr = "Command ' " + "' failed. "+CHR(13)+ "At record number" + STR(RECNO())
			WAIT ''+  m.lcStrErr WINDOW
			exit
		endif
		*m.lcStrErr = ""
		*m.mirecord = RECNO()
		*m.lcStrErr = m.lcStrErr + IIF(SQLEXEC(lnhandle,CSQL) < 1, ;
		  "Command ' " + CSQL + "' failed. "+CHR(13), "")
		*? m.lcStrErr  
	ELSE 
		EXIT	
	ENDIF
	m.mirecord = m.mirecord +1
ENDSCAN

SQLDISCONNECT (lnHandle)
CLOSE DATABASES

WAIT 'Importacion Inemov Terminada '+STR(m.mirecord)+' Importados' WINDOW 

FUNCTION Z_ES()
* Escape String function
LPARAMETERS m.tcStringToEscape, m.tcDelimiter
IF PCOUNT() = 0
	RETURN
ELSE
	m.tcStringToEscape = ALLTRIM(m.tcStringToEscape)
	IF PCOUNT() = 1
		m.tcDelimiter = "'"
	ELSE
		m.tcDelimiter = m.tcDelimiter
	ENDIF
ENDIF
RETURN STRTRAN(m.tcStringToEscape, m.tcDelimiter, m.tcDelimiter+ m.tcDelimiter)

FUNCTION Z_ESBACK()
* Escape String function
LPARAMETERS m.tcStringToEscape, m.tcDelimiter
IF PCOUNT() = 0
	RETURN
ELSE
	m.tcStringToEscape = ALLTRIM(m.tcStringToEscape)
	IF PCOUNT() = 1
		m.tcDelimiter = "\"
	ELSE
		m.tcDelimiter = m.tcDelimiter
	ENDIF
ENDIF
RETURN STRTRAN(m.tcStringToEscape, m.tcDelimiter, "")

FUNCTION Z_ESPC()
* Escape String function
LPARAMETERS m.tcStringToEscape, m.tcDelimiter
IF PCOUNT() = 0
	RETURN
ELSE
	m.tcStringToEscape = ALLTRIM(m.tcStringToEscape)
	IF PCOUNT() = 1
		m.tcDelimiter = ";"
	ELSE
		m.tcDelimiter = m.tcDelimiter
	ENDIF
ENDIF
RETURN STRTRAN(m.tcStringToEscape, m.tcDelimiter, "")


FUNCTION Z_ESPLECA()
* Escape String function
LPARAMETERS m.tcStringToEscape, m.tcDelimiter
IF PCOUNT() = 0
	RETURN
ELSE
	m.tcStringToEscape = ALLTRIM(m.tcStringToEscape)
	IF PCOUNT() = 1
		m.tcDelimiter = "/"
	ELSE
		m.tcDelimiter = m.tcDelimiter
	ENDIF
ENDIF
RETURN STRTRAN(m.tcStringToEscape, m.tcDelimiter, "")

FUNCTION Z_ESPLECA2()
* Escape String function
LPARAMETERS m.tcStringToEscape, m.tcDelimiter
IF PCOUNT() = 0
	RETURN
ELSE
	m.tcStringToEscape = ALLTRIM(m.tcStringToEscape)
	IF PCOUNT() = 1
		m.tcDelimiter = "\"
	ELSE
		m.tcDelimiter = m.tcDelimiter
	ENDIF
ENDIF
RETURN STRTRAN(m.tcStringToEscape, m.tcDelimiter, "")
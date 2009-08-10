WAIT 'Inciando... esper por favor...' TIMEOUT 0.0001 WINDOW NOWAIT 
SET CONSOLE OFF 
SET SAFETY OFF 
SET ENGINEBEHAVIOR 70
set default to J:\Sky
idowner='ZinterCODE'
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


SELECT 1
USE ingresos
GOTO top
m.mirecord = 0
SCAN
	SCATTER NAME cingresos
	
	** Si la coneccion está abierta.
	IF lnHandle > 0 
	
		**Cambiamos los .F. a 0 NOTA: HACER ESTO MAS BONITO, DA PENA!!!!
*!*			
*!*			IF cingresos.enviaftp = .f.
*!*				cingresos.enviaftp = 0
*!*			ELSE
*!*				cingresos.enviaftp = 1
*!*			ENDIF
*!*			IF cingresos.enviadig = .f.
*!*				cingresos.enviadig = 0
*!*			ELSE
*!*				cingresos.enviadig = 1
*!*			ENDIF
		*cingresos.DESBOD = Z_ES(cingresos.DESBOD)
		*cingresos.DESBOD = Z_ESBACK(cingresos.DESBOD)
		*cingresos.DIRBOD = Z_ES(cingresos.DIRBOD)
		*cingresos.DIRBOD = Z_ESBACK(cingresos.DIRBOD)
		TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
		INSERT INTO ingresos
		(CODIGO, IMEI, SIM, NUTELEF, FECHA, INVOICE, CANTIDAD, COSTO)
		VALUES
		('<<cingresos.CODIGO>>', '<<cingresos.IMEI>>', '<<cingresos.SIM>>', '<<cingresos.NUTELEF>>', "<<cingresos.FECHA>>", '<<cingresos.INVOICE>>', <<cingresos.CANTIDAD>>, <<cingresos.COSTO>>)		
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

WAIT 'Importacion Terminada '+STR(m.mirecord)+' Importados' WINDOW 

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

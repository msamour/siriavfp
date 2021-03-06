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

**Creamos la coneccion por ODBC. (forma chafa).
*!*	Global hCnxMySQL
*!*	Local lcDSN, lcUserID, lcUserPwd
*!*	lcDSN = "MysqlInterpos"
*!*	lcUserID = "root"
*!*	lcUserPwd = ""
*!*	hCnxMySQL = SQLConnect(lcDSN, lcUserID, lcUserPwd)
mes = 07
ano = 2009

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
	DELETE FROM inemov WHERE MONTH(fecha) = <<mes>> AND YEAR(fecha) = <<ano>>
ENDTEXT
SQLEXEC(lnhandle,CSQL,"Micursor",micursor)
afectados = micursor(1,2)
WAIT 'Records borrados '+STR(afectados) TIMEOUT 0.0001 WINDOW NOWAIT 



**************************************
SELECT 1
USE inemov SHARED
GOTO top
m.mirecord = 0
SCAN FOR MONTH(fecha) = mes AND YEAR(fecha) = ano
	SCATTER NAME cinemov
	
	** Si la coneccion est� abierta.
	IF lnHandle > 0 
	
		**Cambiamos los .F. a 0 NOTA: HACER ESTO MAS BONITO, DA PENA!!!!
		IF m.cinemov.impreso = .f.
			m.impreso = 0
		ELSE
			m.impreso = 1
		ENDIF
		IF cinemov.cerrado = .f.
			m.cerrado = 0
		ELSE
			m.cerrado = 1
		ENDIF
		IF cinemov.expor = .f.
			m.expor = 0
		ELSE
			m.expor = 1
		ENDIF
		cinemov.NOMCLI = Z_ES(cinemov.NOMCLI)
		cinemov.NOMCLI = Z_ESBACK(cinemov.NOMCLI)
		cinemov.NOTAS = Z_ES(cinemov.NOTAS)
		cinemov.NOTAS = Z_ESBACK(cinemov.NOTAS)
		cinemov.NOTAS1 = Z_ES(cinemov.NOTAS1)
		cinemov.CODPROCLI = Z_ES(cinemov.CODPROCLI)
		cinemov.CODPROCLI = Z_ESBACK(cinemov.CODPROCLI)
		TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
		INSERT INTO inemov
		(NUDOC, CODTMO, TIDOC, FECHA, CODPROCLI, VALORBRUTO, VALORNETO, VALORIVA, VALOR, VALORDESCU, VALOREXE, VALORRETEN, NOMCLI, NUFAC, NUDEV, FECHAFAC, CODTCOMVTA, CODBOD, CODBODD, IMPRESO, CERRADO, CODVEN, CODVENEX, EXENTO, PLAZO, FECHAANU, USUAMOD, MONEDA, FACTORCAM, QUEDAN, EXPOR, COTIZA, PORDES, PEDIDO, TIPODEV, NOTAS, NOTAS1, GRANCONTRI, PERMITENC, EFECTIVOD, EFECTIVODL, EFECTIVO, CHEQUE, TARJETA, CAMBIO, CAMBIOD, NUMTARJETA, NUMCHEQUE, CODTARJE, CODBAN, TELEFONO, NUAUTOTAR, NUVAUCHER, NURESERVA, CODCAJERO, IDCOMPANY, USUARIO, PUNTOFAC, FECHALIQ, NUREGCLI)
		VALUES
		('<<cinemov.NUDOC>>', '<<cinemov.CODTMO>>', '<<cinemov.TIDOC>>', "<<cinemov.FECHA>>", 
		'<<cinemov.CODPROCLI>>', <<cinemov.VALORBRUTO>>,
		 <<cinemov.VALORNETO>>, <<cinemov.VALORIVA>>, 
		<<cinemov.VALOR>>, <<cinemov.VALORDESCU>>, 
		<<cinemov.VALOREXE>>, <<cinemov.VALORRETEN>>, 
		'<<cinemov.NOMCLI>>', '<<cinemov.NUFAC>>', 
		'<<cinemov.NUDEV>>', "<<cinemov.FECHAFAC>>", 
		'<<cinemov.CODTCOMVTA>>', '<<cinemov.CODBOD>>', 
		'<<cinemov.CODBODD>>', <<m.IMPRESO>>, 
		<<m.CERRADO>>, 
		'<<cinemov.CODVEN>>', 
		'<<cinemov.CODVENEX>>', 
		'<<cinemov.EXENTO>>', 
		<<cinemov.PLAZO>>, "<<cinemov.FECHAANU>>", '<<cinemov.USUAMOD>>', '<<cinemov.MONEDA>>', 
		<<cinemov.FACTORCAM>>, '<<cinemov.QUEDAN>>', <<m.EXPOR>>, '<<cinemov.COTIZA>>', 
		<<cinemov.PORDES>>, '<<cinemov.PEDIDO>>', <<cinemov.TIPODEV>>, '<<cinemov.NOTAS>>', 
		'<<cinemov.NOTAS1>>', '<<cinemov.GRANCONTRI>>', <<cinemov.PERMITENC>>, <<cinemov.EFECTIVOD>>, 
		<<cinemov.EFECTIVODL>>, <<cinemov.EFECTIVO>>, <<cinemov.CHEQUE>>, <<cinemov.TARJETA>>, <<cinemov.CAMBIO>>, <<cinemov.CAMBIOD>>, '<<cinemov.NUMTARJETA>>', '<<cinemov.NUMCHEQUE>>', '<<cinemov.CODTARJE>>', '<<cinemov.CODBAN>>', '<<cinemov.TELEFONO>>', '<<cinemov.NUAUTOTAR>>', '<<cinemov.NUVAUCHER>>', '<<cinemov.NURESERVA>>', '<<cinemov.CODCAJERO>>', '<<cinemov.IDCOMPANY>>', '<<cinemov.USUARIO>>', '<<cinemov.PUNTOFAC>>', "<<cinemov.FECHALIQ>>", '<<cinemov.NUREGCLI>>')		
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

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

lcStringCnxRemoto = "DRIVER={MySQL ODBC 5.1 Driver};" + ;
                    "SERVER=192.168.1.2;" + ;
                    "PORT=3306;" + ;
                    "UID=root;" + ;
                    "PWD=;" + ;
                    "DATABASE=interpos;" + ;
                    "OPTIONS=131329;"

SQLSETPROP(0,"DispLogin" , 3 )
lnHandle = SQLSTRINGCONNECT(lcStringCnxRemoto)

TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
	TRUNCATE inbod
ENDTEXT
SQLEXEC(lnhandle,CSQL,"Micursor",micursor)

SELECT 1
USE inbod SHARED
GOTO top
m.mirecord = 0
SCAN
	SCATTER NAME cinbod
	
	** Si la coneccion está abierta.
	IF lnHandle > 0 
	
		**Cambiamos los .F. a 0 NOTA: HACER ESTO MAS BONITO, DA PENA!!!!
		
		IF cinbod.enviaftp = .f.
			cinbod.enviaftp = 0
		ELSE
			cinbod.enviaftp = 1
		ENDIF
		IF cinbod.enviadig = .f.
			cinbod.enviadig = 0
		ELSE
			cinbod.enviadig = 1
		ENDIF
		cinbod.DESBOD = Z_ES(cinbod.DESBOD)
		cinbod.DESBOD = Z_ESBACK(cinbod.DESBOD)
		cinbod.DIRBOD = Z_ES(cinbod.DIRBOD)
		cinbod.DIRBOD = Z_ESBACK(cinbod.DIRBOD)
		TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
		INSERT INTO inbod
		(CODDIS, CODBOD, DESBOD, TELBOD, 
		FAXBOD, EMAIL, ENCARGADO, DIRBOD, 
		CODZONA, CODCORDI, CODDIGI, CTAIVAVTA, 
		CTAIVACOM, CODCAJA, CODREB, CTARETEN, 
		CTAPERCE, CTAINVEN, CTACOSTO, CTAVTA, 
		CTADEV, CTACLI, CTAPROV, 
		CTAAPROMAY, CTAAPROMEN, CTAINVMU, CTAINVTE, 
		CTAINVTA, CTAINVRE, CTAVTAMU, CTAVTATE, 
		CTAVTATA, CTAVTARE, CTAREBMU, CTAREBTE, 
		CTAREBTA, CTAREBRE, CTACOSMU, CTACOSTE, 
		CTACOSTA, CTACOSRE, ENVIAFTP, FENVIAFTP, 
		ENVIADIG, FENVIADIG, OLDCODDIS)
		VALUES
		('<<cinbod.CODDIS>>', '<<cinbod.CODBOD>>', '<<cinbod.DESBOD>>', '<<cinbod.TELBOD>>', 
		'<<cinbod.FAXBOD>>', '<<cinbod.EMAIL>>', '<<cinbod.ENCARGADO>>', '<<cinbod.DIRBOD>>', 
		'<<cinbod.CODZONA>>', '<<cinbod.CODCORDI>>', '<<cinbod.CODDIGI>>', '<<cinbod.CTAIVAVTA>>', 
		'<<cinbod.CTAIVACOM>>', '<<cinbod.CODCAJA>>', '<<cinbod.CODREB>>', '<<cinbod.CTARETEN>>', 
		'<<cinbod.CTAPERCE>>', '<<cinbod.CTAINVEN>>', '<<cinbod.CTACOSTO>>', '<<cinbod.CTAVTA>>', 
		'<<cinbod.CTADEV>>', '<<cinbod.CTACLI>>', '<<cinbod.CTAPROV>>', 
		'<<cinbod.CTAAPROMAY>>', '<<cinbod.CTAAPROMEN>>', '<<cinbod.CTAINVMU>>', '<<cinbod.CTAINVTE>>', 
		'<<cinbod.CTAINVTA>>', '<<cinbod.CTAINVRE>>', '<<cinbod.CTAVTAMU>>', '<<cinbod.CTAVTATE>>', 
		'<<cinbod.CTAVTATA>>', '<<cinbod.CTAVTARE>>', '<<cinbod.CTAREBMU>>', '<<cinbod.CTAREBTE>>', 
		'<<cinbod.CTAREBTA>>', '<<cinbod.CTAREBRE>>', '<<cinbod.CTACOSMU>>', '<<cinbod.CTACOSTE>>', 
		'<<cinbod.CTACOSTA>>', '<<cinbod.CTACOSRE>>', <<cinbod.ENVIAFTP>>, "<<cinbod.FENVIAFTP>>", 
		<<cinbod.ENVIADIG>>, "<<cinbod.FENVIADIG>>", '<<cinbod.OLDCODDIS>>')		
	ENDTEXT
		SQLEXEC(lnhandle,CSQL,"Micursor",micursor)
		IF micursor(1,2) < 1
			m.lcStrErr = "Command cinbod' " + "' failed. "+CHR(13)+ "At record number" + STR(RECNO())
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

*****************************
**Importacion Catalogo Inlin
*****************************
TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
	TRUNCATE inlin
ENDTEXT
SQLEXEC(lnhandle,CSQL,"Micursor",micursor)


SELECT 1
USE inlin SHARED
GOTO top
m.mirecord = 0
SCAN
	SCATTER NAME cinlin
	
	** Si la coneccion está abierta.
	IF lnHandle > 0 
	
		TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
		INSERT INTO inlin
		(CODLIN, DESLIN, CODGRU, ABREVIA, COMISION, PROPINA, PRODDIGI, CTAVENTA, CTAINVEN, CTACOSTO, CTAMETRA, CTACAJA)
		VALUES
		('<<cinlin.CODLIN>>', '<<cinlin.DESLIN>>', '<<cinlin.CODGRU>>', '<<cinlin.ABREVIA>>', <<cinlin.COMISION>>, <<cinlin.PROPINA>>, <<cinlin.PRODDIGI>>, '<<cinlin.CTAVENTA>>', '<<cinlin.CTAINVEN>>', '<<cinlin.CTACOSTO>>', '<<cinlin.CTAMETRA>>', '<<cinlin.CTACAJA>>')		
	ENDTEXT
		SQLEXEC(lnhandle,CSQL,"Micursor",micursor)
		IF micursor(1,2) < 1
			m.lcStrErr = "Command cinlin' " + "' failed. "+CHR(13)+ "At record number" + STR(RECNO())
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



***********Fin importacion Catalago Inlin


**************************
** Mirgracion de data Inprod
**************************
TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
	TRUNCATE inprod
ENDTEXT
SQLEXEC(lnhandle,CSQL,"Micursor",micursor)

SELECT 1
USE inprod SHARED
GOTO top
m.mirecord = 0
SCAN
	SCATTER NAME cinprod
	
	** Si la coneccion está abierta.
	IF lnHandle > 0 
	
		
		TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
		INSERT INTO inprod
		(CODPROD, DESPROD, DESCORTA, UNIPRE, UNIXPRE, EXINICIAL, ENTRADAS, SALIDAS, EXACTUAL, COSTOINI, COSTOENT, COSTOSAL, COSTOACT, COSTOUNI, COSUNIANT, COSPROANT, COSPRO, PRECIOVTA, PORDES, VALDES, CANULVTA, FECULVTA, CANULCOM, FECULCOM, FECHAING, EXIMIN, EXIMAX, REORDEN, CODPROMO, CODLIN, CODMAR, EXENTO, CANULSAL, VALULSAL, COSTODIG, COSCOMES, COMMES, FECULENT, CANULENT, PORCENUTIL, IMPUESTO, CLASIFICA, CBARRA, APLICACION, CODPRODP, CODPROV, EXINICOS, ENTCOSTO, SALCOSTO, EXACTCOS, VALCOSANT, EXIREPOR, COSREPOR, OBSOLETO, CODUNI, VERIEXI, TIPOINV, CODPRODO, PORCOMI, APLIDES, APLICARET, CODGRU, GARANPROV, GARANTIA, PRECIOVAR, RIMEI, RIMEIF, LRIMEI, LNUTEL, LRIMEIF, RNUTEL, CODMOD, ENREMISION, MODICAN, REMIORDEN, REFURBISH, CHIPINCOR, CODCONPRO, RPIN)
		VALUES
		('<<inprod.CODPROD>>', '<<inprod.DESPROD>>', '<<inprod.DESCORTA>>', '<<inprod.UNIPRE>>', <<inprod.UNIXPRE>>, <<inprod.EXINICIAL>>, <<inprod.ENTRADAS>>, <<inprod.SALIDAS>>, <<inprod.EXACTUAL>>, <<inprod.COSTOINI>>, <<inprod.COSTOENT>>, <<inprod.COSTOSAL>>, <<inprod.COSTOACT>>, <<inprod.COSTOUNI>>, <<inprod.COSUNIANT>>, <<inprod.COSPROANT>>, <<inprod.COSPRO>>, <<inprod.PRECIOVTA>>, <<inprod.PORDES>>, <<inprod.VALDES>>, <<inprod.CANULVTA>>, "<<inprod.FECULVTA>>", <<inprod.CANULCOM>>, "<<inprod.FECULCOM>>", "<<inprod.FECHAING>>", <<inprod.EXIMIN>>, <<inprod.EXIMAX>>, <<inprod.REORDEN>>, '<<inprod.CODPROMO>>', '<<inprod.CODLIN>>', '<<inprod.CODMAR>>', '<<inprod.EXENTO>>', <<inprod.CANULSAL>>, <<inprod.VALULSAL>>, <<inprod.COSTODIG>>, <<inprod.COSCOMES>>, <<inprod.COMMES>>, "<<inprod.FECULENT>>", '<<inprod.CANULENT>>', '<<inprod.PORCENUTIL>>', '<<inprod.IMPUESTO>>', '<<inprod.CLASIFICA>>', '<<inprod.CBARRA>>', '<<inprod.APLICACION>>', '<<inprod.CODPRODP>>', '<<inprod.CODPROV>>', <<inprod.EXINICOS>>, <<inprod.ENTCOSTO>>, <<inprod.SALCOSTO>>, <<inprod.EXACTCOS>>, <<inprod.VALCOSANT>>, <<inprod.EXIREPOR>>, <<inprod.COSREPOR>>, <<inprod.OBSOLETO>>, '<<inprod.CODUNI>>', <<inprod.VERIEXI>>, <<inprod.TIPOINV>>, '<<inprod.CODPRODO>>', <<inprod.PORCOMI>>, <<inprod.APLIDES>>, <<inprod.APLICARET>>, '<<inprod.CODGRU>>', <<inprod.GARANPROV>>, <<inprod.GARANTIA>>, <<inprod.PRECIOVAR>>, <<inprod.RIMEI>>, <<inprod.RIMEIF>>, <<inprod.LRIMEI>>, <<inprod.LNUTEL>>, <<inprod.LRIMEIF>>, <<inprod.RNUTEL>>, '<<inprod.CODMOD>>', <<inprod.ENREMISION>>, <<inprod.MODICAN>>, <<inprod.REMIORDEN>>, <<inprod.REFURBISH>>, <<inprod.CHIPINCOR>>, '<<inprod.CODCONPRO>>', <<inprod.RPIN>>)		
	ENDTEXT
		SQLEXEC(lnhandle,CSQL,"Micursor",micursor)
		IF micursor(1,2) < 1
			m.lcStrErr = "Command cinprod' " + "' failed. "+CHR(13)+ "At record number" + STR(RECNO())
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


************************
**Fin migracion de Inprod
******************************

************************+
***Migracion de base invta
************************+

SELECT 1
USE intvta SHARED
GOTO top
m.mirecord = 0
SCAN
	SCATTER NAME cintvta
	
	** Si la coneccion está abierta.
	IF lnHandle > 0 
	
		
		TEXT TO cSQL TEXTMERGE NOSHOW PRETEXT 7
		INSERT INTO intvta
		(CODTVTA, DESTVTA, RELACXC, PORDES, RELATARJET, RELAPOSPA)
		VALUES
		('<<cintvta.CODTVTA>>', '<<cintvta.DESTVTA>>', '<<cintvta.RELACXC>>', <<cintvta.PORDES>>, '<<cintvta.RELATARJETA>>', <<cintvta.RELAPOSPA>>)		
	ENDTEXT
		SQLEXEC(lnhandle,CSQL,"Micursor",micursor)
		IF micursor(1,2) < 1
			m.lcStrErr = "Command cintvta' " + "' failed. "+CHR(13)+ "At record number" + STR(RECNO())
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

**************************
**Fin Migracion invta
**********************

*Cerramos la coneccion con Mysql
SQLDISCONNECT (lnHandle)
**Cerramos las tablas locales

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

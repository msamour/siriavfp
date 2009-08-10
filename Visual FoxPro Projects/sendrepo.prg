*******************************
*!* Ejemplo de utilización de SendViaMAPI
*******************************
DIMENSION aryAttach(2)
aryAttach(1) = "C:\REPORTES\rep_digi_post_sap.xls" && cambie a un archivo real que existe en su PC
aryAttach(2) = "C:\REPORTES\rep_digi_pre_sap.xls" && cambie a un archivo real que existe en su PC
aryAttach(3) = "C:\REPORTES\rep_digi_post_tgu.xls" && cambie a un archivo real que existe en su PC
aryAttach(4) = "C:\REPORTES\rep_digi_post_tgu.xls" && cambie a un archivo real que existe en su PC
LOCAL lcTo, lcSubject, lcBody, lnCount, lcCC, lcBCC, lcUserName, lcPassword, llOpenEmail, lcErrReturn
lcTo = "it@fimihonduras.com"
lcSubject = "Envio de Reporte de Digicel de las "
lcBody = "Quiero hacerle saber que VFP es muy versátil" + CHR(13) + "y hay muchas formas de enviar un email."
lcCC = "otro@otrodominio.com"
lcBCC = "mijefe@dominiodeljefe.com"
lcUserName = "yo@midominio.com" && mi nombre de usuario SMTP 
lcPassword = "Mi_PaSsWoRd" && mi contraseña SMTP 
*!* para enviar correo automáticamente haga llOpenEmail igual a .F.
llOpenEmail = .T. && Si el correo se abrió o no, en el cliente de correo MAPI
SendViaMAPI(@lcErrReturn, lcTo, lcSubject, lcBody, @aryAttach, lcCC, lcBCC, lcUserName, lcPassword, llOpenEmail)
IF EMPTY(lcErrReturn)
  MESSAGEBOX("'" + lcSubject + "'  se envió satisfactoriamente.", 64, "Envía email via MAPI")
ELSE
  MESSAGEBOX("'" + lcSubject + "' falló al enviar. Causa:" + CHR(13) + lcErrReturn, 64, "Envía email via MAPI")
ENDIF

*******************************************
PROCEDURE SendViaMAPI(tcReturn, tcTo, tcSubject, tcBody, taFiles, tcCC, tcBCC, tcUserName, tcPassword, tlOpenEmail)
*******************************************
  #DEFINE PRIMARY 1
  #DEFINE CARBON_COPY 2
  #DEFINE BLIND_CARBON_COPY 3
  LOCAL loSession, loMessages, lnAttachments, loError AS EXCEPTION, loErrorSend AS EXCEPTION
  tcReturn = ""
  TRY
    loSession = CREATEOBJECT( "MSMAPI.MAPISession" )
    IF TYPE("tcUserName") = "C"
      loSession.UserName = tcUserName
    ENDIF
    IF TYPE("tcPassword") = "C"
      loSession.PASSWORD = tcPassword
    ENDIF
    loSession.Signon()
    IF (loSession.SessionID > 0)
      loMessages = CREATEOBJECT( "MSMAPI.MAPIMessages" )
      loMessages.SessionID = loSession.SessionID
    ENDIF
    WITH loMessages
      .Compose()
      .RecipDisplayName = tcTo
      .RecipType = PRIMARY
      .ResolveName()
      IF TYPE("tcCC") = "C"
        .RecipIndex = .RecipCount
        .RecipDisplayName = tcCC
        .RecipType = CARBON_COPY
        .ResolveName()
      ENDIF
      IF TYPE("tcBCC") = "C"
        .RecipIndex = .RecipCount
        .RecipDisplayName = tcBCC
        .RecipType = BLIND_CARBON_COPY
        .ResolveName()
      ENDIF
      .MsgSubject = tcSubject
      .MsgNoteText = tcBody
      IF TYPE("taFiles", 1) = "A"
        lnAttachments = ALEN(taFiles)
        IF LEN(tcBody) < lnAttachments && Se asegura que el cuerpo es suficientemente grande para los adjuntos
          tcBody = PADR(tcBody, lnAttachments, " ")
        ENDIF
        FOR lnCountAttachments = 1 TO lnAttachments
          .AttachmentIndex = .AttachmentCount
          .AttachmentPosition = .AttachmentIndex
          .AttachmentName = JUSTFNAME(taFiles(lnCountAttachments))
          .AttachmentPathName = taFiles(lnCountAttachments)
        ENDFOR
      ENDIF
      TRY
        .SEND(tlOpenEmail)
      CATCH TO loErrorSend
        IF tlOpenEmail && El usuario canceló la operación desde su cliente de correo?
          tcReturn = "El usuario canceló el envío de correo."
        ELSE
          THROW loErrorSend
        ENDIF
      ENDTRY
    ENDWITH
    loSession.Signoff()
  CATCH TO loError
    tcReturn = [Error: ] + STR(loError.ERRORNO) + CHR(13) + ;
      [LineNo: ] + STR(loError.LINENO) + CHR(13) + ;
      [Message: ] + loError.MESSAGE + CHR(13) + ;
      [Procedure: ] + loError.PROCEDURE + CHR(13) + ;
      [Details: ] + loError.DETAILS + CHR(13) + ;
      [StackLevel: ] + STR(loError.STACKLEVEL) + CHR(13) + ;
      [LineContents: ] + loError.LINECONTENTS
  FINALLY
    STORE .NULL. TO loSession, loMessages
    RELEASE loSession, loMessages
  ENDTRY
ENDPROC
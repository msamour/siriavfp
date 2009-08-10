cConnectString = [Provider=VFPOLEDB.1;Data Source=] + [C:\wapps9\digicel\inv\TABLAS\inven.dbc;] + ;
  [Mode=ReadWrite|Share Deny None;Password="idowner='ZinterCODE'";Collating Sequence=MACHINE]
oConn = CreateObject("ADODB.Connection")
oConn.ConnectionString = cConnectString
oConn.ConnectionTimeout = 30
oConn.Open
cSQL = "select * from inemov where codtmo = 'SJ' "
oRS = oConn.Execute (cSQL)
if oRS.EOF
   ? "No records found."
   oRS.Close
   oConn.CLose
   RELEASE oRS, oConn
   RETURN
endif

do while !oRS.EOF
   ? oRS.Fields("nutelef").Value + " - " + ;
      oRS.Fields("imei").Value
   oRS.MoveNext
enddo

oRS.Close
oConn.CLose
RELEASE oRS, oConn
RETURN

#include "protheus.ch"

User function Ajupedv()

Local cQuery	:= ""
Local cNumAnt	:= ""
Local cItAnt	:= ""
Local sDataAnt	:= ""
Local cFilSC6	:= xFilial("SC6")

SC6->(dbSetOrder(1))

cQuery += "SELECT C6_NUM,C6_ENTREG,C6_ITEM "
cQuery += "FROM SC6010 "
cQuery += "WHERE D_E_L_E_T_ <> '*' "
cQuery += "AND C6_FILIAL = '01' "
cQuery += "AND C6_NUM BETWEEN 'OR0001' AND 'OR9999' "
cQuery += "AND C6_ENTREG >= '20150101' "
cQuery += "AND C6_NOTA = '' "
cQuery += "ORDER BY C6_NUM,C6_ENTREG,C6_ITEM"
cQuery := ChangeQuery(cQuery)

If  Select("TMP99") > 0
	DbSelectArea("TMP99")
	DbCloseArea()
Endif

dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),"TMP99",.T.,.F.)
dbSelectArea("TMP99")

//COPY TO "PEDINV.DBF"

dbGotop()
While !Eof()

	If !Empty(cNumAnt) .and. cNumAnt == TMP99->C6_NUM .and. sDataAnt == TMP99->C6_ENTREG
		If SC6->(dbSeek(cFilSC6+cNumAnt+cItAnt))
			Reclock("SC6")
			dbDelete()
			SC6->(MsUnlock())
		EndIf
	EndIf
	
	dbSelectArea("TMP99")
	
	cNumAnt		:= TMP99->C6_NUM
	cItAnt		:= TMP99->C6_ITEM
	sDataAnt	:= TMP99->C6_ENTREG
	
	dbSkip()

EndDo

dbCloseArea()

MsgAlert("Acabei!")

Return


User Function Identpv()

Local cQuery	:= ""
Local cFilSC6	:= xFilial("SC6")
Local nPrcVen	:= 0
Local lAltera	:= .F.

SC6->(dbSetOrder(1))

cQuery += "SELECT C6_NUM,C6_PRCVEN "
cQuery += "FROM SC6010 "
cQuery += "WHERE D_E_L_E_T_ <> '*' "
cQuery += "AND C6_FILIAL = '01' "
cQuery += "AND C6_NUM BETWEEN 'OR0001' AND 'OR9999' "
cQuery += "AND C6_ENTREG BETWEEN '20141201' AND '20141231' "
//cQuery += "AND C6_NOTA = '' "
cQuery += "ORDER BY C6_NUM"
cQuery := ChangeQuery(cQuery)

If  Select("TMP99") > 0
	DbSelectArea("TMP99")
	DbCloseArea()
Endif

dbUseArea(.T.,'TOPCONN',TcGenQry(,,cQuery),"TMP99",.T.,.F.)
TcSetField("TMP99","C6_PRCVEN"  ,"N",TamSX3("C6_PRCVEN")[1],TamSX3("C6_PRCVEN")[2]) 

dbSelectArea("TMP99")

dbGotop()
While !Eof()
	
	SC6->(dbSeek(cFilSC6+TMP99->C6_NUM))
	While !Eof() .and. SC6->C6_FILIAL == cFilSC6 .and. SC6->C6_NUM == TMP99->C6_NUM
		
		If Year(SC6->C6_ENTREG) == 2015
			If TMP99->C6_PRCVEN == 499.00
				nPrcVen	:= 623.75
				lAltera	:= .T.
			ElseIf TMP99->C6_PRCVEN == 631.42
				nPrcVen	:= 790.00			
				lAltera	:= .T.				
			ElseIf TMP99->C6_PRCVEN == 763.84
				nPrcVen	:= 956.25
				lAltera	:= .T.				
			ElseIf TMP99->C6_PRCVEN == 896.26
				nPrcVen	:= 1122.50			
				lAltera	:= .T.				
			ElseIf TMP99->C6_PRCVEN == 1028.68
				nPrcVen	:= 1288.75
				lAltera	:= .T.				
			EndIf

			If lAltera
				Reclock("SC6")
			    SC6->C6_PRCVEN	:= nPRCVEN
			    SC6->C6_VALOR	:= Round(SC6->C6_QTDVEN * nPRCVEN,2)
			    SC6->(MsUnlock())
		    EndIf
		    
		    lAltera	:= .F.
		
		EndIf
		
		SC6->(dbSkip())
		
	EndDo
	
	dbSelectArea("TMP99")
	dbSkip()

EndDo

dbCloseArea()

MsgAlert("Acabei!")

Return
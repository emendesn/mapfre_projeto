#include "rwmake.ch"
#include "topconn.ch"
#Define CRLF CHR(13)+CHR(10)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � DiarioCt2  � Autor � Trade                 � Data � 15.03.11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Gera��o do arquivo texto contendo lan�amentos cont�beis    ���
���          � de acordo com layout Espanhol                              ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � Chamada padr�o para programas em RDMake.                   ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Generico                                                   ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �  /  /  �      �-                                         ���
���            �        �      �                                          ���
���            �        �      �                                          ���
���            �        �      �                                          ���
���            �        �      �                                          ���
���            �        �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function DiarioCt2()


Private CNOMEARQ,LEND,LCONTINUA,LABORTPRINT,LIMPLIS,NHDL
Private CPERG,NLIN0,NAVISO,NVALVA,NQTDVA,NX
Private NDAFAS,NDTRAB,NSEQ,NTOTFUN,NTOTVL,CTIPO
Private CLIN,LLIN0,LFLAG,LCARE_,AINFOE,ACAMP
Private CFILDE,CFILATE,CMATDE,CMATATE
Private DDTENT,CCODCLI,LCENTENT,CLOCENT,CRESP,CARQ

Private _CFILANT,CENT_,CDESCR,NTOTIT,NVALVR,NQTDVR

Private CPROD,CMESREF,CDTENTR,CDTEMIS,CTIPPED,CNOMEEMP
Private CSEQ,CTIPLOG,CEND,CCOMPL,CMUNIC,CBAIR

Private CCEP,CEST,CCOMPCEP,CFILMAT,CDATNASC,CNOMEFUN
Private CTOTFUN,CTOTVL,AITENS,ATOTITENS,NTOTBN,NVALSR
Private NVALIR,NTOTBNVR,CCOB_,LCARC_,AREGS,NSX1ORDER
Private NY,CSTRING,CTAMANHO,CLIMITE,CTITULO,CDESC1
Private CDESC2,CDESC3,CCANCEL,ARETURN,NLASTKEY,NPOS1
Private NPOS2,NPOS3,NLIN,NTFUNC,NTVALE,NTVALO,CTOTVR
Private NTVA,NTVT,NTVR,NTOTVA,NTOTVT,NTOTVR,CVALVR,NTOTVR
Private NTVALVA,NTVALVT,NTVALVR,NVALOR,NVALE,NTOTAL,CQTDVR
Private WNREL,NPOS4,CTEMP,NSM0RECNO,AINFOC,CDIASMES,NVALBE,AREGS


Private nLin0,_nQtdReg

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
cNomeArq    := ''

lEnd        := .F.
lContinua   := .T.
lAbortPrint := .F.
lImpLis     := .F.
nHdl        := 0


//���������������������������������������������������������������������Ŀ
//� Verifica as perguntas                                               �
//���������������������������������������������������������������������Ĵ
//� mv_par01    Cod.da Companhia  -  Cod.DIARIO                         �
//� mv_par03    Data De           -  Data Inicial                       �
//� mv_par04    Data Ate          -  Dat Final                          �
//� mv_par05    Nome do Arquivo   -  Nome do Arquivo                    �
//�����������������������������������������������������������������������
cPerg := 'GERCT2'

VALIDPERG()

//���������������������������������������������������������������������Ŀ
//� Montagem da tela                                                    �
//�����������������������������������������������������������������������

If !Pergunte(cPerg, .T.)
	Return
EndIf

@000,000 TO 250,500 DIALOG oDlg TITLE 'Geracao de Arquivo Texto de Lancamentos Contabeis.'
@ 010,005 TO 100,245
@ 030,010 SAY OemtoAnsi('Este  programa ira gerar um arquivo texto, conforme a parametri- ')
@ 040,010 SAY OemtoAnsi('zacao  definida  pelo  usuario  e  Lay-Out definido ')
@ 050,010 SAY OemtoAnsi(', contendo informacoes de lancamentos contabeis')
@ 060,010 SAY OemtoAnsi('do �periodo solicitado.')

@ 104,158 BMPBUTTON TYPE 5 ACTION Pergunte(cPerg, .T.)
@ 104,188 BMPBUTTON TYPE 2 ACTION oDlg:End()
@ 104,218 BMPBUTTON TYPE 1 ACTION ( ContCT2() , oDlg:End() )

ACTIVATE DIALOG oDlg CENTERED

If nHdl > 0
	If fClose(nHdl)
		If nLin0 > 0 .And. lContinua
			Aviso('AVISO','Gerado o arquivo ' + AllTrim(AllTrim(cNomeArq)) + '...',{'OK'})
			
		Else
			If fErase(cNomeArq) == 0
				If lContinua
					Aviso('AVISO','Nao existem registros a serem gravados. A geracao do arquivo ' + AllTrim(AllTrim(cNomeArq)) + ' foi abortada ...',{'OK'})
				EndIf
			Else
				MsgAlert('Ocorreram problemas na tentativa de delecao do arquivo '+AllTrim(cNomeArq)+'.')
			EndIf
		EndIf
	Else
		MsgAlert('Ocorreram problemas no fechamento do arquivo '+AllTrim(cNomeArq)+'.')
	EndIf
EndIf

//Deleta Arquivo Temporario
If lImpLis
	dbSelectArea('TMP')
	dbCloseArea('TMP')
	fErase(cArq + '.DBF')
End

Return

// Fim da Rotina

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �  ContCT2     � Autor � Trade            � Data � 14.03.11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Fun��o para continua��o do processamento (na confirma��o)  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � ContCT2()                                                  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � DiarioCt2                                                  ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ContCT2()

//���������������������������������������������������������������������Ŀ
//� Inicializa variaveis utilizadas pelo programa                       �
//�����������������������������������������������������������������������
nLin0   := 0
nAviso  := 0
nValVA  := 0
nQtdVA  := 0
nValVR  := 0
nQtdVR  := 0
nX      := 0
nDafas  := 0
nDtrab  := 30
nSeq    := 1
nTotFun := 0
nTotVl  := 0
nValBe  := 0
nTotVR  := 0
cTipo   := ''
cLin    := ''
cDiasMes:= ''
lLin0   := .F.
lFlag   := .F.
lCarE_  := .T.
aInfoE  := {}
aCamp   := {}

//���������������������������������������������������������������������Ŀ
//� Inicializa variaveis utilizadas como Pergunte                       �
//�����������������������������������������������������������������������
cCodCia   := mv_par01 // NRO DO DIARIO
dDatIni   := mv_par03 // Data Inicial
dDatFin   := mv_par04 // Data final
cNomeArq  := mv_par05 // Arquivo Texto

//���������������������������������������������������������������������Ŀ
//� Cria o arquivo texto                                                �
//�����������������������������������������������������������������������
Do While .T.
	If File(cNomeArq)
		If (nAviso := Aviso('ARQUIVO J� EXISTE!','Substituir o ' + AllTrim(cNomeArq) + ' existente ?', {'Sim','Nao','Cancela'})) == 1
			If fErase(cNomeArq) == 0
				Exit
			Else
				MsgAlert('Ocorreram problemas na tentativa de delecao do arquivo '+AllTrim(cNomeArq)+'.')
			EndIf
		ElseIf nAviso == 2
			Pergunte(cPerg,.T.)
			Loop
		Else
			Return
		EndIf
	Else
		Exit
	EndIf
EndDo

nHdl := fCreate(cNomeArq)

If nHdl == -1
	MsgAlert('O arquivo '+AllTrim(cNomeArq)+' nao pode ser criado! Verifique os parametros.','Atencao!')
	Return
Endif

//���������������������������������������������������������������������Ŀ
//� Inicializa processamento (Windows)                                  �
//�����������������������������������������������������������������������
Processa({|lEnd| RunCont()}, 'Processando...')

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �  RuncCont    � Autor �Trade              � Data � 15.03.11 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Fun��o para continua��o do processamento (na confirma��o)  ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � RunCont()                                                  ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � GeraSup                                                    ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function RunCont()
Local _conFil := " "
	If Select("CT1") == 0
		ChkFile("CT1",.F.)
	EndIf
	dbSelectArea("CT1")
	dbSetOrder(1)
	dbGoTop()
	
	If Select("CT2") == 0
		ChkFile("CT2",.F.)
	EndIf
	
	dbSelectArea("CT2")
	dbSetorder(1)
	Procregua(LastRec())
	dbGoTop()
	dbSeek( xFilial("CT2") + DTOS(mv_par03) )
	_conFil :="CT2->(!Eof()) .and. CT2->( CT2_FILIAL + DTOS(CT2_DATA) ) <= xFilial('CT2') + DTOS(mv_par04)"
	  

// Qtade registro Processamento
//------------------------------
_nQtdReg:=0

cLin :='Codigo de Cuenta'	
cLin +=";"+'Nombre'	
cLin +=";"+'Periodo'	
cLin +=";"+'Fecha de Transaccion'	
cLin +=";"+'Importe Base'	
cLin +=";"+'Cargos/Abonos'	
cLin +=";"+'N� de Diario'	
cLin +=";"+'"SEQUENCIA" Linea de Diario'	
cLin +=";"+'Tipo de Diario'
cLin +=";"+'Diario Origen' 
cLin +=";"+'Referencia de Transaccion(DATA+LOTE+SBLOTE+DOC+LINHA)'	
cLin +=";"+'Descripcion'	
cLin +=";"+'T0  INSTITUTO Codigo de Analisis(CENTRO CUSTO)'	
cLin +=";"+'Descripcion (CENTRO CUSTO)'	
cLin +=";"+'T1  CLAVES DE PROYECTOS Codigo de Analisis (ITEM CONTABIL)'	
cLin +=";"+'Descripcion (ITEM )'	
cLin +=";"+'T2  RFC Codigo de Analisis' 
cLin +=";"+'Descripcion' 
cLin += CRLF
fGravaReg()

 While  &_conFil
	 
	nLin0++
	//���������������������������������������������������������������������Ŀ
	//� Incrementa a regua                                                  �
	//�����������������������������������������������������������������������
	IncProc('Gerando o Arquivo...')
	
	If lAbortPrint .Or. lEnd
		If Aviso('ATENCAO','Deseja abandonar a Geracao do arquivo ' + AllTrim(AllTrim(cNomeArq)) + ' ?',{'Sim','N�o'}) == 1
			lContinua := .F.
			Exit
		EndIf
	Endif
	
	//���������������������������������������������������������������������Ŀ
	//� Gera Registro                                                       �
	//�����������������������������������������������������������������������
	If CT2->CT2_DC $ "4"
		CT2->(dbSkip())
		Loop
	Endif
	
	If CT2->CT2_MOEDLC <> "01"
	    CT2->(dbSkip())
		Loop
	EndIf
     
    _nQtdReg++
    
	If CT2->CT2_DC $ "13"
		fGeraReg("D")
	EndIf

	If CT2->CT2_DC $ "23"
		fGeraReg("C")
	EndIf

	CT2->(DbSkip())
    
EndDo

dbSelectArea("CT2")
dbGoTop()

ChkFile("SRA",.F.)

Return

// Fim da Rotina
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � fGeraReg     � Autor � Atilio Amarilla   � Data � 25.11.05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Gera linha com Registro do Lancamento COntabil             ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � RDMAKE                                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � GeraCT2                                                    ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fGeraReg( _cDC )
Local _AchouCTT:=.f. , _AchouCT1:=.F.
Local _AchouCTD:=.f.
Local _ContHist:=""
Local _ChaveHis:= DTOS(CT2->CT2_DATA)+CT2->(CT2_LOTE+CT2_SBLOTE+CT2_DOC)

_Crecno_Ct2:=CT2->(Recno())
_ContHist:= CT2->CT2_HIST
CT2->(Dbskip())    
// pesquisa os complementos dos historicos.
While  _ChaveHis ==  DTOS(CT2->CT2_DATA)+CT2->(CT2_LOTE+CT2_SBLOTE+CT2_DOC) .and. CT2->CT2_DC =='4' .and. CT2->(!Eof())

    _ContHist+= CT2->CT2_HIST
    CT2->(DbSkip())
    _ChaveHis:= DTOS(CT2->CT2_DATA)+CT2->(CT2_LOTE+CT2_SBLOTE+CT2_DOC)
    
Enddo

CT2->(Dbgoto( _Crecno_Ct2 ) )

CT1->(DbSetOrder(01))
_AchouCT1:=CT1->(DbSeek(xfilial("CT1") +IIF( _cDC == "D" , CT2->CT2_DEBITO , CT2->CT2_CREDIT )   ))

CTD->(DbSetOrder(01))
_AchouCTD:=CTD->(DbSeek(xfilial("CTD") +IIF( _cDC == "D" , CT2->CT2_ITEMD , CT2->CT2_ITEMC )  ))

CTT->(DbSetOrder(01))
_AchouCTT:=CTT->(DbSeek(xfilial("CTT") +IIF( _cDC == "D" , CT2->CT2_CCD , CT2->CT2_CCC )  ))

cLin := IIF( _cDC == "D" , CT2->CT2_DEBITO , CT2->CT2_CREDIT )                      //C�digo de Cuenta	
cLin += ";"+IIF( _AchouCT1  , CT1->CT1_DESC01  , " " )                             // Nombre	
cLin += ";"+Substr(DTOS( CT2->CT2_DATA), 1,6)                                        //Per�odo	
cLin += ";"+DTOS( CT2->CT2_DATA )                                                   // Fecha de Transacci�n	
cLin += ";"+LEFT(STRZERO(CT2->CT2_VALOR*IIF(_cDC='D',1,-1) ,20,2 ),17)+','+RIGHT(STRZERO(CT2->CT2_VALOR*IIF(_cDC='D',1,-1) ,20,2 ),2)                       //CT2->CT2_VALOR Importe Base	
cLin += ";"+_cDC                                                                    //CT2_DC Cargos/Abonos	
cLin += ";"+mv_par01                                                                //N� de Diario	
cLin += ";"+StrZero(_nQtdReg,12)                                                    //'SEQUENCIA" L�nea de Diario	
cLin += ";"+mv_par02                                                                //"GRAL"       //Tipo de Diario
cLin += ";"+CT2->CT2_ROTINA                                                         //Diario Origen (CT2_ORIGEM)	
cLin += ";"+DTOS(CT2->CT2_DATA)+CT2->(CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA)        //Referencia de Transacci�n(DATA+LOTE+SBLOTE+DOC+LINHA)	
cLin += ";"+Iif( empty(_ContHist) ,CT2->CT2_HIST ,_ContHist)                        //CT2->CT2_LOTE                                                           //Descripci�n	
cLin += ";"+IIF( _cDC == "D" , CT2->CT2_CCD , CT2->CT2_CCC )                  //T0  INSTITUTO C�digo de An�lisis(CENTRO CUSTO)	
cLin += ";"+Iif( _AchouCTT , CTT->CTT_DESC01, " " )                                 //Descripci�n (CENTRO CUSTO)	
cLin += ";"+IIF( _cDC == "D" , CT2->CT2_ITEMD , CT2->CT2_ITEMC )                    //T1  CLAVES DE PROYECTOS C�digo de An�lisis (ITEM CONTABIL)	
cLin += ";"+Iif( _AchouCTD ,CTD->CTD_DESC01," " )                                   //     Descripci�n (ITEM )	
cLin += ";"+" "                                                                     //T2  RFC C�digo de An�lisis (N�O TEM)	
cLin += ";"+"  "                                                                    //Descripci�n (N�O TEM)
cLin += CRLF
fGravaReg()

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � fGravaReg    � Autor �Jose Carlos Gouveia� Data � 06.11.00 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Grava Registros do Gerakit                                 ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � fGravaReg()                                                ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � GeraKit                                                    ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function fGravaReg()

If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
	If !MsgYesNo('Ocorreu um erro na gravacao do arquivo '+AllTrim(cNomeArq)+'.   Continua?','Atencao!')
		lContinua := .F.
		Return
	Endif
Endif

nSeq := nSeq + 1

Return

// Fim da Rotina
Static Function VALIDPERG()


ssAlias  := Alias()
cPerg := PADR(cPerg,10)  
aRegs    := {}

dbSelectArea("SX1")
dbSetOrder(1)


aAdd(aRegs,{cPerg,"01","Nro.Diario ?"        ,"Nro.Diario ?"        ,"Nro.Diario ?"        ,"mv_ch1","C",05,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"02","Tipo de Diario?"     ,"Tipo de Diario?"     ,"Tipo de Diario?"     ,"mv_ch2","C",10,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"03","Data Inicial       ?","Data Inicial       ?","Data Inicial       ?","mv_ch3","D",08,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""})   
aAdd(aRegs,{cPerg,"04","Data Final         ?","Data Final         ?","Data Final         ?","mv_ch4","D",08,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""})
aAdd(aRegs,{cPerg,"05","Nome do Arquivo    ?","Nome do Arquivo    ?","Nome do Arquivo    ?","mv_ch5","C",30,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})



For i := 1 to Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j := 1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

DbSelectArea(ssAlias)

Return



  /*


CT2_CONTA C�digo de Cuenta	
CT1_DESCR01 Nombre	
SUBSTR(CT2_DATA,1,6)  Per�odo	
CT2_DATA Fecha de Transacci�n	
CT2_VALOR Importe Base	
CT2_DC Cargos/Abonos	
"MV_PARXX"  N� de Diario	
'SEQUENCIA" L�nea de Diario	
"GRAL" Tipo de Diario	
CT2_ORIGEM Diario Origen (CT2_ORIGEM)	
CT2_DATA+CT2_LOTE+CT2_SBLOTE+CT2_DOC+CT2_LINHA  Referencia de Transacci�n(DATA+LOTE+SBLOTE+DOC+LINHA)	
CT2_LOTE Descripci�n	
CT2_DEBITO/CT2_CREDIT                           T0  INSTITUTO C�digo de An�lisis(CENTRO CUSTO)	
CTT_DESC01                                      Descripci�n (CENTRO CUSTO)	
CT2_ITEMD/CT2_ITEMC                             T1  CLAVES DE PROYECTOS C�digo de An�lisis (ITEM CONTABIL)	
CTD_DESC01                                      Descripci�n (ITEM )	
T2  RFC C�digo de An�lisis (N�O TEM)	
Descripci�n (N�O TEM)

*/





#include "rwmake.ch"
#include "protheus.ch"

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Programa ³ SF1100I ³ Autor ³ EDINILSON - TRADE ³ Data ³26/03/08  ³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao³ PE para digitacao de informacoes compl. para nf       ³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Uso      ³ Especifico clientes Microsiga - CESVI                 ³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Data     ³ Alteracao                                             ³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³31/08/14 ³#JN20140831 - Revisao de Fonte - Migracao P11          ³±
±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
User function SF1100I()

//---------------------------------------------------------------
// SALVA AMBIENTE ORIGINAL
//---------------------------------------------------------------
Local aArea	:= GetArea()	//#JN20140831.n

Private _CMARCA		:= Space(25)
Private _CNUMDI		:= Space(25)
Private _CNUMERO	:= Space(25)
Private _COBS		:= Space(25)
Private _CQTDEVOL	:= Space(25)
Private _CTIPOFRE	:= Space(25)
Private _CTIPVOL	:= Space(25)
Private _CTRANSP	:= Space(25)
Private _NPESOBRU	:= Space(25)
Private _NPESOLIQ	:= Space(25)
Private _NTAXA		:= Space(25)
Private cagencia1	:= Space(25)
Private cbanco1		:= Space(25)
Private cconta1		:= Space(25)
Private o_CMARCA
Private o_CNUMDI
Private o_CNUMERO
Private o_COBS
Private o_CQTDEVOL
Private o_CTIPOFRE
Private o_CTIPVOL
Private o_CTRANSP
Private o_NPESOBRU
Private o_NPESOLIQ
Private o_NTAXA
Private ocagencia1
Private ocbanco1
Private occonta1
Private oDlg1

Private VISUAL	:= .F.
Private INCLUI	:= .F.
Private ALTERA	:= .F.
Private DELETA	:= .F.

//_cAlias   := Alias()	//#JN20140831.o
//_nIndex   := IndexOrd()	//#JN20140831.o
//_nReg     := Recno()	//#JN20140831.o
CBanco1   := SA2->A2_BANCO   //space(3)
CAgencia1 := SA2->A2_AGENCIA //space(5)
CConta1   := SA2->A2_NUMCON  //space(3)

If SF1->F1_EST == "EX
	DEFINE MSDIALOG oDlg1 TITLE "Informaçoes Complementares/Dados Bancarios Fornecedor" FROM C(195),C(226) TO C(682),C(755) PIXEL
	
	// Cria as Groups do Sistema
	@ C(000),C(000) TO C(146),C(269) LABEL "Dados Complementares para Nota de Importação" PIXEL OF oDlg1
	@ C(148),C(000) TO C(208),C(269) LABEL "Informação Bancaria" PIXEL OF oDlg1
	
	// Cria Componentes Padroes do Sistema
	@ C(008),C(006) Say "Numero DI" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(008),C(080) MsGet o_CNUMDI Var _CNUMDI Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(019),C(006) Say "Nome Transportadora" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(019),C(080) MsGet o_CTRANSP Var _CTRANSP F3 "SA4" Size C(183),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(030),C(006) Say "Qtde Volume" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(030),C(080) MsGet o_CQTDEVOL Var _CQTDEVOL Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(042),C(080) MsGet o_CTIPVOL Var _CTIPVOL Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(043),C(007) Say "Especie Volume" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(055),C(006) Say "Marca" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(055),C(080) MsGet o_CMARCA Var _CMARCA Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(067),C(006) Say "Numero" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(067),C(080) MsGet o_CNUMERO Var _CNUMERO Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(079),C(080) MsGet o_NPESOBRU Var _NPESOBRU Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(080),C(006) Say "Peso Bruto" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(090),C(006) Say "Peso Liquido" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(090),C(080) MsGet o_NPESOLIQ Var _NPESOLIQ Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(101),C(005) Say "Taxa Siscomex" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(103),C(080) MsGet o_NTAXA Var _NTAXA Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(114),C(005) Say "Tipo Frete(C/F)" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(114),C(080) MsGet o_CTIPOFRE Var _CTIPOFRE Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(127),C(080) MsGet o_COBS Var c_COBS Size C(179),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(128),C(006) Say "Observaçoes" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(158),C(076) MsGet ocbanco1 Var cbanco1 Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(160),C(006) Say "Banco" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(174),C(075) MsGet ocagencia1 Var cagencia1 Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(175),C(006) Say "Agencia" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(191),C(006) Say "Conta" Size C(060),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(191),C(075) MsGet occonta1 Var cconta1 Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	DEFINE SBUTTON FROM C(221),C(033) TYPE 13 ENABLE OF oDlg1 ACTION( RGRAVAR() )
	
	ACTIVATE MSDIALOG oDlg1 CENTERED
	
Else
	
	DEFINE MSDIALOG oDlg1 TITLE "Informação Bancaria" FROM C(178),C(181) TO C(348),C(717) PIXEL
	
	// Cria as Groups do Sistema
	@ C(000),C(000) TO C(060),C(271) LABEL "Informação Bancaria" PIXEL OF oDlg1
	
	// Cria Componentes Padroes do Sistema
	@ C(008),C(050) MsGet ocbanco1 Var cbanco1 Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(009),C(006) Say "Banco" Size C(042),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(024),C(006) Say "Agencia" Size C(042),C(010) COLOR CLR_BLACK PIXEL OF oDlg1
	@ C(024),C(050) MsGet ocagencia1 Var cagencia1 Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(040),C(050) MsGet occonta1 Var cconta1 Size C(060),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlg1
	@ C(041),C(006) Say "Conta " Size C(042),C(008) COLOR CLR_BLACK PIXEL OF oDlg1
	DEFINE SBUTTON FROM C(067),C(052) TYPE 13 ENABLE OF oDlg1 ACTION( RGRAVAR() )
	
	// Cria ExecBlocks dos Componentes Padroes do Sistema
	
	ACTIVATE MSDIALOG oDlg1 CENTERED
	
Endif
            
//chamada da digitalização
If cempant <>'02'
  U_Fdigital()
Endif

//dbSelectArea(_cAlias)	//#JN20140831.o
//dbSetOrder(_nIndex)	//#JN20140831.o
//dbGoTo(_nReg)	//#JN20140831.o
RestArea(aArea)	//#JN20140831.n

Return(.T.)


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)

Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor
If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)
	nTam *= 0.8
ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600
	nTam *= 1
Else	// Resolucao 1024x768 e acima
	nTam *= 1.28
EndIf


/*	//#JN20140831.o
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento para tema "Flat"³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If "MP8" $ oApp:cVersion
	If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
		nTam *= 0.90
	EndIf
EndIf
*/

Return Int(nTam)


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao   ³ GRAVAR  ³ Autor ³ TRADE             ³ Data ³10/05/2011³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao³                                                       ³±
±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function RGRAVAR()

Close(oDlg1)

If SF1->F1_EST == 'EX'
	//DBSelectArea("SF1")	//#JN20140831.o
	RecLock("SF1",.F.)	//#JN20140831.n
	SF1->F1_X_DI       := _cNumdi
	SF1->F1_X_TRANS    := _cTransp
	SF1->F1_X_QTVOL    := _cQtdeVol
	SF1->F1_X_TPVOL    := _cTipVol
	SF1->F1_X_MARCA    := _cMarca
	SF1->F1_X_NUMVO    := _cNumero
	SF1->F1_X_PBRUTO   := _nPesoBru
	SF1->F1_X_PLIQ     := _nPesoLiq
	SF1->F1_X_OBS      := _cObs
	SF1->F1_X_TPFRE    := _cTipoFre
	SF1->F1_X_SISCO    := _nTaxa
	//MsUnlock()	//#JN20140831.o
	SF1->(MsUnlock())	//#JN20140831.n
Endif

cQuery := "UPDATE "+retsqlname("SE2")+" SET E2_BANCO ='"+CBanco1+"', E2_AGENCIA = '"+CAgencia1+"', E2_NUMCON ='"+CConta1 +"' "
cQuery += " WHERE E2_FILIAL = '"+XFILIAL("SE2")+"' AND E2_PREFIXO = '"+ SF1->F1_PREFIXO +"' AND E2_NUM = '"+SF1->F1_DUPL+"' "
cQuery += " AND E2_FORNECE = '"+SF1->F1_FORNECE+"' AND E2_LOJA = '"+SF1->F1_LOJA+"' AND D_E_L_E_T_ <> '*' "

TcSqlExec( cQuery )

Return Nil


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³Fdigital  ³ Autor ³ Hevaldo Goncalves     ³ Data ³10/05/2011³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Locacao   ³ Fabr.Tradicional ³Contato ³                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Analista Resp.³  Data  ³ Bops ³ Manutencao Efetuada                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³  /  /  ³      ³                                        ³±±
±±³              ³  /  /  ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function Fdigital()

Private ccodDi	:= Space(25)
Private occodDi
Private oDlg

Private VISUAL	:= .F.                        
Private INCLUI	:= .F.                        
Private ALTERA	:= .F.                        
Private DELETA	:= .F.                        

DEFINE MSDIALOG oDlg TITLE "Digitalização" FROM C(178),C(181) TO C(348),C(717) PIXEL

	// Cria as Groups do Sistema
	@ C(000),C(000) TO C(060),C(271) LABEL "Codigo da Digitalização" PIXEL OF oDlg

	// Cria Componentes Padroes do Sistema
	@ C(022),C(063) MsGet occodDi Var ccodDi Size C(167),C(009) COLOR CLR_BLUE Picture "@!" PIXEL OF oDlg
	@ C(023),C(005) Say "Codigo Digital" Size C(042),C(008) COLOR CLR_BLACK PIXEL OF oDlg
	DEFINE SBUTTON FROM C(067),C(052) TYPE 13 ENABLE OF oDlg ACTION( RGRVDIG() )

ACTIVATE MSDIALOG oDlg CENTERED 

Return(.T.)


/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao   ³ RGRVDIG ³ Autor ³ TRADE             ³ Data ³10/05/2011³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao³                                                       ³±
±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function RGRVDIG()

Close(oDlg)

cQuery := "UPDATE "+retsqlname("SE2")+" SET E2_XDOCDI='"+ccodDi +"'"
cQuery += " WHERE E2_FILIAL = '"+XFILIAL("SE2")+"' AND E2_PREFIXO = '"+ SF1->F1_PREFIXO +"' AND E2_NUM = '"+SF1->F1_DOC+"' "
cQuery += " AND E2_FORNECE = '"+SF1->F1_FORNECE+"' AND E2_LOJA = '"+SF1->F1_LOJA+"' AND D_E_L_E_T_ <> '*' "
TcSqlExec( cQuery )

cQuery := "UPDATE "+retsqlname("SF1")+" SET F1_XDOCDI='"+ccodDi+"'"
cQuery += " WHERE F1_FILIAL = '"+SF1->F1_FILIAL+"' AND F1_SERIE = '"+ SF1->F1_PREFIXO +"' AND F1_DOC = '"+SF1->F1_DUPL+"' "
cQuery += " AND F1_FORNECE = '"+SF1->F1_FORNECE+"' AND F1_LOJA = '"+SF1->F1_LOJA+"' AND F1_ESPECIE = '"+SF1->F1_ESPECIE+"' AND D_E_L_E_T_ <> '*' "
TcSqlExec( cQuery )

cQuery := "UPDATE "+retsqlname("SD1")+" SET D1_XDOCDI='"+ccodDi+"'"
cQuery += " WHERE D1_FILIAL = '"+SF1->F1_FILIAL+"' AND D1_SERIE = '"+ SF1->F1_SERIE +"' AND D1_DOC = '"+SF1->F1_DUPL+"' "
cQuery += " AND D1_FORNECE = '"+SF1->F1_FORNECE+"' AND D1_LOJA = '"+SF1->F1_LOJA+"' AND D_E_L_E_T_ <> '*' "
TcSqlExec( cQuery )

Return Nil
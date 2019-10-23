#include "rwmake.ch"
#INCLUDE "TOPCONN.CH"
#include "rwmake.ch" 
#Include 'Protheus.Ch'                                                                            
#Include 'ApWizard.Ch'


User function SF1100I()

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Pto Entr ³ SF1100I ³ Autor ³ EDINILSON - TRADE ³ Data ³26/03/08  ³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao³ Digitacao de informacoes compl. para nf de import.    ³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³Uso      ³ Especifico clientes Microsiga - CESVI                 ³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±
±³  Data   ³ Alteracoes feitas por :                               ³±
±³         ³                                                       ³±
±³         ³                                                       ³±
±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

//---------------------------------------------------------------
// Se nao for NF DE ENTRADA COM FORMULARIO PROPRIO, IRA SAIR
//---------------------------------------------------------------
//If SF1->F1_EST <> 'EX'
//	Return Nil
//EndIf

//---------------------------------------------------------------
// SALVA AMBIENTE ORIGINAL
//---------------------------------------------------------------
_cAlias   := Alias()
_nIndex   := IndexOrd()
_nReg     := Recno()
/*
oDLG01    := ""
*/


If SF1->F1_EST == 'EX'
  U_IoDlgFNf()
Else
  U_IoDlgFBco()
Endif
//---------------------------------------------------------------
// Monta tela para digitacao dos valores de Imposto de Importacao
//---------------------------------------------------------------
/*
@ 96,42 TO 500,505 DIALOG oDlg1 TITLE "Dados Complementares para Nota de Importação"
@ 8,10 TO 190,222

_cNumDi   := space(20)
_cTransp  := space(06)
_cQtdevol := 0
_cTipvol  := space(25)
_cMarca   := space(15)
_cNumero  := space(15)
_nPesoBru := 0
_nPesoLiq := 0
_cTipoFre := SPACE(1)
_cObs     := space(30)
_nTaxa    := 0
 
@ 015,020 Say 'Numero DI:'  
@ 015,070 GET _cNumDi          Picture '@!' SIZE 100,30
@ 030,020 Say 'Nome da Transportadora:'    
@ 030,070 GET _cTransp      Picture '@!' VALID .t. F3 "SA4"
@ 045,020 Say 'Qtde Volumes: ' 
@ 045,070 get _cQtdeVol picture '@E 9,999,999.9999' 
@ 060,020 say 'Espécie Volume: ' 
@ 060,070 get _cTipVol  picture '@!' SIZE 100,30
@ 075,020 say 'Marca: ' 
@ 075,070 get _cMarca  picture '@!' SIZE 100,30
@ 090,020 say 'Número: ' 
@ 090,070 get _cNumero picture '@!' SIZE 100,30
@ 105,020 say 'Peso Bruto: ' 
@ 105,070 get _nPesoBru  picture '@ze 9,999,999.9999'
@ 115,020 say 'Peso Líquido: ' 
@ 115,070 get _nPesoLiq  picture '@ze 9,999,999.9999'
@ 130,020 say 'Taxa Siscomex:' 
@ 130,070 get _nTaxa     picture '@ze 9,999,999.9999'
@ 145,020 say 'Tipo Frete(C/F):' 
@ 145,070 get _cTipoFre  picture '@!' 
@ 160,020 say 'Observações:' 
@ 160,070 get _cObs  picture '@!' size 100,40
@ 185,190 BMPBUTTON TYPE 1 ACTION RGRAVAR()   
ACTIVATE DIALOG oDlg1 CENTERED

Return Nil
 */
dbSelectArea(_cAlias)
dbSetOrder(_nIndex)
dbGoTo(_nReg)
Return()

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao   ³ GRAVAR  ³ Autor ³ TRADE             ³ Data ³26/03/2008³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao³                                                       ³±
±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function RGRAVAR()
Close(oDlg1)

DBSelectArea("SF1")
RecLock("SF1",.F.)
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
MsUnlock()                   


cQuery := "UPDATE "+retsqlname("SE2")+" SET E2_BANCO ='"+CBanco+"', E2_AGENCIA = '"+CAgencia+"', E2_NUMCON ='"+CConta +"' "
cQuery += " WHERE E2_FILIAL = '"+XFILIAL("SE2")+"' AND E2_PREFIXO = '"+ SF1->F1_PREFIXO +"' AND E2_NUM = '"+SF1->F1_DUPL+"' "
cQuery += " AND E2_FORNECE = '"+SF1->F1_FORNECE+"' AND E2_LOJA = '"+SF1->F1_LOJA+"' AND E2_TIPO = '"+SF1->F1_ESPECIE+"' AND D_E_L_E_T_ <> '*' "

TcSqlExec( cQuery )



Return Nil






User Function IoDlgFNf()

Private oFont       := TFont():New("Courier New",,-12,.T.)
Private oFont1      := TFont():New("Arial"      ,,-12,.T.)
Private oFont2      := TFont():New("Arial"      ,,-14,.T.)
Private oDlgFNf,oGrp1,oSay2,oSay3,oSay4,oSay5,oSay6,oSay7,oSay8,oSay9,oSay10,oSay11,oSay12,ocnumDI,octransp,ocqtdevol,octipvol,ocmarca,ocnumero,onpesobru,onpesoliq,ontaxa,octipofre,ocobs,oGrp25,oSBtn26,Banco,oSay28,oSay29,CBanco,CAgencia,CConta
oDlgFNf := MSDIALOG():Create()
oDlgFNf:cName := "oDlgFNf"
oDlgFNf:cCaption := "Informações Complementares"
oDlgFNf:nLeft := 0
oDlgFNf:nTop := 0
oDlgFNf:nWidth := 697
oDlgFNf:nHeight := 571
oDlgFNf:lShowHint := .F.
oDlgFNf:lCentered := .T.

_cNumDi   := space(20)
_cTransp  := space(06)
_cQtdevol := 0
_cTipvol  := space(25)
_cMarca   := space(15)
_cNumero  := space(15)
_nPesoBru := 0
_nPesoLiq := 0
_cTipoFre := SPACE(1)
_cObs     := space(30)
_nTaxa    := 0

CBanco  := SA2->A2_BANCO   //space(3)
CAgencia:= SA2->A2_AGENCIA //space(5)
CConta  := SA2->A2_NUMCON  //space(3)

oGrp1 := TGROUP():Create(oDlgFNf)
oGrp1:cName := "oGrp1"
oGrp1:cCaption := "Dados da Importação"
oGrp1:nLeft := 5
oGrp1:nTop := 0
oGrp1:nWidth := 678
oGrp1:nHeight := 317
oGrp1:lShowHint := .F.
oGrp1:lReadOnly := .F.
oGrp1:Align := 0
oGrp1:lVisibleControl := .T.

oSay2 := TSAY():Create(oDlgFNf)
oSay2:cName := "oSay2"
oSay2:cCaption := "Numero DI:"
oSay2:nLeft := 11
oSay2:nTop := 17
oSay2:nWidth := 119
oSay2:nHeight := 17
oSay2:lShowHint := .F.
oSay2:lReadOnly := .F.
oSay2:Align := 0
oSay2:lVisibleControl := .T.
oSay2:lWordWrap := .F.
oSay2:lTransparent := .F.

oSay3 := TSAY():Create(oDlgFNf)
oSay3:cName := "oSay3"
oSay3:cCaption := "Nome Transportadora:"
oSay3:nLeft := 11
oSay3:nTop := 43
oSay3:nWidth := 119
oSay3:nHeight := 17
oSay3:lShowHint := .F.
oSay3:lReadOnly := .F.
oSay3:Align := 0
oSay3:lVisibleControl := .T.
oSay3:lWordWrap := .F.
oSay3:lTransparent := .F.

oSay4 := TSAY():Create(oDlgFNf)
oSay4:cName := "oSay4"
oSay4:cCaption := "Qtde Volumes"
oSay4:nLeft := 11
oSay4:nTop := 70
oSay4:nWidth := 119
oSay4:nHeight := 17
oSay4:lShowHint := .F.
oSay4:lReadOnly := .F.
oSay4:Align := 0
oSay4:lVisibleControl := .T.
oSay4:lWordWrap := .F.
oSay4:lTransparent := .F.

oSay5 := TSAY():Create(oDlgFNf)
oSay5:cName := "oSay5"
oSay5:cCaption := "Espécie Volume"
oSay5:nLeft := 11
oSay5:nTop := 98
oSay5:nWidth := 119
oSay5:nHeight := 17
oSay5:lShowHint := .F.
oSay5:lReadOnly := .F.
oSay5:Align := 0
oSay5:lVisibleControl := .T.
oSay5:lWordWrap := .F.
oSay5:lTransparent := .F.

oSay6 := TSAY():Create(oDlgFNf)
oSay6:cName := "oSay6"
oSay6:cCaption := "Marca"
oSay6:nLeft := 11
oSay6:nTop := 125
oSay6:nWidth := 119
oSay6:nHeight := 17
oSay6:lShowHint := .F.
oSay6:lReadOnly := .F.
oSay6:Align := 0
oSay6:lVisibleControl := .T.
oSay6:lWordWrap := .F.
oSay6:lTransparent := .F.

oSay7 := TSAY():Create(oDlgFNf)
oSay7:cName := "oSay7"
oSay7:cCaption := "Número"
oSay7:nLeft := 11
oSay7:nTop := 148
oSay7:nWidth := 119
oSay7:nHeight := 17
oSay7:lShowHint := .F.
oSay7:lReadOnly := .F.
oSay7:Align := 0
oSay7:lVisibleControl := .T.
oSay7:lWordWrap := .F.
oSay7:lTransparent := .F.

oSay8 := TSAY():Create(oDlgFNf)
oSay8:cName := "oSay8"
oSay8:cCaption := "Peso Bruto:"
oSay8:nLeft := 11
oSay8:nTop := 171
oSay8:nWidth := 119
oSay8:nHeight := 17
oSay8:lShowHint := .F.
oSay8:lReadOnly := .F.
oSay8:Align := 0
oSay8:lVisibleControl := .T.
oSay8:lWordWrap := .F.
oSay8:lTransparent := .F.

oSay9 := TSAY():Create(oDlgFNf)
oSay9:cName := "oSay9"
oSay9:cCaption := "Peso Liquido:"
oSay9:nLeft := 11
oSay9:nTop := 198
oSay9:nWidth := 119
oSay9:nHeight := 17
oSay9:lShowHint := .F.
oSay9:lReadOnly := .F.
oSay9:Align := 0
oSay9:lVisibleControl := .T.
oSay9:lWordWrap := .F.
oSay9:lTransparent := .F.

oSay10 := TSAY():Create(oDlgFNf)
oSay10:cName := "oSay10"
oSay10:cCaption := "Taxa Siscomex:"
oSay10:nLeft := 11
oSay10:nTop := 222
oSay10:nWidth := 119
oSay10:nHeight := 17
oSay10:lShowHint := .F.
oSay10:lReadOnly := .F.
oSay10:Align := 0
oSay10:lVisibleControl := .T.
oSay10:lWordWrap := .F.
oSay10:lTransparent := .F.

oSay11 := TSAY():Create(oDlgFNf)
oSay11:cName := "oSay11"
oSay11:cCaption := "Tipo Frete(C/F) :"
oSay11:nLeft := 11
oSay11:nTop := 243
oSay11:nWidth := 119
oSay11:nHeight := 17
oSay11:lShowHint := .F.
oSay11:lReadOnly := .F.
oSay11:Align := 0
oSay11:lVisibleControl := .T.
oSay11:lWordWrap := .F.
oSay11:lTransparent := .F.

oSay12 := TSAY():Create(oDlgFNf)
oSay12:cName := "oSay12"
oSay12:cCaption := "Observações:"
oSay12:nLeft := 11
oSay12:nTop := 270
oSay12:nWidth := 119
oSay12:nHeight := 19
oSay12:lShowHint := .F.
oSay12:lReadOnly := .F.
oSay12:Align := 0
oSay12:lVisibleControl := .T.
oSay12:lWordWrap := .F.
oSay12:lTransparent := .F.

ocnumDI := TGET():Create(oDlgFNf)
ocnumDI:cName := "ocnumDI"
ocnumDI:cCaption := "_cnumDI"
ocnumDI:nLeft := 140
ocnumDI:nTop := 17
ocnumDI:nWidth := 159
ocnumDI:nHeight := 21
ocnumDI:lShowHint := .F.
ocnumDI:lReadOnly := .F.
ocnumDI:Align := 0
ocnumDI:lVisibleControl := .T.
ocnumDI:lPassword := .F.
ocnumDI:lHasButton := .F.
ocnumDI:bWhen := {|| SF1->F1_EST =="EX" }
ocnumDI:bValid := {|| !EMPTY(OCNUMID) }

octransp := TGET():Create(oDlgFNf)
octransp:cName := "octransp"
octransp:cCaption := "ctransp"
octransp:cF3 := "SA4"
octransp:nLeft := 140
octransp:nTop := 43
octransp:nWidth := 511
octransp:nHeight := 21
octransp:lShowHint := .F.
octransp:lReadOnly := .F.
octransp:Align := 0
octransp:lVisibleControl := .T.
octransp:lPassword := .F.
octransp:lHasButton := .F.
octransp:bWhen := {|| SF1->F1_EST =="EX" }
octransp:bValid := {|| !EMPTY(octransp) }


ocqtdevol := TGET():Create(oDlgFNf)
ocqtdevol:cName := "ocqtdevol"
ocqtdevol:cCaption := "cqtdevol"
ocqtdevol:nLeft := 140
ocqtdevol:nTop := 70
ocqtdevol:nWidth := 163
ocqtdevol:nHeight := 21
ocqtdevol:lShowHint := .F.
ocqtdevol:lReadOnly := .F.
ocqtdevol:Align := 0
ocqtdevol:lVisibleControl := .T.
ocqtdevol:lPassword := .F.
ocqtdevol:lHasButton := .F.
ocqtdevol:bWhen := {|| SF1->F1_EST =="EX" }
ocqtdevol:bValid := {|| !EMPTY(ocqtdevol) }


octipvol := TGET():Create(oDlgFNf)
octipvol:cName := "octipvol"
octipvol:cCaption := "ctipvol"
octipvol:nLeft := 140
octipvol:nTop := 98
octipvol:nWidth := 163
octipvol:nHeight := 21
octipvol:lShowHint := .F.
octipvol:lReadOnly := .F.
octipvol:Align := 0
octipvol:lVisibleControl := .T.
octipvol:lPassword := .F.
octipvol:lHasButton := .F.
octipvol:bWhen := {|| SF1->F1_EST =="EX" }
octipvol:bValid := {|| !EMPTY(octipvol) }


ocmarca := TGET():Create(oDlgFNf)
ocmarca:cName := "ocmarca"
ocmarca:cCaption := "cmarca"
ocmarca:nLeft := 140
ocmarca:nTop := 125
ocmarca:nWidth := 163
ocmarca:nHeight := 21
ocmarca:lShowHint := .F.
ocmarca:lReadOnly := .F.
ocmarca:Align := 0
ocmarca:lVisibleControl := .T.
ocmarca:lPassword := .F.
ocmarca:lHasButton := .F.
ocmarca:bWhen := {|| SF1->F1_EST =="EX" }
ocmarca:bValid := {|| !EMPTY(ocmarca) }


ocnumero := TGET():Create(oDlgFNf)
ocnumero:cName := "ocnumero"
ocnumero:cCaption := "cnumero"
ocnumero:nLeft := 140
ocnumero:nTop := 148
ocnumero:nWidth := 163
ocnumero:nHeight := 21
ocnumero:lShowHint := .F.
ocnumero:lReadOnly := .F.
ocnumero:Align := 0
ocnumero:lVisibleControl := .T.
ocnumero:lPassword := .F.
ocnumero:lHasButton := .F.
ocnumero:bWhen := {|| SF1->F1_EST =="EX" }
ocnumero:bValid := {|| !EMPTY(ocnumero) }


onpesobru := TGET():Create(oDlgFNf)
onpesobru:cName := "onpesobru"
onpesobru:cCaption := "npesobru"
onpesobru:nLeft := 140
onpesobru:nTop := 171
onpesobru:nWidth := 163
onpesobru:nHeight := 21
onpesobru:lShowHint := .F.
onpesobru:lReadOnly := .F.
onpesobru:Align := 0
onpesobru:lVisibleControl := .T.
onpesobru:lPassword := .F.
onpesobru:lHasButton := .F.
onpesobru:bWhen := {|| SF1->F1_EST =="EX" }
onpesobru:bValid := {|| !EMPTY(onpesobru) }


onpesoliq := TGET():Create(oDlgFNf)
onpesoliq:cName := "onpesoliq"
onpesoliq:cCaption := "npesoliq"
onpesoliq:nLeft := 140
onpesoliq:nTop := 198
onpesoliq:nWidth := 163
onpesoliq:nHeight := 21
onpesoliq:lShowHint := .F.
onpesoliq:lReadOnly := .F.
onpesoliq:Align := 0
onpesoliq:lVisibleControl := .T.
onpesoliq:lPassword := .F.
onpesoliq:lHasButton := .F.
onpesoliq:bWhen := {|| SF1->F1_EST =="EX" }
onpesoliq:bValid := {|| !EMPTY(onpesoliq) }


ontaxa := TGET():Create(oDlgFNf)
ontaxa:cName := "ontaxa"
ontaxa:cCaption := "ntaxa"
ontaxa:nLeft := 140
ontaxa:nTop := 222
ontaxa:nWidth := 163
ontaxa:nHeight := 21
ontaxa:lShowHint := .F.
ontaxa:lReadOnly := .F.
ontaxa:Align := 0
ontaxa:lVisibleControl := .T.
ontaxa:lPassword := .F.
ontaxa:lHasButton := .F.
ontaxa:bWhen := {|| SF1->F1_EST =="EX" }
ontaxa:bValid := {|| !EMPTY(ontaxa) }


octipofre := TGET():Create(oDlgFNf)
octipofre:cName := "octipofre"
octipofre:cCaption := "ctipofre"
octipofre:nLeft := 140
octipofre:nTop := 243
octipofre:nWidth := 163
octipofre:nHeight := 21
octipofre:lShowHint := .F.
octipofre:lReadOnly := .F.
octipofre:Align := 0
octipofre:lVisibleControl := .T.
octipofre:lPassword := .F.
octipofre:lHasButton := .F.
octipofre:bWhen := {|| SF1->F1_EST =="EX" }
octipofre:bValid := {|| !EMPTY(octipofre) }


ocobs := TGET():Create(oDlgFNf)
ocobs:cName := "ocobs"
ocobs:cCaption := "cobs"
ocobs:nLeft := 140
ocobs:nTop := 270
ocobs:nWidth := 506
ocobs:nHeight := 21
ocobs:lShowHint := .F.
ocobs:lReadOnly := .F.
ocobs:Align := 0
ocobs:lVisibleControl := .T.
ocobs:lPassword := .F.
ocobs:lHasButton := .F.
ocobs:bWhen := {|| SF1->F1_EST =="EX" }
ocobs:bValid := {|| !EMPTY(ocobs) }


oGrp25 := TGROUP():Create(oDlgFNf)
oGrp25:cName    := "oGrp25"
oGrp25:cCaption := "Dados Bancarios Fornecedor"
oGrp25:nLeft    := 6
oGrp25:nTop     := 321
oGrp25:nWidth   := 678
oGrp25:nHeight  := 138
oGrp25:lShowHint:= .F.
oGrp25:lReadOnly:= .F.
oGrp25:Align    := 0
oGrp25:lVisibleControl := .T.

oSBtn26 := SBUTTON():Create(oDlgFNf)
oSBtn26:cName    := "oSBtn26"
oSBtn26:cCaption := "Confirma"
oSBtn26:nLeft    := 313
oSBtn26:nTop     := 490
oSBtn26:nWidth   := 52
oSBtn26:nHeight  := 22
oSBtn26:lShowHint:= .F.
oSBtn26:lReadOnly:= .F.
oSBtn26:Align    := 0
oSBtn26:lVisibleControl := .T.
oSBtn26:nType := 1
oSBtn26:bAction := {|| RGRAVAR(oDlgFNf) }

Banco := TSAY():Create(oDlgFNf)
Banco:cName := "Banco"
Banco:cCaption := "Banco"
Banco:nLeft := 16
Banco:nTop := 350
Banco:nWidth := 119
Banco:nHeight := 17
Banco:lShowHint := .F.
Banco:lReadOnly := .F.
Banco:Align := 0
Banco:lVisibleControl := .T.
Banco:lWordWrap := .F.
Banco:lTransparent := .F.

oSay28 := TSAY():Create(oDlgFNf)
oSay28:cName := "oSay28"
oSay28:cCaption := "Agencia"
oSay28:nLeft := 20
oSay28:nTop := 384
oSay28:nWidth := 119
oSay28:nHeight := 17
oSay28:lShowHint := .F.
oSay28:lReadOnly := .F.
oSay28:Align := 0
oSay28:lVisibleControl := .T.
oSay28:lWordWrap := .F.
oSay28:lTransparent := .F.

oSay29 := TSAY():Create(oDlgFNf)
oSay29:cName := "oSay29"
oSay29:cCaption := "Nro Conta"
oSay29:nLeft := 21
oSay29:nTop := 417
oSay29:nWidth := 119
oSay29:nHeight := 17
oSay29:lShowHint := .F.
oSay29:lReadOnly := .F.
oSay29:Align := 0
oSay29:lVisibleControl := .T.
oSay29:lWordWrap := .F.
oSay29:lTransparent := .F.

CBanco := TGET():Create(oDlgFNf)
CBanco:cName := "CBanco"
CBanco:cCaption := "oGet30"
CBanco:nLeft := 144
CBanco:nTop := 346
CBanco:nWidth := 163
CBanco:nHeight := 21
CBanco:lShowHint := .F.
CBanco:lReadOnly := .F.
CBanco:Align := 0
CBanco:lVisibleControl := .T.
CBanco:lPassword := .F.
CBanco:lHasButton := .F.

CAgencia := TGET():Create(oDlgFNf)
CAgencia:cName    := "CAgencia"
CAgencia:cCaption := "oGet31"
CAgencia:nLeft    := 145
CAgencia:nTop     := 381
CAgencia:nWidth   := 163
CAgencia:nHeight  := 21
CAgencia:lShowHint := .F.
CAgencia:lReadOnly := .F.
CAgencia:Align := 0
CAgencia:lVisibleControl := .T.
CAgencia:lPassword := .F.
CAgencia:lHasButton := .F.

CConta := TGET():Create(oDlgFNf)
CConta:cName := "CConta"
CConta:cCaption := "oGet32"
CConta:nLeft := 146
CConta:nTop := 415
CConta:nWidth := 163
CConta:nHeight := 21
CConta:lShowHint := .F.
CConta:lReadOnly := .F.
CConta:Align := 0
CConta:lVisibleControl := .T.
CConta:lPassword := .F.
CConta:lHasButton := .F.

oDlgFNf:Activate()

Return





User Function IoDlgFBco()
Private oFont       := TFont():New("Courier New",,-12,.T.)
Private oFont1      := TFont():New("Arial"      ,,-12,.T.)
Private oFont2      := TFont():New("Arial"      ,,-14,.T.)


Private oDlgFbco,oGrp25,oSBtn26,Banco,oSay28,oSay29,CBanco,CAgencia,CConta
Private CBanco1,CAgencia1,CConta1
CBanco1  := SA2->A2_BANCO   //space(3)
CAgencia1:= SA2->A2_AGENCIA //space(5)
CConta1  := SA2->A2_NUMCON  //space(3)

@ 0,0 TO 227,697 DIALOG oDlgFBco TITLE "Informações Complementares/Dados Bancarios Fornecedor"
@ 5,02 TO 138,678 Label   "Dados Bancarios Fornecedor" 

@ 14, 21 Say "Banco  " Size 160,10 FONT oFont1 COLOR CLR_BLUE Of oDlgFBco Pixel
@ 14, 150 MsGet cbanco1 Picture "@E 999" Valid !empty(cbanco1) Size 070,10 Of oDlgFBco Pixel
//
	@ 051, 14 Say "Agencia " Size 160,10 FONT oFont1 COLOR CLR_BLUE Of oDlgFBco Pixel
//	@ 065, 14 MsGet cagencia1 Valid !Empty(cagencia1) Size 040,10 Of oDlgFBco Pixel
//
	@ 090, 14 Say "Nro Conta " Size 160,10 FONT oFont1 COLOR CLR_BLUE Of oDlgFBco Pixel
//	@ 065, 14 MsGet cConta1 Picture "@!" Valid !empty(cConta1) Size 070,10 Of oDlgFBco Pixel 



/*
oDlgFBco := MSDIALOG():Create()
oDlgFBco:cName := "oDlgFNf"
oDlgFBco:cCaption := "Informações Complementares"
oDlgFBco:nLeft := 0
oDlgFBco:nTop := 0
oDlgFBco:nWidth := 697
oDlgFBco:nHeight := 227
oDlgFBco:lShowHint := .F.
oDlgFBco:lCentered := .T.

oGrp25 := TGROUP():Create(oDlgFBco)
oGrp25:cName := "oGrp25"
oGrp25:cCaption := "Dados Bancarios Fornecedor"
oGrp25:nLeft := 5
oGrp25:nTop := 2
oGrp25:nWidth := 678
oGrp25:nHeight := 138
oGrp25:lShowHint := .F.
oGrp25:lReadOnly := .F.
oGrp25:Align := 0
oGrp25:lVisibleControl := .T.



oSBtn26 := SBUTTON():Create(oDlgFBco)
oSBtn26:cName := "oSBtn26"
oSBtn26:cCaption := "Confirma"
oSBtn26:nLeft := 162
oSBtn26:nTop := 157
oSBtn26:nWidth := 52
oSBtn26:nHeight := 22
oSBtn26:lShowHint := .F.
oSBtn26:lReadOnly := .F.
oSBtn26:Align := 0
oSBtn26:lVisibleControl := .T.
oSBtn26:nType := 1
oSBtn26:bAction := {||GRVBCO(oDlgFBco) }

Banco := TSAY():Create(oDlgFBco)
Banco:cName := "Banco"
Banco:cCaption := "Banco"
Banco:nLeft := 14
Banco:nTop := 21
Banco:nWidth := 119
Banco:nHeight := 17
Banco:lShowHint := .F.
Banco:lReadOnly := .F.
Banco:Align := 0
Banco:lVisibleControl := .T.
Banco:lWordWrap := .F.
Banco:lTransparent := .F.

oSay28 := TSAY():Create(oDlgFBco)
oSay28:cName := "oSay28"
oSay28:cCaption := "Agencia"
oSay28:nLeft := 15
oSay28:nTop := 51
oSay28:nWidth := 119
oSay28:nHeight := 17
oSay28:lShowHint := .F.
oSay28:lReadOnly := .F.
oSay28:Align := 0
oSay28:lVisibleControl := .T.
oSay28:lWordWrap := .F.
oSay28:lTransparent := .F.

oSay29 := TSAY():Create(oDlgFBco)
oSay29:cName := "oSay29"
oSay29:cCaption := "Nro Conta"
oSay29:nLeft := 16
oSay29:nTop := 90
oSay29:nWidth := 119
oSay29:nHeight := 17
oSay29:lShowHint := .F.
oSay29:lReadOnly := .F.
oSay29:Align := 0
oSay29:lVisibleControl := .T.
oSay29:lWordWrap := .F.
oSay29:lTransparent := .F.

CBanco := TGET():Create(oDlgFBco)
CBanco:cName := "CBanco"
CBanco:cCaption := "oGet30"
CBanco:nLeft := 150
CBanco:nTop := 18
CBanco:nWidth := 163
CBanco:nHeight := 21
CBanco:lShowHint := .F.
CBanco:lReadOnly := .F.
CBanco:Align := 0          
CBanco:cVariable := "CBanco"
CBanco:bSetGet := {|u| If(PCount()>0,CBanco1:=u,CBanco1) }
CBanco:lVisibleControl := .T.
CBanco:lPassword := .F.
CBanco:lHasButton := .F.

CAgencia := TGET():Create(oDlgFBco)
CAgencia:cName := "CAgencia"
CAgencia:cCaption := "oGet31"
CAgencia:nLeft := 151
CAgencia:nTop := 49
CAgencia:nWidth := 163
CAgencia:nHeight := 21
CAgencia:lShowHint := .F.
CAgencia:lReadOnly := .F.
CAgencia:Align := 0
CBanco:cVariable := "CAgencia"
CBanco:bSetGet := {|u| If(PCount()>0,CAgencia1:=u,CAgencia1) }
CAgencia:lVisibleControl := .T.
CAgencia:lPassword := .F.
CAgencia:lHasButton := .F.

CConta := TGET():Create(oDlgFBco)
CConta:cName := "CConta"
CConta:cCaption := "oGet32"
CConta:nLeft := 151
CConta:nTop := 86
CConta:nWidth := 163
CConta:nHeight := 21
CConta:lShowHint := .F.
CConta:lReadOnly := .F.
CConta:Align := 0
CBanco:cVariable := "CConta"
CBanco:bSetGet := {|u| If(PCount()>0,CConta1:=u,CConta1) }
CConta:lVisibleControl := .T.
CConta:lPassword := .F.
CConta:lHasButton := .F.

oDlgFBco:Activate()
  
*/
Return




/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±
±³Funcao   ³ GRAVAR  ³ Autor ³ TRADE             ³ Data ³26/03/2008³±
±ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±
±³Descricao³                                                       ³±
±ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/
Static Function GRVBCO()
Close(oDlg1)

cQuery := "UPDATE "+retsqlname("SE2")+" SET E2_BANCO ='"+CBanco+"', E2_AGENCIA = '"+CAgencia+"', E2_NUMCON ='"+CConta +"' "
cQuery += " WHERE E2_FILIAL = '"+XFILIAL("SE2")+"' AND E2_PREFIXO = '"+ SF1->F1_PREFIXO +"' AND E2_NUM = '"+SF1->F1_DUPL+"' "
cQuery += " AND E2_FORNECE = '"+SF1->F1_FORNECE+"' AND E2_LOJA = '"+SF1->F1_LOJA+"' AND E2_TIPO = '"+SF1->F1_ESPECIE+"' AND D_E_L_E_T_ <> '*' "

TcSqlExec( cQuery )



Return Nil



@ 0,0 TO 227,697 DIALOG oDlgFBco TITLE "Informações Complementares/Dados Bancarios Fornecedor"
@ 5,02 TO 138,678 Label   "Dados Bancarios Fornecedor" 

	@ 14, 21 Say "Banco  " Size 160,10 FONT oFont1 COLOR CLR_BLUE Of oDlgFBco Pixel
	@ 14, 150 MsGet cbanco1 Picture "@E 999" Valid !empty(cbanco1) Size 070,10 Of oDlgFBco Pixel
//
	@ 051, 14 Say "Agencia " Size 160,10 FONT oFont1 COLOR CLR_BLUE Of oDlgFBco Pixel
	@ 065, 14 MsGet cagencia1 Valid !Empty(cagencia1) Size 040,10 Of oDlgFBco Pixel
//
	@ 090, 14 Say "Nro Conta " Size 160,10 FONT oFont1 COLOR CLR_BLUE Of oDlgFBco Pixel
	@ 065, 14 MsGet cConta1 Picture "@!" Valid !empty(cConta1) Size 070,10 Of oDlgFBco Pixel 




oSBtn26 := SBUTTON():Create(oDlgFBco)
oSBtn26:cName := "oSBtn26"
oSBtn26:cCaption := "Confirma"
oSBtn26:nLeft := 162
oSBtn26:nTop := 157
oSBtn26:nWidth := 52
oSBtn26:nHeight := 22
oSBtn26:lShowHint := .F.
oSBtn26:lReadOnly := .F.
oSBtn26:Align := 0
oSBtn26:lVisibleControl := .T.
oSBtn26:nType := 1
oSBtn26:bAction := {||GRVBCO(oDlgFBco) }


oSay28 := TSAY():Create(oDlgFBco)
oSay28:cName := "oSay28"
oSay28:cCaption := "Agencia"
oSay28:nLeft := 15
oSay28:nTop := 51
oSay28:nWidth := 119
oSay28:nHeight := 17
oSay28:lShowHint := .F.
oSay28:lReadOnly := .F.
oSay28:Align := 0
oSay28:lVisibleControl := .T.
oSay28:lWordWrap := .F.
oSay28:lTransparent := .F.

oSay29 := TSAY():Create(oDlgFBco)
oSay29:cName := "oSay29"
oSay29:cCaption := "Nro Conta"
oSay29:nLeft := 16
oSay29:nTop := 90
oSay29:nWidth := 119
oSay29:nHeight := 17
oSay29:lShowHint := .F.
oSay29:lReadOnly := .F.
oSay29:Align := 0
oSay29:lVisibleControl := .T.
oSay29:lWordWrap := .F.
oSay29:lTransparent := .F.


CAgencia := TGET():Create(oDlgFBco)
CAgencia:cName := "CAgencia"
CAgencia:cCaption := "oGet31"
CAgencia:nLeft := 151
CAgencia:nTop := 49
CAgencia:nWidth := 163
CAgencia:nHeight := 21
CAgencia:lShowHint := .F.
CAgencia:lReadOnly := .F.
CAgencia:Align := 0
CBanco:cVariable := "CAgencia"
CBanco:bSetGet := {|u| If(PCount()>0,CAgencia1:=u,CAgencia1) }
CAgencia:lVisibleControl := .T.
CAgencia:lPassword := .F.
CAgencia:lHasButton := .F.

CConta := TGET():Create(oDlgFBco)
CConta:cName := "CConta"
CConta:cCaption := "oGet32"
CConta:nLeft := 151
CConta:nTop := 86
CConta:nWidth := 163
CConta:nHeight := 21
CConta:lShowHint := .F.
CConta:lReadOnly := .F.
CConta:Align := 0
CBanco:cVariable := "CConta"
CBanco:bSetGet := {|u| If(PCount()>0,CConta1:=u,CConta1) }
CConta:lVisibleControl := .T.
CConta:lPassword := .F.
CConta:lHasButton := .F.

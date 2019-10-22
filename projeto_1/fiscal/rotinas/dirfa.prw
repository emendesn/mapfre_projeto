#Include "Protheus.ch"                                                                                         
#INCLUDE "rwmake.ch"  
#INCLUDE "TOPCONN.CH"                                   

/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณDIRFA   บ Autor ณ JUSCELINO          บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ MarkBrowse com filtro dos Titulos de Impostos da DIRF.     บฑฑ
ฑฑ                                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
                                        
User Function DIRFA()                              
Private _cPerg   := "GPEVER"
Private _cMarca  := GetMark()
Private cCadastro:= "Consulta dos Titulos para a DIRF"
Private cDelFunc := ".T."
Private cString:="SE2"
Private _lFiltra:=.f.
Private _cOper
Private _lSair:=.f.                                       
Private cQueryCad := ""
Private aFields := {}
Private cArq    := ""
Private _nCount := 0
Private _cCampos  := "E2_FILIAL,E2_NUM,E2_PREFIXO,E2_PARCELA,E2_TIPO,E2_NATUREZ,E2_NATUREZ,ED_CALCIRF,E2_CODRET,E2_DIRF,E2_EMISSAO,E2_BAIXA,E2_MISS1,E2_FORNECE,E2_LOJA,E2_TITPAI"
Private _aArqSel  := {'SE2',"SED"} 
Private _cArqSel2 := RetSqlName("SE2") 
Private _cOrdem   := ''
Private _cPesqPed := Space(9)
Private _cmesano:=Space(07)
Private _cFilial:=Space(02)      
Private _cano   :=Space(4)                                          
Private _ctit:=Space(6)                         
Private _csrdsn :="S"
Private aCombo	 := {"1 - Todos os Registros","2 - Registro Nใo Alterado","3 - Registro Alterado"}
Private cCombo   := ""
_nTipo:=2                 
//////////////////// Verificando a Existencia do Arquivo de grava as ALTERAวีES /////////////////////////////////

/*
_cArq   := "ARQDIRF"
If !File("\DATA\ARQDIRF.DBF")
   _aCampos := {{'CHAVE'  ,'C', 35, 0},;
   {'E2_FILIAL'  ,'C', 02, 0},;
   {'E2_PREFIXO' ,'C', 03, 0},;
   {'E2_NUM'     ,'C', 09, 0},;
   {'E2_PARCELA' ,'C', 01, 0},;
   {'E2_TIPO'    ,'C', 03, 0},;
   {'E2_FORNECE' ,'C', 06, 0},;
   {'E2_LOJA'    ,'C', 02, 0},;
   {'REGISTRO'  ,'N', 10, 0}}
 
   DbCreate("\DATA\"+_cArq, _aCampos)
   DbUseArea(.T.,"DBFCDX","\DATA\"+_cArq, "TMPSE2", .T., .F.)
   IndRegua("TMPSE2","\DATA\"+_cArq,"E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA")
 
Else 

   DbUseArea(.T.,"DBFCDX", "\DATA\"+_cArq, "TMPSE2", .T., .F.) 
   If File("\DATA\"+_cArq+OrdBagExt())
      dbSetIndex("\DATA\"+_cArq+OrdBagExt())
   Else
      IndRegua("TMPSE2","\DATA\"+_cArq,"E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA")
   EndIf   

EndIf
  */

DEFINE MSDIALOG oDlgGet TITLE OemtoAnsi("TITULOS PARA DIRF") FROM 200,050 TO 340,270 PIXEL OF oMainWnd //"DIPI"
nOpca:=0  
                                                                     
@ 010,002 Say "Filial               : "    OF oDlgGet Pixel SIZE 90,45 
@ 025,002 Say "Ano (9999)     : "          OF oDlgGet Pixel SIZE 90,45 
@ 040,002 Say "Selecione   : "             OF oDlgGet Pixel SIZE 60,30 

@ 010,073 MsGet _oFilial  Var  _cFilial  OF oDlgGet PIXEL Size 020,05 F3 "SM0" 
@ 025,073 MsGet _oano  Var  _cano Picture "9999" VALID NaoVazio( _cano ) OF oDlgGet PIXEL Size 020,05 
@ 040,035 ComboBox cCombo Items aCombo 	 Size 70,21  
  
DEFINE SBUTTON FROM 053,005 TYPE 1 ACTION (nOpca:=1,oDlgGet:End()) ENABLE OF oDlgGet
DEFINE SBUTTON FROM 053,040 TYPE 2 ACTION (nOpca:=2,oDlgGet:End()) ENABLE OF oDlgGet
	
ACTIVATE MSDIALOG oDlgGet Centered         

If nOpca = 2 .Or. nOpca = 0 .Or. Empty(_cano)
   //TMPSE2->(DbCloseArea())
   Return
EndIf 

_cano:=StrZero(Val(_cano),4)


MsAguarde( { || _rotconver() }, "TITULOS PARA DIRF", "Aguarde Pesquisando Titulos...", .T. )


//TMPSE2->(DbCloseArea())

Return


/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_rotconver บ Autor ณ JUSCELINO       บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel em montar o Browse e executar as rotinasบฑฑ
ฑฑ de carga de dados.                                                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function _rotconver

@ 100,-130 TO 530,900 DIALOG oDlgPedL TITLE cCadastro
aCampos := {}
_lmonta:=.F.
DbSelectArea('SX3')
DbSetOrder(1)
AADD(aCampos,{'000','E2_PARCFAB','',''})
For _nX := 1 To Len(_aArqSel)
	DbSeek(_aArqSel[_nX])
	While !Eof() .And. X3_ARQUIVO = _aArqSel[_nX]
		If ALLTRIM(X3_CAMPO) $ _cCampos
		    If ALLTRIM(X3_CAMPO)='ED_CALCIRF'
		       AADD(aCampos,{StrZero(AT(ALLTRIM(X3_CAMPO),_cCampos),3,0),Alltrim(X3_CAMPO),"Calcula IRF PAI",If(X3_TIPO='N',X3_PICTURE,'')})
		       DbSkip()
		       Loop
		    EndIf                      
		    AADD(aCampos,{StrZero(AT(ALLTRIM(X3_CAMPO),_cCampos),3,0),Alltrim(X3_CAMPO),Alltrim(X3_TITULO),If(X3_TIPO='N',X3_PICTURE,'')})
		    If ALLTRIM(X3_CAMPO)='E2_NATUREZ' 
		       AADD(aCampos,{StrZero(AT(ALLTRIM(X3_CAMPO),_cCampos)+1,3,0),'E2_NATURP',"Natureza PAI",If(X3_TIPO='N',X3_PICTURE,'')})
            EndIf
		Endif
		DbSkip()
	EndDo
Next            
_aCamposr:=aclone(aCampos)       
ASort(_aCamposr,,,{|x,y|x[1]<y[1]})
ASort(aCampos,,,{|x,y|x[1]<y[1]})

aCampos2 := {}
For _nX := 1 To Len(aCampos)
	AADD(aCampos2,{aCampos[_nX,2],aCampos[_nX,3],aCampos[_nX,4]})
Next
aCampos := {}
aCampos := aCampos2
Cria_SE2T()
DbSelectArea('SE2T')
@ 006,005 TO 200,470 BROWSE "SE2T" MARK "E2_PARCFAB" FIELDS aCampos Object _oBrwPed
@ 006,472 BUTTON "_Marca/Desmarca" SIZE 45,15 ACTION MarcaTit()        
@ 026,472 BUTTON "_Tudo-Mar./Des." SIZE 45,15 ACTION MarcaTitT()     
@ 046,472 BUTTON "Titu_lo" SIZE 45,15 ACTION Titulo("T")             
@ 066,472 BUTTON "Titulo_Pai" SIZE 45,15 ACTION Titulo("P")   
@ 086,472 BUTTON "_Relatorio" SIZE 45,15 ACTION Reldirf()   
@ 106,472 BUTTON "Corr._Automat." SIZE 45,15 ACTION CorrAut() 
@ 126,472 BUTTON "_Corr.Manual" SIZE 45,15 ACTION AJUSMAND()  
@ 146,472 BUTTON "_Parametros" SIZE 45,15 ACTION APARAMD()  
@ 196,472 BUTTON "_Sair"   SIZE 45,15 ACTION Close(oDlgPedL) 

Processa({|| Iif(Monta_SE2(_nTipo),.T.,Close(oDlgPedL)) } ,"Selecionando Informacoes dos Titulo...")

_oBrwPed:bMark := {|| Marcar()}

@ 205,005 SAY "Foram processados "+Alltrim(Str(_nCount,6,0))+" registro(s)"
@ If(_nTipo=1,166,166),472 SAY "Filial + Titulo"
@ If(_nTipo=1,176,176),472 GET _cPesqPed    Valid Pesquisa()

ACTIVATE DIALOG oDlgPedL CENTERED

DbSelectArea("SE2T")
DbCloseArea()
FErase(cArq+OrdBagExt())

Return(.T.)




/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณPesquisa บ Autor ณ JUSCELINO         บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel Pesquisa do Titulo dentro do Browse     บฑฑ
ฑฑ                                                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static FUNCTION Pesquisa()
If !Empty(_cPesqPed)
	If DbSeek(_cPesqPed)                                                           
	     RecLock('SE2T',.F.)
	     SE2T->E2_PARCFAB := _cMarca 
	     MsUnlock()
	   _oBrwPed:oBrowse:Refresh()  
	EndIf
Endif
SE2T->(Dbsetorder(1))
Return(.T.)



/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMarcar   บ Autor ณ JUSCELINO         บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel para cria a Marcar inicial do Titulo    บฑฑ
ฑฑ dentro do Browse                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function Marcar()
DbSelectArea('SE2T')
RecLock('SE2T',.F.)
If Empty(SE2T->E2_PARCFAB)
   SE2T->E2_PARCFAB := _cMarca
   SE2T->E2_Marcax:="X"                                                
Else                                                              
   SE2T->E2_Marcax:=" "
Endif                                                 
MsUnlock()
Return(.T.)


/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMarcaTit บ Autor ณ JUSCELINO         บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel para Marcar/Desmarcar o Titulo          บฑฑ
ฑฑ dentro do Browse                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function MarcaTit()
DbSelectArea('SE2T')
_cPedCorr := SE2T->E2_NUM                                       
_nRec := Recno()
While !Eof() .And. SE2T->E2_NUM = _cPedCorr
	RecLock('SE2T',.F.)
	If Empty(SE2T->E2_Marcax)                          
	   SE2T->E2_PARCFAB    := GetMark() 
	   SE2T->E2_Marcax:="X"                                                
	Else                                                              
	   SE2T->E2_PARCFAB    := ThisMark()
	   SE2T->E2_Marcax:=" "
    Endif
	MsUnlock()
	DbSkip()
EndDo
_oBrwPed:oBrowse:Refresh()  
DbGoTo(_nRec)
Return(.T.)


/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMarcaTitT บ Autor ณ JUSCELINO        บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel para Marcar/Desmarcar todos o Titulo    บฑฑ
ฑฑ dentro do Browse                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function MarcaTitT()
DbSelectArea('SE2T')
_cPedCorr := SE2T->E2_NUM                                       
_nRec := Recno()
SE2T->(DbGoTop())
While !Eof() 
	RecLock('SE2T',.F.)
	If Empty(SE2T->E2_Marcax)                          
	   SE2T->E2_PARCFAB := GetMark() 
	   SE2T->E2_Marcax  :="X"                                                
	Else                                                              
	   SE2T->E2_PARCFAB := ThisMark()
	   SE2T->E2_Marcax  :=" "
    Endif
	MsUnlock()
	DbSkip()
EndDo
_oBrwPed:oBrowse:Refresh()  
DbGoTo(_nRec)
Return(.T.)



/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCria_SE2T บ Autor ณ JUSCELINO        บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel para Criar a Tabela temporaria          บฑฑ
ฑฑ dos Titulos dentro do Browse                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static FUNCTION Cria_SE2T()
DbSelectArea('SX3')
DbSetOrder(1)
AADD(aFields,{"E2_PARCFAB"     ,"C",02,0})
For _nX := 1 To Len(_aArqSel)
	DbSeek(_aArqSel[_nX])
	While !Eof() .And. X3_ARQUIVO = _aArqSel[_nX]
		If ALLTRIM(X3_CAMPO) $ _cCampos         
		   AADD(aFields,{X3_CAMPO,X3_TIPO,X3_TAMANHO,X3_DECIMAL})
		   If ALLTRIM(X3_CAMPO)='E2_NATUREZ' 
		      AADD(aFields,{'E2_NATURP',X3_TIPO,X3_TAMANHO,X3_DECIMAL})
		   EndIf
		Endif
		DbSkip()
	EndDo
Next
If Len(aFields)>0
   AADD(aFields,{"E2_MARCAX","C",1,0})
EndIf
cArq:=Criatrab(aFields,.T.)
DBUSEAREA(.t.,,cArq,"SE2T")
Return

/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMonta_SE2 บ Autor ณ JUSCELINO        บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel para Alimentar a Tabela temporaria      บฑฑ
ฑฑ dos Titulos dentro do Browse                                           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function Monta_SE2(_nTipoPar)
Local _lret:=.T.
_nCount:=0
dInicio:=Ctod("01/01/"+_cano)
dFinal :=Ctod("31/12/"+_cano)

Dbselectarea("SE2T")
DbGoTop()
   
_cIndex:=Criatrab(Nil,.F.)
_cChave:="E2_FILIAL+E2_NUM+E2_PREFIXO+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA"
Indregua("SE2T",_cIndex,_cChave,,,"Ordenando registros selecionados...")
DbSetIndex(_cIndex+ordbagext())

// IDENTIFICAR OS FORNECEDORES.
DBSELECTAREA("SE2")
cIndSE2 := CriaTrab(Nil,.F.)
dbSelectArea("SE2")
cChave  := "E2_FILIAL+Dtos(E2_EMIS1)+E2_NOMFOR+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO"
//cFiltro := "Dtos(E2_EMIS1)>='"+Dtos(mv_par01)+"'.And.Dtos(E2_EMIS1)<='"+Dtos(mv_par02)+"'"
IndRegua("SE2",cIndSE2,cChave,,,"Selecionando Registros...")
nIndex1 := RetIndex("SE2")
#IFNDEF TOP
   dbSetIndex(cIndSE2+OrdBagExt())
#ENDIF
dbSetOrder(nIndex1+1)
dbGotop()

//DBSETORDER(7) // FILIAL + EMISSAO 
If Empty(_cFilial)
   _cFilial:=XFILIAL("SE2")
EndIf   
DBSEEK(_cFilial+DTOS(dInicio) , .T. )
DO WHILE !EOF() .AND. (SE2->E2_FILIAL == _cFilial ) .AND. SE2->E2_EMIS1<=dFinal

   /// Verificando quais Registros devem ser Processados    
   If Alltrim(SE2->E2_NUM)="004313"  //"004287"
      _xxx:="lixo"
   EndIf                   
   IF SE2->E2_IRRF <> 0  /// TEVE RETENCAO DE IRRF
      nRegAnt := SE2->( RECNO() )
      nOrdAnt := SE2->( INDEXORD() )
      
      cPref   := SE2->E2_PREFIXO
      cNum    := SE2->E2_NUM
      cParcela:= SE2->E2_PARCELA
      cTipo   := SE2->E2_TIPO 
      cfornece:= SE2->E2_FORNECE
      clojat  := SE2->E2_LOJA
      _cnatpai:= SE2->E2_NATUREZ         
      _cirfpai:= Posicione("SED",1,xFilial("SED")+SE2->E2_NATUREZ,"ED_CALCIRF")
      
      SA2->(DBSETORDER(1))
      SA2->(DBSEEK(XFILIAL("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA , .F. ))
                 
      cPessoa := Alltrim(SA2->A2_TIPO)   //IF( LEN(alltrim( SA2->A2_CGC ) ) == 14  , "J", "F" )
      nIRRF   := SE2->E2_IRRF
     
      // ACHAR O TX CORRESPONDENTE
      DBSELECTAREA("SE2")
      DBSETORDER(1)   /// FILIAL + PREFI+ NUM... 
      DO WHILE !EOF() .AND. ( SE2->( E2_FILIAL + E2_PREFIXO + E2_NUM )  == _cFilial + cPref + cNum  )
             
         //If (!(SE2->E2_EMISSAO>=dInicio .And. SE2->E2_EMISSAO<=dFinal) .And. !(SE2->E2_EMIS1>=dInicio .And. SE2->E2_EMIS1<=dFinal))
         If !(SE2->E2_EMIS1>=dInicio .And. SE2->E2_EMIS1<=dFinal)
            DbSkip()
            Loop
         EndIf
         
         If Alltrim(SE2->E2_NUM)= "000131"
           _xxx:="lixo"
         EndIf
         
            If Alltrim(SE2->E2_NUM)="004313"  //"004287"
              _xxx:="lixo"
            EndIf                   

         
         

           
         ///  Checa se Registro ja foi   
         If SubStr(cCombo,1,1)='2'  .And.  SE2->E2_XALDIRF="A"  /// Nใo Alterado
            
      /*
            If TMPSE2->(DbSeek(SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA))
               DBSELECTAREA("SE2")
               DbSkip()
               Loop
            EndIf                      
            */     
            
            DBSELECTAREA("SE2")
            DbSkip()
            Loop
            
          
         ElseIf  SubStr(cCombo,1,1)='3' .And. Empty(SE2->E2_XALDIRF)  // Alterado
            
         /*
            If !TMPSE2->(DbSeek(SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA))
               DBSELECTAREA("SE2")
               DbSkip()
               Loop
            EndIf  
            
            */
            
            DBSELECTAREA("SE2")
            DbSkip()
            Loop                    
        
         Endif

           
          // IRRF

         IF ( SE2->E2_NATUREZ == PADR("IRF",10," ")  ) .AND. ( SE2->E2_TIPO == "TX " )

            DBSELECTAREA("SE2T")
            RecLock("SE2T",.T.)
	        For _nX := 1 To Len(aFields)
		        If aFields[_nX,1] <> 'E2_PARCFAB' .And. aFields[_nX,1] <> 'E2_MARCAX' .And. aFields[_nX,1] <> 'ED_CALCIRF' .And.;
		          aFields[_nX,1] <>'E2_NATURP'
			       If aFields[_nX,2] = 'C'
				      _cX := 'SE2T->'+aFields[_nX,1]+' := SE2->'+aFields[_nX,1]+''
			       Else
				      _cX := 'SE2T->'+aFields[_nX,1]+' := SE2->'+aFields[_nX,1]
			       Endif
			       _cX := &_cX
			    ElseIf   Alltrim(aFields[_nX,1])=='ED_CALCIRF'
			       _cX := 'SE2T->'+aFields[_nX,1]+' := _cirfpai'
			       _cX := &_cX
                ElseIf   Alltrim(aFields[_nX,1])=='E2_NATURP'
			       _cX := 'SE2T->'+aFields[_nX,1]+' := _cnatpai'
			       _cX := &_cX			       
		        Endif
	        Next
	        _nCount++
	        SE2T->E2_PARCFAB := ThisMark()
	        SE2T->(MsUnLock())
         ENDIF

         // PIS/COFINS/CSLL

         IF  ( SE2->E2_TIPO == "TX " )  .AND.   ;
             ( ALLTRIM(SE2->E2_NATUREZ) $ ( AllTrim(GetMv("MV_PISNAT")) +"/"+;
             								AllTrim(GetMv("MV_COFINS")) +"/"+;
             								AllTrim(GetMv("MV_CSLL"  ))        ) )        
            DBSELECTAREA("SE2T")  
            RecLock("SE2T",.T.)
	        For _nX := 1 To Len(aFields)
		        If aFields[_nX,1] <> 'E2_PARCFAB' .And. aFields[_nX,1] <> 'E2_MARCAX' .And. aFields[_nX,1] <> 'ED_CALCIRF' .And.;
		          aFields[_nX,1] <>'E2_NATURP'
			       If aFields[_nX,2] = 'C'
				      _cX := 'SE2T->'+aFields[_nX,1]+' := SE2->'+aFields[_nX,1]+''
			       Else
				      _cX := 'SE2T->'+aFields[_nX,1]+' := SE2->'+aFields[_nX,1]
			       Endif
			       _cX := &_cX
                ElseIf   Alltrim(aFields[_nX,1])=='ED_CALCIRF'  
                   _cX := 'SE2T->'+aFields[_nX,1]+' := _cirfpai'
			       _cX := &_cX   
			    ElseIf   Alltrim(aFields[_nX,1])=='E2_NATURP'
			       _cX := 'SE2T->'+aFields[_nX,1]+' := _cnatpai'
			       _cX := &_cX			       
		        Endif
	        Next
	        _nCount++
	        SE2T->E2_PARCFAB := ThisMark()
	        SE2T->(MsUnLock())              
         ENDIF

         
         DBSELECTAREA("SE2")
         DBSKIP()

      ENDDO
      
      
      DBSETORDER5(nOrdAnt)
      SE2->(DBGOTO( nRegAnt ) )

   ENDIF 

   DBSELECTAREA("SE2")
   DBSKIP()
ENDDO
RetIndex("SE2")

If _nCount<=0
   MsgStop("Nใo Existe Dados para Ajustes da DIRF", "Aten็ใo")
   _lret:=.F.
EndIf
Dbselectarea("SE2T")
DbGoTop()
   
Return _lret



/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTitulo บ Autor ณ JUSCELINO           บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel pela visualiza็ใo dos Daods do Titulo   บฑฑ
ฑฑ na Tela Padrใo dentro do Browse                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static FUNCTION Titulo(_ctpcon)
Local _lpesq:=.F.

DbSelectArea("SE2")
DbSetOrder(1)   /// FILIAL + PREFI+ NUM... 
If _ctpcon="T"
   _cchavet:=SE2T->E2_FILIAL+SE2T->E2_PREFIXO+SE2T->E2_NUM+SE2T->E2_PARCELA+SE2T->E2_TIPO+SE2T->E2_FORNECE+SE2T->E2_LOJA
   If DbSeek(_cchavet)
      _lpesq:=.T.
   EndIf                                                                      
Else
   If SubStr(SE2T->E2_TITPAI,11,3)=Space(3)
      _cchavet:=SE2T->E2_FILIAL+SE2T->E2_TITPAI
   Else 
      _cchavet:=SE2T->E2_FILIAL+SubStr(SE2T->E2_TITPAI,1,9)+Space(3)+SubStr(SE2T->E2_TITPAI,10)
   EndIf   
   If DbSeek(_cchavet)
      _lpesq:=.T.
   EndIf   
EndIf   
If _lpesq                         
  Fa050Visua("SE2",SE2->(RECNO()),2)
Else                  
  alert(Iif(_ctpcon<>"T","Titulo Principal Nใo Encontrado","Titulo Nใo Encontrado"))
EndIf
DbSelectArea("SE2T")
Return



/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCorrAut บ Autor ณ JUSCELINO         บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel pela Corre็ใo Automatica de Todos os    บฑฑ
ฑฑ Titulos sem a interven็ใo do usuario.                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function CorrAut()                      
Local _ncont:=0      
Local aCombo	 := {"1 - Simula็ใo","2 - Simula็ใo / Grava็ใo"}
Local cCombo   := ""


DEFINE MSDIALOG oDlgam TITLE OemtoAnsi("CORREวรO AUTOMATICA") FROM 200,050 TO 285,270 PIXEL OF oMainWnd //"DIPI"
@ 011,002  Say  "Selecione   : "            OF oDlgam Pixel SIZE 60,30 
@ 011,035 ComboBox cCombo Items aCombo 	 Size 70,21  //OF oDlgam

DEFINE SBUTTON FROM 031,005 TYPE 1 ACTION (nOpca:=1,oDlgam:End()) ENABLE OF oDlgam
DEFINE SBUTTON FROM 031,040 TYPE 2 ACTION (nOpca:=2,oDlgam:End()) ENABLE OF oDlgam
	
ACTIVATE MSDIALOG oDlgam Centered         

If nOpca = 2 .Or. nOpca = 0            
   Return
EndIf 
                         
If !MsgYesNo('Confirma o Ajuste Automatico dos Titulos ?')
	Return(.T.)
Endif

SE2->(DbSetOrder(1))
SE2T->(DbGotop())
While SE2T->(!EOF())                      

  IF Alltrim(SE2->E2_NUM) = '001219'  .or. Alltrim(SE2->E2_NUM)="000131"
     _LIXO:="11"
  ENDIF   

  If !Empty(SE2T->E2_Marcax) 

     _cchavet:=SE2T->E2_FILIAL+SE2T->E2_PREFIXO+SE2T->E2_NUM+SE2T->E2_PARCELA+SE2T->E2_TIPO+SE2T->E2_FORNECE+SE2T->E2_LOJA
     
     If SE2->(DbSeek(_cchavet))
     
        cfilt   := SE2->E2_FILIAL
        cPref   := SE2->E2_PREFIXO
        cNum    := SE2->E2_NUM
        cParcela:= SE2->E2_PARCELA
        cTipo   := SE2->E2_TIPO 
        _nregse2:= SE2->(Recno())
        
        IF Alltrim(SE2->E2_NUM) = '001219' .or. Alltrim(SE2->E2_NUM)="000131"
           _LIXO:="11"
        ENDIF   
      
        SA2->(DbSetOrder(1))
        SA2->(DbSeek(Xfilial("SA2")+SE2->E2_FORNECE+SE2->E2_LOJA , .F. ))  //SE2->E2_FILIAL+SE2->E2_FORNECE+SE2->E2_LOJA 
                 
        cPessoa := Alltrim(SA2->A2_TIPO) //IF( LEN(alltrim( SA2->A2_CGC ) ) == 14  , "J", "F" )
        nIRRF   := SE2->E2_IRRF
        
        // IRRF

        IF ( SE2->E2_NATUREZ == PADR("IRF",10," ")  ) .AND. ( SE2->E2_TIPO == "TX " )
            _ncont++     
            If SubStr(cCombo,1,1)="2"
               RECLOCK("SE2", .F. )
               REPLACE SE2->E2_DIRF WITH "1",SE2->E2_XALDIRF  WITH "A"
               IF cPessoa = "J"
                  REPLACE SE2->E2_CODRET WITH "1708",SE2->E2_XALDIRF  WITH "A"
               ELSE
                  REPLACE SE2->E2_CODRET WITH "0561" ,SE2->E2_XALDIRF  WITH "A"
               ENDIF           
               SE2->(MSUNLOCK())   
               
               /*
               If !TMPSE2->(DbSeek(SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA))
                  RECLOCK("TMPSE2", .T. )
                  TMPSE2->E2_FILIAL  :=SE2->E2_FILIAL
                  TMPSE2->E2_PREFIXO :=SE2->E2_PREFIXO
                  TMPSE2->E2_NUM     :=SE2->E2_NUM
                  TMPSE2->E2_PARCELA :=SE2->E2_PARCELA
                  TMPSE2->E2_TIPO    :=SE2->E2_TIPO
                  TMPSE2->E2_FORNECE :=SE2->E2_FORNECE
                  TMPSE2->E2_LOJA    :=SE2->E2_LOJA
                  TMPSE2->REGISTRO   :=SE2->(Recno())
                  TMPSE2->(MsUnlock())
               Endif
               */
               
            EndIf
            
            RECLOCK("SE2T", .F. )
            REPLACE SE2T->E2_DIRF WITH "1"
            IF cPessoa = "J"
               REPLACE SE2T->E2_CODRET WITH "1708" 
            ELSE
               REPLACE SE2T->E2_CODRET WITH "0561" 
            ENDIF               
            SE2T->E2_PARCFAB    := ThisMark()
	        SE2T->E2_Marcax:=" "
            SE2T->(MSUNLOCK())   
            
            
            If SubStr(cCombo,1,1)="2"
               If SubStr(SE2->E2_TITPAI,11,3)=Space(3)
                  _cchavet:=SE2->E2_FILIAL+SE2->E2_TITPAI
               Else 
                  _cchavet:=SE2->E2_FILIAL+SubStr(SE2->E2_TITPAI,1,9)+Space(3)+SubStr(SE2->E2_TITPAI,10)
               EndIf   
               If SE2->(DbSeek(_cchavet))
                  RECLOCK("SE2", .F.)
                  REPLACE SE2->E2_DIRF WITH "2" ,SE2->E2_XALDIRF  WITH "A"
                  IF cPessoa = "J"
                     REPLACE SE2->E2_CODRET WITH "1708" ,SE2->E2_XALDIRF  WITH "A"
                  ELSE
                     REPLACE SE2->E2_CODRET WITH "0561" ,SE2->E2_XALDIRF  WITH "A"
                  ENDIF           
                  SE2->(MSUNLOCK())
                            
                  /*
                  If !TMPSE2->(DbSeek(SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA))
                     RECLOCK("TMPSE2", .T. )
                     TMPSE2->E2_FILIAL  :=SE2->E2_FILIAL
                     TMPSE2->E2_PREFIXO :=SE2->E2_PREFIXO
                     TMPSE2->E2_NUM     :=SE2->E2_NUM
                     TMPSE2->E2_PARCELA :=SE2->E2_PARCELA
                     TMPSE2->E2_TIPO    :=SE2->E2_TIPO
                     TMPSE2->E2_FORNECE :=SE2->E2_FORNECE
                     TMPSE2->E2_LOJA    :=SE2->E2_LOJA
                     TMPSE2->REGISTRO   :=SE2->(Recno())
                     TMPSE2->(MsUnlock())
                  Endif
                  */
                  
               EndIf                  
            EndIf
            
            SE2->(DbGoto(_nregse2))
        ENDIF

        // PIS/COFINS/CSLL

        If ( SE2->E2_TIPO == "TX " )  .AND.   ;
           ( ALLTRIM(SE2->E2_NATUREZ) $ ( AllTrim(GetMv("MV_PISNAT")) +"/"+;
           AllTrim(GetMv("MV_COFINS")) +"/"+;
           AllTrim(GetMv("MV_CSLL"  ))        ) )        
           _ncont++
            
            
           If SubStr(cCombo,1,1)="2"  
              RECLOCK("SE2", .F. )
              REPLACE SE2->E2_DIRF WITH "1",SE2->E2_XALDIRF  WITH "A"
              REPLACE SE2->E2_CODRET WITH "5952" ,SE2->E2_XALDIRF  WITH "A"
              SE2->(MSUNLOCK())                                             
              
              /*
              If !TMPSE2->(DbSeek(SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA))
                 RECLOCK("TMPSE2", .T. )
                 TMPSE2->E2_FILIAL  :=SE2->E2_FILIAL
                 TMPSE2->E2_PREFIXO :=SE2->E2_PREFIXO
                 TMPSE2->E2_NUM     :=SE2->E2_NUM
                 TMPSE2->E2_PARCELA :=SE2->E2_PARCELA
                 TMPSE2->E2_TIPO    :=SE2->E2_TIPO
                 TMPSE2->E2_FORNECE :=SE2->E2_FORNECE
                 TMPSE2->E2_LOJA    :=SE2->E2_LOJA
                 TMPSE2->REGISTRO   :=SE2->(Recno())
                 TMPSE2->(MsUnlock())
              Endif
              */
              
           EndIf   
           
           RECLOCK("SE2T", .F. )
           REPLACE SE2T->E2_DIRF WITH "1"
           REPLACE SE2T->E2_CODRET WITH "5952" 
           SE2T->E2_PARCFAB    := ThisMark()
	       SE2T->E2_Marcax:=" "
           SE2T->(MSUNLOCK())    
           
           If SubStr(cCombo,1,1)="2"
              If SubStr(SE2->E2_TITPAI,11,3)=Space(3)
                 _cchavet:=SE2->E2_FILIAL+SE2->E2_TITPAI
              Else 
                 _cchavet:=SE2->E2_FILIAL+SubStr(SE2->E2_TITPAI,1,9)+Space(3)+SubStr(SE2->E2_TITPAI,10)
              EndIf   
              If SE2->(DbSeek(_cchavet))
                 RECLOCK("SE2", .F.)
                 REPLACE SE2->E2_DIRF WITH "2" ,SE2->E2_XALDIRF  WITH "A"
                 IF cPessoa = "J"
                     REPLACE SE2->E2_CODRET WITH "1708" ,SE2->E2_XALDIRF  WITH "A"
                 ELSE
                     REPLACE SE2->E2_CODRET WITH "0561" ,SE2->E2_XALDIRF  WITH "A"
                 ENDIF           
                 SE2->(MSUNLOCK())
                  
                 /*
                 If !TMPSE2->(DbSeek(SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA))
                    RECLOCK("TMPSE2", .T. )
                    TMPSE2->E2_FILIAL  :=SE2->E2_FILIAL
                    TMPSE2->E2_PREFIXO :=SE2->E2_PREFIXO
                    TMPSE2->E2_NUM     :=SE2->E2_NUM
                    TMPSE2->E2_PARCELA :=SE2->E2_PARCELA
                    TMPSE2->E2_TIPO    :=SE2->E2_TIPO
                    TMPSE2->E2_FORNECE :=SE2->E2_FORNECE
                    TMPSE2->E2_LOJA    :=SE2->E2_LOJA
                    TMPSE2->REGISTRO   :=SE2->(Recno())
                    TMPSE2->(MsUnlock())
                 Endif
                 */
                 
              EndIf                  
           EndIf
           
           SE2->(DbGoto(_nregse2))
        EndIf

     EndIf 
     
  EndIf
        
  SE2T->(DbSkip())
  
End-While
SE2T->(DbGotop())
If _ncont>0
   MsgInfo("Total de Registros Processados "+Alltrim(Str(_ncont))+".","Aviso","ALERTA")
Else
   MsgInfo("Nใo houve Registros Processados .","Aviso","ALERTA")
EndIf
Return



/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณReldirf บ Autor ณ JUSCELINO          บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel pela Gera็ใo do Relatorio de todos      บฑฑ
ฑฑ Titulos da DIRF em EXCEL.                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function Reldirf()
Local aCombo	 := {"1 - Rela็ใo dos Titulos","2 - Informe Rendimento"}
Local cCombo   := ""
DEFINE MSDIALOG oDlgam TITLE OemtoAnsi("R E L A T O R I O S") FROM 200,050 TO 285,270 PIXEL OF oMainWnd //"DIPI"
@ 011,002  Say  "Selecione   : "            OF oDlgam Pixel SIZE 60,30 
@ 011,035 ComboBox cCombo Items aCombo 	 Size 70,21  //OF oDlgam

DEFINE SBUTTON FROM 031,005 TYPE 1 ACTION (nOpca:=1,oDlgam:End()) ENABLE OF oDlgam
DEFINE SBUTTON FROM 031,040 TYPE 2 ACTION (nOpca:=2,oDlgam:End()) ENABLE OF oDlgam
	
ACTIVATE MSDIALOG oDlgam Centered         

If nOpca = 2 .Or. nOpca = 0            
   Return
EndIf 
                         
If SubStr(cCombo,1,1)="2"
   GPEM580()
   Return
EndIf   

/// Executa a op็ใo <01 - Titulos>
cPath   := AllTrim(GetTempPath())  
_cArqTRB:=CriaTrab(,.F.)
cArquivo	:= _cArqTRB + ".XLS"
cHTML		:= ""      

DBSELECTAREA("SE2T")  
DbGotop()
If Eof()
   MsgStop("Nใo Existe Dados para a Gerar Relatorio", "Aten็ใo")
   Return
EndIf   
Ferase(cArquivo)
nHdl := fCreate(cArquivo)
If nHdl == -1
   MsgAlert("O arquivo de nome "+cArquivo+" nao pode ser executado! Verifique os parametros.","Atencao!")
   Return Nil
Endif
   /////////////////////////////////
cHtml := '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> '
cHtml += '<html xmlns="http://www.w3.org/1999/xhtml"> '
cHtml += '<head> '
cHtml += '<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> '
cHtml += '<title>Untitled Document</title> '
cHtml += '</head> '
cHtml += '<body> '
cHtml += '<table width="700" border="1"> '
cHtml += '  <tr> '

For _nX := 1 To Len(_aCamposr)
  If _aCamposr[_nX,2] <> 'E2_PARCFAB' .And. _aCamposr[_nX,2] <> 'E2_MARCAX'
     cHtml += '     <td width="20%" align="center" bgcolor="#CCFFFF"><font face="Tahoma" size="1">'+Alltrim(_aCamposr[_nX,3])+'</font></td>'
  EndIf
Next _nX	   


cHtml += '  </tr> '
fWrite(nHdl,cHTML,Len(cHTML)) 
  
cHtml := ''                    

DBSELECTAREA("SE2T")  
DbGotop()
While !Eof()             
    cHtml := '    <tr>
    
 
    For _nX := 1 To Len(_aCamposr)
	    If _aCamposr[_nX,2] <> 'E2_PARCFAB' .And. _aCamposr[_nX,2] <> 'E2_MARCAX'
	      _cX := 'SE2T->'+_aCamposr[_nX,2]
	      _cX := Iif(Valtype(&_cX)='D',Dtoc(&_cX),Iif(Valtype(&_cX)='N',Alltrim(Str(&_cX)),&_cX))
  	      cHtml += '    <td width="30%" align="center"> <font face="Tahoma" size="1">'+ _cX  +'</font></td>'
  	   EndIf   
    Next
        
    cHtml += '    </tr> '  
	fWrite(nHdl,cHTML,Len(cHTML))
	DbSkip()
End-While	
cHtml := '</table> '
cHtml += '</body> '                                                                 
cHtml += '</html> '     
		
fWrite(nHdl,cHTML,Len(cHTML))
		
fClose(nHdl)
   
CpyS2T( GetSrvProfString("StartPath","",GetAdv97()) + cArquivo, cPath, .T. )
ShellExecute("OPEN",cPath + cArquivo,"","",5)
DbGotop()
Return


/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAJUSMAND บ Autor ณ JUSCELINO         บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel pela Corre็ใo manual dos Titulos        บฑฑ
ฑฑ com a interven็ใo do usuario.                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function AJUSMAND()
Local _ctitulo  :=SE2T->E2_NUM
Local _cprefixo :=SE2T->E2_PREFIXO
Local _cparcela :=SE2T->E2_PARCELA

If Empty(_ctitulo)
   MsgStop("Nใo Existe Titulo para Ajuste Manual", "Aten็ใo")
   Return
EndIf

If SE2T->E2_DIRF='1'
   aCombo	 := {"1 - Gera DIRF","2 - Nใo Gera DIRF"}
Else
   aCombo	 := {"2 - Nใo Gera DIRF","1 - Gera DIRF"}
EndIf   
cCombo   := ""
_ccodret := SE2T->E2_CODRET
nOpca    := 0
                                        
DEFINE MSDIALOG oDlgam TITLE OemtoAnsi("AJUSTE MANUAL DA DIRF") FROM 200,050 TO 390,270 PIXEL OF oMainWnd //"DIPI"
@ 011,002  Say  "Titulo               : "            OF oDlgam Pixel SIZE 60,30 
@ 025,002  Say  "Prefixo            : "            OF oDlgam Pixel SIZE 60,30                                                                      
@ 039,002  Say  "Parcela            : "            OF oDlgam Pixel SIZE 60,30                                                                      
@ 053,002  Say  "Gera DIRF            : "            OF oDlgam Pixel SIZE 60,30 
@ 067,002  Say  "Cod.Reten็ใo       : "            OF oDlgam Pixel SIZE 60,30 
@ 011,052 MsGet _otitulo  Var  _ctitulo  When .F. OF oDlgam PIXEL Size 020,05 
@ 025,052 MsGet _oprefixo  Var  _cprefixo  When .F. OF oDlgam PIXEL Size 020,05 
@ 039,052 MsGet _oparcela  Var  _cparcela  When .F. OF oDlgam PIXEL Size 020,05 
@ 053,052 ComboBox cCombo Items aCombo 	 Size 57,21  //OF oDlgam
@ 067,052 MsGet _ocodret  Var  _ccodret  OF oDlgam PIXEL Size 020,05  F3 "37" 
  
DEFINE SBUTTON FROM 081,005 TYPE 1 ACTION (nOpca:=1,oDlgam:End()) ENABLE OF oDlgam
DEFINE SBUTTON FROM 081,040 TYPE 2 ACTION (nOpca:=2,oDlgam:End()) ENABLE OF oDlgam
	
ACTIVATE MSDIALOG oDlgam Centered         

If nOpca = 2 .Or. nOpca = 0            
   Return
EndIf 

If nOpca = 1
   RECLOCK("SE2T", .F. )
   REPLACE SE2T->E2_DIRF   WITH SubStr(cCombo,1,1)
   REPLACE SE2T->E2_CODRET WITH _ccodret
   SE2T->(MSUNLOCK())   
   
   SE2->(DbSetOrder(1))
   _cchavet:=SE2T->E2_FILIAL+SE2T->E2_PREFIXO+SE2T->E2_NUM+SE2T->E2_PARCELA+SE2T->E2_TIPO+SE2T->E2_FORNECE+SE2T->E2_LOJA
   If SE2->(DbSeek(_cchavet))           
      RECLOCK("SE2", .F. )
      REPLACE SE2->E2_DIRF   WITH SubStr(cCombo,1,1),SE2->E2_XALDIRF  WITH "A"
      REPLACE SE2->E2_CODRET WITH _ccodret,SE2->E2_XALDIRF  WITH "A"
      SE2->(MSUNLOCK())                                             
      
      /*
      If !TMPSE2->(DbSeek(SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_PARCELA+SE2->E2_TIPO+SE2->E2_FORNECE+SE2->E2_LOJA)) 
         RECLOCK("TMPSE2", .T. )
         TMPSE2->E2_FILIAL  :=SE2->E2_FILIAL
         TMPSE2->E2_PREFIXO :=SE2->E2_PREFIXO
         TMPSE2->E2_NUM     :=SE2->E2_NUM
         TMPSE2->E2_PARCELA :=SE2->E2_PARCELA
         TMPSE2->E2_TIPO    :=SE2->E2_TIPO
         TMPSE2->E2_FORNECE :=SE2->E2_FORNECE
         TMPSE2->E2_LOJA    :=SE2->E2_LOJA
         TMPSE2->REGISTRO   :=SE2->(Recno())
         TMPSE2->(MsUnlock())
      Endif
      */
      
   EndIf
EndIf
Return


/*/                                                         
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAPARAMD บ Autor ณ JUSCELINO          บ Data ณ   20/10/2014  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Rotina Responsavel pela Manuten็ใo dos Parametros          บฑฑ
ฑฑ que interfere na Gera็ใo da DIRF.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                                                                                        
Static Function APARAMD()       
Local _cVISDIRF  := GetMv("MV_VISDIRF",.F.,"1")
Local _cINSIRF   := GetMv("MV_INSIRF",.F.,"1")
Local _cIRF      := GetMv("MV_IRF",.F.,'"IRF"')
Local _cPISNAT   := GetMv("MV_PISNAT",.F.,'PIS')
Local _cCOFINS   := GetMv("MV_COFINS",.F.,'COFINS')
Local _cCSLL     := GetMv("MV_CSLL",.F.,'CSLL')
Local _cACMIRPJ  := GetMv("MV_ACMIRPJ",.F.,"1")
Local _cACMIRPF  := GetMv("MV_ACMIRPF",.F.,"1")
Local _cVENCIRF  := GetMv("MV_VENCIRF",.F.,"E")
nOpca    := 0
                                        
DEFINE MSDIALOG oDlgam TITLE OemtoAnsi("PARAMETROS DA DIRF") FROM 100,050 TO 400,270 PIXEL OF oMainWnd //"DIPI"
@ 011,002  Say  "MV_VISDIRF        : "   OF oDlgam Pixel SIZE 60,30 
@ 025,002  Say  "MV_INSIRF         : "            OF oDlgam Pixel SIZE 60,30  
@ 039,002  Say  "MV_IRF            : "            OF oDlgam Pixel SIZE 60,30  
@ 053,002  Say  "MV_PISNAT         : "            OF oDlgam Pixel SIZE 60,30  
@ 067,002  Say  "MV_COFINS         : "            OF oDlgam Pixel SIZE 60,30  
@ 081,002  Say  "MV_CSLL           : "            OF oDlgam Pixel SIZE 60,30  
@ 095,002  Say  "MV_ACMIRPJ        : "            OF oDlgam Pixel SIZE 60,30  
@ 109,002  Say  "MV_ACMIRPF        : "            OF oDlgam Pixel SIZE 60,30  
@ 123,002  Say  "MV_VENCIRF        : "            OF oDlgam Pixel SIZE 60,30  
@ 011,052 MsGet _oVISDIRF  Var  _cVISDIRF   OF oDlgam PIXEL Size 020,05 MESSAGE "Habilita a informacao se os impostos farao parte da DIRF e a digitacao do codigo da Retencao do IR na entrada. 1=Habilita;2=Nao habilita(Padrใo) - para DIRF(1) "   
@ 025,052 MsGet _oINSIRF  Var  _cINSIRF   OF oDlgam PIXEL Size 020,05 MESSAGE "Define se o valor do INSS deve ser abatido da base de calculo do IRRF no Financeiro. '1' = Abate o valor da base de calculo do IRRF. '2' = Nไo abate - para DIRF(Defini็ใo do Fiscal)"   
@ 039,052 MsGet _oIRF  Var  _cIRF   OF oDlgam PIXEL Size 020,05 MESSAGE 'Natureza utilizada para Imposto de Renda - para DIRF("IRF") com as ASPAS.'
@ 053,052 MsGet _oPISNAT  Var  _cPISNAT  OF oDlgam PIXEL Size 020,05   MESSAGE 'Natureza para titulos referentes ao PIS - para a DIRF normalmente (PIS) ou Defini็ใo do Fiscal'
@ 067,052 MsGet _oCOFINS  Var  _cCOFINS   OF oDlgam PIXEL Size 020,05  MESSAGE 'Natureza para titulos referentes a COFINS - para a DIRF normalmente (COFINS) ou Defini็ใo do Fiscal'
@ 081,052 MsGet _oCSLL  Var  _cCSLL   OF oDlgam PIXEL Size 020,05 MESSAGE 'Natureza para titulos referentes a CSLL - para a DIRF normalmente (CSLL) ou Defini็ใo do Fiscal'
@ 095,052 MsGet _oACMIRPJ  Var  _cACMIRPJ  OF oDlgam PIXEL Size 020,05  MESSAGE 'Define se a cumulatividade dos valores de IR-PJ levarao em conta a data de Emissao ou Vencto do titulo principal. 1=Emissao;2=Vencto Real;3=Dt Contab - para a DIRF normalmente (1) ou Defini็ใo do Fiscal'
@ 109,052 MsGet _oACMIRPF  Var  _cACMIRPF  OF oDlgam PIXEL Size 020,05  MESSAGE 'Define se a cumulatividade dos valores de IR-PF levarao em conta a data de Emissao ou Vencimento do titulo principal. 1=Emissao; 2=Vencto Real - para a DIRF normalmente (1) ou Defini็ใo do Fiscal'       
@ 123,052 MsGet _oVENCIRF  Var  _cVENCIRF  OF oDlgam PIXEL Size 020,05  MESSAGE 'Indica se o titulo de IRRF sera gerado a partir da data de (E)missao, (V)encimento ou (C)ontabilizacao - para a DIRF normalmente (1) ou Defini็ใo do Fiscal'       

  
DEFINE SBUTTON FROM 137,005 TYPE 1 ACTION (nOpca:=1,oDlgam:End()) ENABLE OF oDlgam
DEFINE SBUTTON FROM 137,040 TYPE 2 ACTION (nOpca:=2,oDlgam:End()) ENABLE OF oDlgam
	
ACTIVATE MSDIALOG oDlgam Centered         

If nOpca = 2 .Or. nOpca = 0            
   Return
EndIf 

If nOpca = 1          
   PutMv("MV_VISDIRF",_cVISDIRF)
   PutMv("MV_INSIRF",_cINSIRF)
   PutMv("MV_IRF",_cIRF)
   PutMv("MV_PISNAT",_cPISNAT)
   PutMv("MV_COFINS",_cCOFINS)   
   PutMv("MV_CSLL",_cCSLL)   
   PutMv("MV_ACMIRPJ",_cACMIRPJ)   
   PutMv("MV_ACMIRPF",_cACMIRPF)   
   PutMv("MV_VENCIRF",_cVENCIRF)      
EndIf

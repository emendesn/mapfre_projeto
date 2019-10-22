#INCLUDE "TOPCONN.CH"
#Include "Protheus.Ch"
#Include "FONT.CH"
#include "rwmake.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ATUPEDV  ºAutor  ³TRADE               º Data ³  25.01.08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina para atualizar os pedidos de vendas referente       º±±
±±º          ³ contratos - reajuste de valores e datas de entrega         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CESVI                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ATUPEDV()

Local aSay			:= {}
Local aButton		:= {}
Local o				:= Nil
Local oWnd			:= Nil
Local nOpcao		:= 0
Local cDesc1		:= "Este programa ira atualizar os pedidos selecionados(Datas e Valores)"
Local cDesc2		:= "referente contratos sitem ORION"
Local aCpos			:= {}
Local aCampos		:= {}
Local aCores        := {}
Local aCampos1		:= {}

Private aRotina     := {}
Private cMarca	    := ""
Private cCadastro   := OemToAnsi("FATURAMENTO - Atualização de Ped.Vendas")
Private cPerg       := "ATPEDV"
Private _cCliente   := ""

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta tela de interacao com usuario											     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ValidPerg(cPerg)

aAdd(aSay,cDesc1)
aAdd(aSay,cDesc2)
pergunte(cPerg,.F.)
aADD(aButton, { 5,.T.,{|| Pergunte(cPerg,.t.) } } )
aAdd(aButton, { 1,.T.,{|o| nOpcao := 1,o:oWnd:End() } } )
aAdd(aButton, { 2,.T.,{|o| o:oWnd:End() }} )

FormBatch(cCadastro,aSay,aButton)
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Se cancelar sair																	                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If nOpcao <> 1
	Return Nil
Endif
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Atribui as variaveis de funcionalidades											          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd(aRotina ,{"Atualiza PV","U_AtuPed()"   ,0,1})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Atribui as variaveis os campos que aparecerao no mBrowse()						       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AADD(aCampos,{"OK"			,"",""					," "            })
AADD(aCampos,{"PEDIDO"	 	,"","Pedido"    		,"@!"           })  
AADD(aCampos,{"TIPO"	 	,"","Tipo" 		   		,"@!"           })  
AADD(aCampos,{"CLIENTE"	 	,"","Cliente"			,"@!"           })  
AADD(aCampos,{"LOJACLI"	 	,"","Loja"				,"@!"           })  
AADD(aCampos,{"NOMCLI"	 	,"","Nome"				,"@!"           })  
AADD(aCampos,{"CONDPAG"	 	,"","Cond.Pg"			,"@!"           })  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Monta o filtro especifico para MarkBrow()										             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cMarca := GetMark()

MsAguarde({|| _fSeleDados()},"Aguarde")

MarkBrow("TRB","OK",,aCampos,,_cMarca)


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Desfaz o indice e filtro temporario												 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
DbSelectArea("TRB")
dbCloseArea()

Return

/********************************************************************************************/
User Function AtuPed()

If !MsgYesno("Confirma atualização dos pedidos selecionados","P R O C E S S A")
	Return
Endif


//MONTA OS CAMPOS DO SC6
arquivo := {}
sx3->(dbseek("SC6"))
do while !sx3->(eof()) .and. sx3->x3_arquivo = "SC6"
   if sx3->x3_visual <> "V" .AND. sx3->x3_tipo <> "M" .AND. sx3->x3_context <> "V"
      IF  SX3->X3_TIPO == "C"
	      aadd(arquivo,{sx3->x3_campo,""})     
	  ELSEIF  SX3->X3_TIPO == "N"
	      aadd(arquivo,{sx3->x3_campo,0})     
	  ELSEIF  SX3->X3_TIPO == "D"
		  aadd(arquivo,{sx3->x3_campo,CTOD("  /  /  ")})     
	  ENDIF	  
   endif   
   sx3->(dbskip())
enddo  
	   
Dbselectarea("SC6")
Dbsetorder(1)

DbSelectArea("TRB")
DbGoTop()
While !Eof()

	If 	TRB->OK == _cMarca   
	
		IF  TRB->CONDPAG    == "D10"
		    DIA := MV_PAR06
		    NMES:= 0
		ELSEIF TRB->CONDPAG == "D20"
		    DIA := MV_PAR07
		    NMES:= 0
		ELSEIF TRB->CONDPAG == "D30"
		    DIA := MV_PAR08
		    NMES:= 0
		ENDIF    

	    Dbselectarea("SC6")
	    Dbseek(xfilial("SC6") + TRB->PEDIDO)
	    
	    While .not. eof() .and. ALLTRIM(SC6->C6_NUM)==ALLTRIM(TRB->PEDIDO)
	            
	            For i:=1 to fcount() //Pegar os campos do SC6
	                cVar := field(i) 
		            For L:=1 to len(arquivo)  //Carrega os conteudos do SC6 
		                IF   alltrim(arquivo[L,1]) == cVar
		                     arquivo[L,2] := SC6->&cVar
		                Endif
		            Next
		        Next
        
                cNUM      := SC6->C6_NUM
                cFILIAL   := SC6->C6_FILIAL
		        xUM       := SC6->C6_UM
		        xUltItem  := SC6->C6_ITEM
		        xUltData  := SC6->C6_ENTREG
		        
		        IF  MV_PAR09 > 0
		            NewPrcVen := MV_PAR09
		        ELSE    
			        NewPrcVen := INT(SC6->C6_PRCVEN+(SC6->C6_PRCVEN * MV_PAR05)/100)            
			    Endif
			        
                NewValor  := NewPrcVen * SC6->C6_QTDVEN
	        
		        IF  xUltData >= MV_PAR03 .AND. xUltData <= MV_PAR04
			        
			        //Atualiza as novas datas e valores
			        NewEntreg := CTOD("'"+STRZERO(DIA,2)+"/"+STRZERO((MONTH(SC6->C6_ENTREG)+NMES),2)+"/"+STR(YEAR(SC6->C6_ENTREG))+"'")
	                
	                Reclock("SC6",.F.)
	                Replace SC6->C6_PRCVEN  WITH NewPrcVen
	                Replace SC6->C6_ENTREG  WITH NewEntreg
	                Replace SC6->C6_VALOR   WITH NewValor
	                Replace SC6->C6_QTDENT  WITH 0
	                Replace SC6->C6_QTDEMP  WITH 0
	        	    Replace SC6->C6_NOTA    WITH ''
     			    Replace SC6->C6_SERIE   WITH ''
     			    Replace SC6->C6_CODISS  WITH ''
	    		    Replace SC6->C6_DATFAT  WITH CTOD('  /  /  ')
	                Msunlock()
		    	    
		    	Endif
		    	    
	    	    Dbselectarea("SC6")
	    	    Dbskip()
	    End
	    	    
   	    //INCREMENTA AS NOVAS DATAS
	    While xUltData <= MV_PAR04
	    
	 	    xUltItem := ALLTRIM(STRZERO((VAL(XULTITEM)+1),2))
		    XULTDATA := XULTDATA + 30
		    
		    xUltData := CTOD("'"+STRZERO(DIA,2)+"/"+STRZERO(MONTH(XULTDATA),2)+"/"+SUBSTR(ALLTRIM(STR(YEAR(XULTDATA))),3,2)+"'")

		    If  xUltData <= MV_PAR04
	    
			    Reclock("SC6",.T.)
			    
			    Replace C6_FILIAL       WITH cFILIAL
			    Replace C6_NUM          WITH cNUM
			    Replace C6_ITEM         WITH xUltItem
			    Replace C6_PRCVEN       WITH NewPrcVen
			    Replace C6_VALOR        WITH NewValor
			    Replace C6_ENTREG       WITH xUltData
			    Replace SC6->C6_UM      WITH XUM                                                                                                               
                Replace SC6->C6_QTDEMP  WITH 0
			    Replace SC6->C6_QTDENT  WITH 0                    
        	    Replace SC6->C6_NOTA    WITH ''
   			    Replace SC6->C6_SERIE   WITH ''
   			    Replace SC6->C6_CODISS  WITH ''
    		    Replace SC6->C6_DATFAT  WITH CTOD('  /  /  ')               
			    
			    For i:= 1 to len(arquivo)
			        IF   !alltrim(arquivo[i,1])$ "C6_ITEM/C6_PRCVEN/C6_VALOR/C6_ENTREG/C6_UM/C6_FILIAL/C6_NUM/C6_NOTA/C6_SERIE/C6_DATAFAT/C6_CODISS/C6_QTDENT/C6_QTDEMP"
					     replace &(arquivo[i,1]) with arquivo[i,2]
				    Endif
				Next
				
				Msunlock()
				
		    Endif

		End    
      	
	EndIF    
	
	Dbselectarea("TRB")
	
	Reclock("TRB",.F.)
	Dbdelete()
	Msunlock()
	
	Dbskip()
Enddo
Return

/********************************************************************************************/
Static Function _fSeledados()

_aStru := {}

aAdd(_aStru,{"OK"			,"C",02,0})
aAdd(_aStru,{"PEDIDO"		,"C",06,0})
aAdd(_aStru,{"TIPO"			,"C",01,0})
aAdd(_aStru,{"CLIENTE"		,"C",06,0})
aAdd(_aStru,{"LOJACLI"		,"C",02,0})
aAdd(_aStru,{"NOMCLI"		,"C",20,0})
aAdd(_aStru,{"CONDPAG"		,"C",03,0})

_cArq := CriaTrab(_aStru,.t.)
DbUseArea(.T.,,_cArq,"TRB",.T.,.F.)
_cInd := CriaTrab(,.f.)
IndRegua("TRB",_cInd,"PEDIDO+CLIENTE+LOJACLI",,,"Selecionando Dados")


cQuery := "SELECT C5_NUM,C5_CLIENTE,C5_LOJACLI,C5_EMISSAO,C5_TIPO,C5_CONDPAG,C5_NOTA, C5_SERIE, A1_NREDUZ "
cQuery += " FROM "+retsqlname("SC5")+" JOIN "+retsqlname("SA1")+" ON C5_CLIENTE = A1_COD AND C5_LOJACLI = A1_LOJA " 
cQuery += " WHERE C5_NUM >= '"+ MV_PAR01 +"' AND C5_NUM <= '"+MV_PAR02+"' "
cQuery += " AND "+retsqlname("SC5")+".D_E_L_E_T_ = ' ' AND "+retsqlname("SA1")+".D_E_L_E_T_ = ' '"
   
If  Select("TMP1") > 0
    DbSelectArea("TMP1")
    DbCloseArea()
Endif

TCQUERY cQuery NEW ALIAS "TMP1"

DbSelectArea("TMP1")
DBGOTOP()             
While .not. eof()
	MsProcTxt("Carregando Pedidos: "+ TMP1->C5_NUM)
   
    RECLOCK("TRB",.T.)
	TRB->OK := "" //_cMarca
	PEDIDO  := TMP1->C5_NUM
	TIPO    := TMP1->C5_TIPO
	CLIENTE := TMP1->C5_CLIENTE
	LOJACLI := TMP1->C5_LOJACLI
	NOMCLI  := TMP1->A1_NREDUZ
	CONDPAG := TMP1->C5_CONDPAG
	MSUNLOCK()
	DbSelectArea("TMP1")
	DbSkip()
Enddo
DbSelectArea("TMP1")
Dbclosearea()

/*
Dbselectarea("SC5")
Dbsetorder(1)
While .not. eof()
	MsProcTxt("Carregando Pedidos: "+ SC5->C5_NUM)
   
    RECLOCK("TRB",.T.)
	TRB->OK := "" //_cMarca
	PEDIDO  := SC5->C5_NUM
	TIPO    := SC5->C5_TIPO
	CLIENTE := SC5->C5_CLIENTE
	LOJACLI := SC5->C5_LOJACLI
	NOMCLI  := " " //SC5->A1_NREDUZ
 //	EMISSAO := SC5->C5_EMISSAO
	CONDPAG := SC5->C5_CONDPAG
	MSUNLOCK()
	DbSelectArea("SC5")
	DbSkip()
Enddo
*/
DbSelectArea("TRB")
dbgotop()
Return Nil
/********************************************************************************************/

/********************************************************************************************/
Static Function ValidPerg

_sAlias := Alias()
dbSelectArea("SX1")
dbSetOrder(1)
cPerg        := PADR(cPerg,len(sx1->x1_grupo))
aRegs :={}

//X1_GRUPO	X1_ORDEM	X1_PERGUNT	X1_PERSPA	X1_PERENG	X1_VARIAVL	X1_TIPO	X1_TAMANHO	X1_DECIMAL	X1_PRESEL	X1_GSC	X1_VALID	X1_VAR01	X1_DEF01	X1_DEFSPA1	X1_DEFENG1	X1_CNT01	X1_VAR02	X1_DEF02	X1_DEFSPA2	X1_DEFENG2	X1_CNT02	X1_VAR03	X1_DEF03	X1_DEFSPA3	X1_DEFENG3	X1_CNT03	X1_VAR04	X1_DEF04	X1_DEFSPA4	X1_DEFENG4	X1_CNT04	X1_VAR05	X1_DEF05	X1_DEFSPA5	X1_DEFENG5	X1_CNT05	X1_F3	X1_PYME	X1_GRPSXG	X1_HELP
aAdd(aRegs,{cPerg,	'01',	'Pedido De                     ',	'Pedido De                    ?',	'Pedido De                    ?',	'mv_ch1',	'C',06, 0,	0,	'G',	'',	'mv_par01',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})
aAdd(aRegs,{cPerg,	'02',	'Pedido Ate                    ',	'Pedido Ate                   ?',	'Pedido Ate                   ?',	'mv_ch2',	'C',06, 0,	0,	'G',	'',	'mv_par02',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})
aAdd(aRegs,{cPerg,	'03',	'Data De                       ',	'Data De                      ?',	'Data De                      ?',	'mv_ch3',	'D',08, 0,	0,	'G',	'',	'mv_par03',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})
aAdd(aRegs,{cPerg,	'04',	'Data Ate                      ',	'Data Ate                     ?',	'Data Ate                     ?',	'mv_ch4',	'D',08, 0,	0,	'G',	'',	'mv_par04',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})
aAdd(aRegs,{cPerg,	'05',	'Reajuste(%)                   ',	'Reajuste                     ?',	'Reajuste                     ?',	'mv_ch5',	'N',05, 2,	0,	'C',	'',	'mv_par05',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})
aAdd(aRegs,{cPerg,	'06',	'Entrega(D10)                  ',	'Entrega(D10)                 ?',	'Entrega(D10)                 ?',	'mv_ch6',	'N',02, 0,	0,	'G',	'',	'mv_par06',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})                                                                                                                                                   
aAdd(aRegs,{cPerg,	'07',	'Entrega(D20)                  ',	'Entrega(D20)                 ?',	'Entrega(D20)                 ?',	'mv_ch7',	'N',02, 0,	0,	'G',	'',	'mv_par07',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''}) 
aAdd(aRegs,{cPerg,	'08',	'Entrega(D30)                  ',	'Entrega(D30)                 ?',	'Entrega(D30)                 ?',	'mv_ch8',	'N',02, 0,	0,	'G',	'',	'mv_par08',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})
aAdd(aRegs,{cPerg,	'09',	'Valor Fixo                    ',	'Valor Fixo                   ?',	'Valor Fixo                   ?',	'mv_ch9',	'N',12, 2,	0,	'C',	'',	'mv_par09',	'       ',	'       ',	'       ',	'',	'',	'              ',	'              ',	'              ',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	'',	''})
For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])			
			Endif
		Next
		MsUnlock()
	Endif
Next
dbSelectArea(_sAlias)
Return
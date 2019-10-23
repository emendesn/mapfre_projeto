#INCLUDE "Eicpo557.ch"
#include "rwmake.ch"
#INCLUDE "avprint.ch"
#INCLUDE "font.ch"

#DEFINE DATA_ATUAL  UPPER(CMONTH(dDataAtu))+", "+;
STRZERO(DAY(dDataAtu),2)+", "+;
STR(YEAR(dDataAtu),4)

User Function RELORC5()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de variaveis utilizadas no programa atraves da funcao    ³
//³ SetPrvt, que criara somente as variaveis definidas pelo usuario,    ³
//³ identificando as variaveis publicas do sistema utilizadas no codigo ³
//³ Incluido pelo assistente de conversao do AP5 IDE                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetPrvt("UVAR>,OPRINT>,OFONT>,ACLOSE,CALIASOLD,NOLDAREA,ccnum")
SetPrvt("TB_CAMPOS,_PICTPO,_PICTPRTOT,_PICTPRUN,_PICTQTDE,_PICTITEM")
SetPrvt("CCADASTRO,CMARCA,LINVERTE,NUSADO,CARQF3SW2,CARQF3SYT")
SetPrvt("CARQF3SY4,CARQF3SYQ,CCAMPOF3SW2,CCAMPOF3SYT,CCAMPOF3SY4,CCAMPOF3SYQ")
SetPrvt("TPO_NUM,TIMPORT,TCONDPG,TDIASPG,TAGENTE,TTIPO_EMB,nprod1")
SetPrvt("TNR_PRO,TID_PRO,TDT_PRO,TPAIS,NSPREAD,MTOTAL,nvar1,VAR1")
SetPrvt("AMSG,CPOINTS,ACAMPOS,AHEADER,STRUCT1,FILEWORK,vlrtot")
SetPrvt("PAGINA,ODLG,OFNTDLG,NLIN,NCOLS1,NCOLG1,aarray,maarray")
SetPrvt("NCOLS2,NCOLG2,NCOLS3,NCOLG3,NCOLG4,NCOLS4,nvar2,var2")
SetPrvt("NCOLS5,MFLAG,V,NOPCAO,BOK,BCANCEL,novval,nvar4,var4")
SetPrvt("BINIT,CALIAS,NTIPOIMP,ARAD1,OMARK,NNETWEIGHT")
SetPrvt("ktext,vvalor,vvitem,vvalor,vvitem,taarray")
SetPrvt("MDESCRI,I,AVETOR,W,CENDSA2,LCOMISSAORETIDA")
SetPrvt("NVAL_COM,CNOMEBANCO,CPAYMENT,CEXPORTA,CFORN,DDATAATU")
SetPrvt("DDATASHIP,NLI_INI,NLI_FIM,NLI_FIM2,AFONTES,PARTE2")
SetPrvt("M->DIA_EXT,datacheia,LTEXT,LINHA")
SetPrvt("NLINHA,LBATEBOX,NLINPAY,INTLINHA,")


#COMMAND E_RESET_AREA                      => SA5->(DBSETORDER(1)) ;
;  Work->(E_EraseArq(FileWork)) ;
;  DBSELECTAREA(nOldArea)

#xtranslate :TIMES_NEW_ROMAN_10            => \[2\]
#xtranslate :TIMES_NEW_ROMAN_12            => \[2\]
#xtranslate :TIMES_NEW_ROMAN_14_BOLD       => \[2\]

#xtranslate   bSETGET(<uVar>)              => {|u| If(PCount() == 0, <uVar>, <uVar> := u) }

#xtranslate   AVPict(<Cpo>)                => AllTrim(X3Picture(<Cpo>))


/*
___________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Funçao    ¦ EICPO557 ¦ Autor ¦ ANTONIO S. PEREIRA    ¦ Data ¦ 26.10.96 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descrição ¦ Emissão da ORCAMENTO DE VENDAS                           ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Sintaxe   ¦ #ORCAMENTO                                                 ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
*/

nNetWeight := 0
mDescri    := ""
I          := 0
aVetor     := {}
W          := 0
cEndSA2    := ""
lComissaoRetida:=.F.
nVal_Com   := SW2->W2_VAL_COM
cNomeBanco := ""
PAGINA := 0
ccnum  := 0
vlrtot := 0

AVPRINT oPrn NAME "Orçamento de Vendas"
oPrn:Rebuild()

DEFINE FONT oFont1  NAME "Times New Roman"    SIZE 0,11  BOLD     OF oPrn
DEFINE FONT oFont2  NAME "Times New Roman"    SIZE 0,11  BOLD     OF oPrn

aFontes := { oFont1, oFont2 }

AVPAGE                

PO557CAB_INI()

nLi_Ini:=nLinha

PO557_CAB2()
nprod1 := space(6)
ccnum := 1
AARRAY := {}
J := 1
DbSelectArea('SCJ')
DbSetOrder(01)
nprod1 := scj->cj_num
DbSelectArea('SCK')
DbSetOrder(01)
DbGotop()
DBSEEK(XFILIAL("SCJ") + SCJ->CJ_NUM , .T.)
While !eof() .AND. sck->ck_num == SCJ->CJ_NUM
	if !empty(sck->ck_entreg)
		aadd(aarray,{sck->ck_item,alltrim(str(sck->ck_entreg - scj->cj_emissao))})
	endif
	DbSelectArea('SCK')
	dbskip()
enddo

maarray := asort(aarray,,, { |x, y| x[2] < y[2]})

// We want 75 cols
DbSelectArea('SCJ')
DbSetOrder(01)

While !Eof() .AND. SCJ->CJ_NUM = NPROD1
	if ccnum = 1
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		oPrn:Say( nLinha:=nLinha+20,150  ,"Proposta nº " + nprod1 ,aFontes:TIMES_NEW_ROMAN_10)
		oPrn:Say( nLinha:=nLinha+40,150  ,'Vendedor : '+ scj->cj_vend1 ,aFontes:TIMES_NEW_ROMAN_10)
		oPrn:Line( nLinha:=nLinha+60, 110, nLinha  , 2240 )
		M->DIA_EXT := ' '
		M->DIA_EXT := "São Paulo , " + Str(Day(SCJ->CJ_EMISSAO),2) + " DE " + Upper(MesExtenso(Month(SCJ->CJ_EMISSAO))) + " DE " +Str(Year(SCJ->CJ_EMISSAO),4)
		oPrn:Say( nLinha:=nLinha+90,150  ,ALLTRIM(M->DIA_EXT) ,aFontes:TIMES_NEW_ROMAN_10)
		DbSelectArea('Sa1')
		DbSetOrder(01)
		DbGoTop()
		dbseek(xfilial("SA1") + scj->cj_cliente + scj->cj_loja)
		if scj->cj_licit <> 'S'                 && Caso nÆo seja licitacao
			if empty(scj->cj_endcpl)
				oPrn:Say( nLinha:=nLinha+110,150  ,'Para : '+ OemtoAnsi(ALLTRIM(sa1->a1_nome)) ,aFontes:TIMES_NEW_ROMAN_10 )
				oPrn:Say( nLinha:=nLinha+60,150  ,'Endereço : ' + ALLTRIM(sa1->a1_end) ,aFontes:TIMES_NEW_ROMAN_10 )
				oPrn:Say( nLinha:=nLinha+60,150  ,alltrim(sa1->a1_mun) +'    ' + sa1->a1_est ,aFontes:TIMES_NEW_ROMAN_10)
				if !empty(scj->cj_acui)
					oPrn:Say( nLinha:=nLinha+70,150  ,'A/C    '+ OemtoAnsi(ALLTRIM(scj->cj_acui)) ,aFontes:TIMES_NEW_ROMAN_10)
				endif
				if !empty(scj->cj_setor)
					oPrn:Say( nLinha:=nLinha+60,150  ,'Setor : '+ OemtoAnsi(ALLTRIM(scj->cj_setor)) ,aFontes:TIMES_NEW_ROMAN_10)
				endif
			else
				oPrn:Say( nLinha:=nLinha+110,150  ,'Para : '+ OemtoAnsi(ALLTRIM(sa1->a1_nome)) ,aFontes:TIMES_NEW_ROMAN_10)
				oPrn:Say( nLinha:=nLinha+60,150  ,'Endereço : ' + ALLTRIM(sa1->a1_end) ,aFontes:TIMES_NEW_ROMAN_10)
				oPrn:Say( nLinha:=nLinha+60,150  ,ALLTRIM(scj->cj_endcpl) ,aFontes:TIMES_NEW_ROMAN_10)
				oPrn:Say( nLinha:=nLinha+60,150  ,alltrim(sa1->a1_mun) +'    ' + sa1->a1_est ,aFontes:TIMES_NEW_ROMAN_10)
				if !empty(scj->cj_acui)
					oPrn:Say( nLinha:=nLinha+60,150  ,'A/C    '+ OemtoAnsi(alltrim(scj->cj_acui)) ,aFontes:TIMES_NEW_ROMAN_10,,,,1 )
				endif
				if !empty(scj->cj_setor)
					oPrn:Say( nLinha:=nLinha+60,150  ,'Setor : '+ OemtoAnsi(alltrim(scj->cj_setor)) ,aFontes:TIMES_NEW_ROMAN_10,,,,1 )
				endif
			endif
		ELSE
			ltext := {}                          && caso seja licitacao segue a digitacao da operadora
			linha := 0
			linha := MLCOUNT(scj->cj_endlic,85)
			FOR j:= 1 TO linha
				Aadd(ltext,{MemoLine(scj->cj_endlic,85,j)})
			NEXT
			oPrn:Say( nLinha:=nLinha+110,150  ,'',aFontes:TIMES_NEW_ROMAN_10)
			for j := 1 to linha
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+40 , 150 ,ALLTRIM(ltext[j][1]),aFontes:TIMES_NEW_ROMAN_10 )
				PARTE2:=1
				PO557VERFIM()
			next
		endif
		ltext := {}
		linha := 0
		IF !EMPTY(scj->cj_cabec)
			linha := MLCOUNT(scj->cj_cabec,85)
			FOR j:= 1 TO linha
				Aadd(ltext,{MemoLine(scj->cj_cabec,85,j)})
			NEXT
			oPrn:Say( nLinha:=nLinha+110,150  ,'',aFontes:TIMES_NEW_ROMAN_10)
			for j := 1 to linha
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+45 , 150 ,ALLTRIM(ltext[j][1]),aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
			next
		ENDIF
		CCNUM := CCNUM +1
	ENDIF
	oPrn:Say( nLinha:=nLinha+110,150  ,'',aFontes:TIMES_NEW_ROMAN_10)
	DbSelectArea('SCK')
	DbSetOrder(01)
	DbGotop()
	DBSEEK(XFILIAL("SCK") + NPROD1 , .T.)
	While !eof() .AND. sck->ck_num = nprod1
	    if scj->cj_licit = 'S'                  && Caso nÆo seja licitacao
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
			oPrn:Say( nLinha:=nLinha+90 , 150 ,OemtoAnsi(sck->ck_deslic),aFontes:TIMES_NEW_ROMAN_10 )
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
			oPrn:Say( nLinha:=nLinha+40 , 150 ,sck->ck_produto +' - '+OemtoAnsi(sck->ck_descri),aFontes:TIMES_NEW_ROMAN_10 )
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
			oPrn:Say( nLinha:=nLinha+40 , 150 ,'Quantidade : '+ alltrim(str(sck->ck_qtdven)),aFontes:TIMES_NEW_ROMAN_10 )
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
		else
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
			oPrn:Say( nLinha:=nLinha+90 , 150 ,'Item : '+ sck->ck_item,aFontes:TIMES_NEW_ROMAN_10 )
			oPrn:Say( nLinha , 800 ,'Produto :  '+ OemtoAnsi(sck->ck_descri),aFontes:TIMES_NEW_ROMAN_10 )
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
			oPrn:Say( nLinha:=nLinha+40 , 150 ,'Código :'+ sck->ck_produto,aFontes:TIMES_NEW_ROMAN_10 )
			oPrn:Say( nLinha, 800 ,'Quantidade : '+ alltrim(str(sck->ck_qtdven)),aFontes:TIMES_NEW_ROMAN_10 )
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
		endif
		/* a descricao detalhada do produto */
		
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		if scj->cj_licit = 'S'                  && Caso nÆo seja licitacao
			ltext := {}
			linha :=0
			linha := MLCOUNT(sck->ck_ddetlic,85)
			FOR j:=1 TO linha
				Aadd(ltext,{MemoLine(sck->ck_ddetlic,85,j)})
			NEXT
			
			for j := 1 to len(ltext)
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+40 , 150 ,ALLTRIM(ltext[j][1]),aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
			next
		else
			ltext := {}
			linha :=0
			linha := MLCOUNT(sck->ck_descdet,85)
			FOR j:=1 TO linha
				Aadd(ltext,{MemoLine(sck->ck_descdet,85,j)})
			NEXT
			for j := 1 to len(ltext)
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+50 , 150 ,ALLTRIM(ltext[j][1]),aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
			next
		endif
		nvar1 := ' '
		nvar1 := strtran(alltrim(str( noround(sck->ck_valunfn,11,2) )),'.',',')
		if scj->cj_impdir = 'S' .or. scj->cj_moeda = 2
			if sck->ck_valunto > 0
				novval := 0
				novval := noround(( sck->ck_valunto / sck->ck_qtdven  ),2)
				nvar1 := ' '
				nvar1 := strtran(alltrim(str(novval,11,2)),'.',',')
				var1 := '   '
				//var1 := Extenso ( novval ,.F.,2 )
				VAR1 := EXT(novval,100,"Dolar","Dolares")  //gera valor extenso
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Preço Unitário : ' + 'US$ '+ nvar1,aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
    			PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+VAR1+' )',aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
			ELSE
				var1 := '   '
				//var1 := Extenso ( noround(sck->ck_valunfn,2) ,.f.,2)
				VAR1 := EXT(noround(sck->ck_valunfn,2),100,"Dolar","Dolares")  //gera valor extenso
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Preço Unitário : ' + 'US$ '+ nvar1,aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+VAR1+' )',aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
			ENDIF
		ELSE
			if sck->ck_valunto > 0
				novval := 0
				novval := noround(( sck->ck_valunto / sck->ck_qtdven  ),2)
				nvar1 := ' '
				nvar1 := strtran(alltrim(str(novval,11,2)),'.',',')
				var1 := '  '    
				var1 := EXT(novval,100,"Real","Reais")
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Preço Unitário : ' + 'R$ '+ nvar1,aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+VAR1+' )',aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
			else
				nvar1 := ' '
				nvar1 := strtran(alltrim(str(  noround(sck->ck_valunfn,2),11,2 )),'.',',')
				var1 := '  ' 
				var1 := EXT(sck->ck_valunfn,100,"Real","Reais")
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Preço Unitário : ' + 'R$ '+ nvar1,aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+VAR1+' )',aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
			endif
		ENDIF
		if sck->ck_ipi > 0
			oPrn:Line( nLinha:=nLinha+90, 110, nLinha  , 2240 )
		endif
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		//oPrn:Say( nLinha:=nLinha+40 , 150 ,ALLTRIM(STR(sck->ck_prcven,14,2)),aFontes:TIMES_NEW_ROMAN_10 )
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		if scj->cj_impdir = 'S'.or. scj->cj_moeda = 2
			if sck->ck_valunto > 0
				vlrtot := vlrtot + sck->ck_valunto
				nvar2 := ' '
				nvar2 := strtran(alltrim(str(sck->ck_valunto,11,2)),'.',',')
				var2 := '   '
				VAR2 := EXT(noround(sck->ck_valunto,2),100,"Dolar","Dolares")  //gera valor extenso
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Valor Total : '+ 'US$ '+ nvar2,aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
                PO557VERFIM()
			ELSE
				vlrtot := vlrtot + noround(sck->ck_valtofn,2)
				nvar2 := ' '
				nvar2 := strtran(alltrim(str( noround(sck->ck_valtofn,2),11,2 )),'.',',')
				var2 := '   '
				VAR2 := EXT(noround(sck->ck_valtofn,2),100,"Dolar","Dolares")  //gera valor extenso
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Valor Total : '+ 'US$ '+ nvar2,aFontes:TIMES_NEW_ROMAN_10 )
				SysRefresh()
				PARTE2:=1
                PO557VERFIM()
			ENDIF
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
			oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+VAR2+' )',aFontes:TIMES_NEW_ROMAN_10 )
		ELSE
			if sck->ck_valunto > 0
				nvar2 := ' '
				nvar2 := strtran(alltrim(str(sck->ck_valunto,11,2)),'.',',')
				vlrtot := vlrtot + sck->ck_valunto
				var2 := '   '        
				var2 := EXT(sck->ck_valunto,100,"Real","Reais")
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Valor Total : '+ 'R$ '+ nvar2,aFontes:TIMES_NEW_ROMAN_10 )
			else
				nvar2 := ' '
				nvar2 := strtran(alltrim(str( noround(sck->ck_valtofn,2),11,2 )),'.',',')
				vlrtot := vlrtot + noround(sck->ck_valtofn,2)
				var2 := '   '  
				var2 := EXT(sck->ck_valtofn,100,"Real","Reais")
				SysRefresh()
				PARTE2:=1
				PO557VERFIM()
				oPrn:Say( nLinha:=nLinha+90 , 150 ,'Valor Total : '+ 'R$ '+ nvar2,aFontes:TIMES_NEW_ROMAN_10 )
			endif
			oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+VAR2+' )',aFontes:TIMES_NEW_ROMAN_10 )
		endif
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		oPrn:Line( nLinha:=nLinha+90, 110, nLinha  , 2240 )
		PARTE2:=1
		PO557VERFIM()
		
		DbSelectArea('SCK')
		DbSetOrder(01)
		dbskip()
		
	enddo
	
	DbSelectArea('scj')
	dbskip()
enddo

DbSelectArea('SCJ')
DbSetOrder(01)
DBGOTOP()
DBSEEK(XFILIAL("SCJ") + NPROD1)
if scj->cj_impdir = 'S'.or. scj->cj_moeda = 2
	nvar4 := ' '
	nvar4 := strtran(alltrim(str(vlrtot,11,2)),'.',',')
	var4  := '  '
	VAR4 := EXT(vlrtot,100,"Dolar","Dolares")  //gera valor extenso
	DbSelectArea('SCJ')
	DbSetOrder(01)
	DbGotop()
	dbseek(xfilial("SCJ") + NPROD1)
    PO557VERFIM()
	oPrn:Say( nLinha:=nLinha+90 , 150 ,'Valor Total da Proposta : '+ 'US$ '+ nvar4,aFontes:TIMES_NEW_ROMAN_10 )
    PO557VERFIM()
	SysRefresh()
	PARTE2:=1
	PO557VERFIM()
	oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+var4+' )',aFontes:TIMES_NEW_ROMAN_10 )
    PO557VERFIM()
else
	nvar4 := ' '
	nvar4 := strtran(alltrim(str(vlrtot,11,2)),'.',',')
	var4  := '  '  
	var4 := EXT(vlrtot,100,"Real","Reais")
	DbSelectArea('SCJ')
	DbSetOrder(01)
	DbGotop()
	dbseek(xfilial("SCJ") + NPROD1)
    PO557VERFIM()
	oPrn:Say( nLinha:=nLinha+90 , 150 ,'Valor Total da Proposta : '+ 'R$ '+ nvar4,aFontes:TIMES_NEW_ROMAN_10 )
    PO557VERFIM()
	SysRefresh()
	PARTE2:=1
	PO557VERFIM()
	oPrn:Say( nLinha:=nLinha+60 , 150 ,'( '+var4+' )',aFontes:TIMES_NEW_ROMAN_10 )
    PO557VERFIM()
endif
PO557VERFIM()
oPrn:Say( nLinha:=nLinha+90 , 150 ,'Condições Gerais de Fornecimento ',aFontes:TIMES_NEW_ROMAN_10 )
PO557VERFIM()
oPrn:Line( nLinha:=nLinha+60, 110, nLinha  , 2240 )
PO557VERFIM()
if !empty(maarray)
	if len(maarray) > 1
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		oPrn:Say( nLinha:=nLinha+60 , 150 ,'Prazo de Entrega : ',aFontes:TIMES_NEW_ROMAN_10 )
        PO557VERFIM()
		for j := 1 to len(maarray)
			ktext  := ''
			vvalor := ' '
			vvitem := ' '
			vvalor := maarray[j][02]
			vvitem := alltrim(maarray[j][01])
			taarray := {}
			while maarray[j][02] = vvalor
				aadd(taarray,{maarray[j][01],maarray[j][02]})
				if (j + 1 ) > len(maarray)
					exit
				else
					if maarray[j+1][02] <> vvalor
						exit
					else
						j++
					endif
				endif
			enddo
			asort(taarray,,, { |x, y| x[1] < y[1]})
			
			FOR k := 1 TO len(taarray)
				ktext := ktext + taarray[k][01] + ' | '
			NEXT
			
			SysRefresh()
			PARTE2:=1
			PO557VERFIM()
			oPrn:Say( nLinha:=nLinha+60 , 150 ,'Item(s) :  ' + ktext +' :   ' +vvalor + '  Dias ',aFontes:TIMES_NEW_ROMAN_10 )
            PO557VERFIM()
		next
	else
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		oPrn:Say( nLinha:=nLinha+60 , 150 ,'Prazo de Entrega : ',aFontes:TIMES_NEW_ROMAN_10 )
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		oPrn:Say( nLinha:=nLinha+60 , 150 ,'Item : ' + maarray[1][01] +' : ' +maarray[1][02] + '  Dias ',aFontes:TIMES_NEW_ROMAN_10 )
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
	endif
endif

SysRefresh()
PARTE2:=1
PO557VERFIM()
oPrn:Say( nLinha:=nLinha+70 , 150 ,'Validade da Proposta :  '+ALLTRIM(STR(scj->cj_przval))+ '   Dias' ,aFontes:TIMES_NEW_ROMAN_10 )
PO557VERFIM()
ltext := {}
linha := 0
linha := MLCOUNT(scj->cj_complvl,85)
FOR j:= 1 TO linha
	Aadd(ltext,{MemoLine(scj->cj_complvl,85,j)})
NEXT
IF !EMPTY(LTEXT)
	for j := 1 to linha
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		oPrn:Say( nLinha:=nLinha+40 , 150 ,ltext[j][1],aFontes:TIMES_NEW_ROMAN_10 )
	next
ENDIF
DbSelectArea('Se4')
DbSetOrder(01)
DbGoTop()
dbseek(xfilial("SE4") + scj->cj_condpag)                && pesquisa condi‡Æo de pagamento
oPrn:Say( nLinha:=nLinha+60 , 150 ,'Condição de Pagamento : '+ se4->e4_descri,aFontes:TIMES_NEW_ROMAN_10 )
ltext := {}
linha := 0
linha := MLCOUNT(scj->cj_cplcdpg,85)
FOR j:= 1 TO linha
	Aadd(ltext,{MemoLine(scj->cj_cplcdpg,85,j)})
NEXT

IF !EMPTY(ltext)
	for j := 1 to linha
		SysRefresh()
		PARTE2:=1
		PO557VERFIM()
		oPrn:Say( nLinha:=nLinha+40 , 150 ,ltext[j][1],aFontes:TIMES_NEW_ROMAN_10 )
	next
ELSE
ENDIF
/* texto do rodape */

ltext := {}
linha := 0
linha := MLCOUNT(scj->cj_rodape,85)
FOR j := 1 TO linha
	Aadd(ltext,{MemoLine(scj->cj_rodape,85,j)})
NEXT
for j := 1 to linha
	SysRefresh()
	PARTE2:=1
	PO557VERFIM()
	oPrn:Say( nLinha:=nLinha+40 , 150 ,ltext[j][1],aFontes:TIMES_NEW_ROMAN_10 )
next


AVENDPAGE

AVENDPRINT

oFont1:End()
oFont2:End()

RETURN NIL

*------------------------------*
Static FUNCTION PO557VERFIM()
*------------------------------*
lBateBox:=IF(lBateBox=NIL,.T.,.F.)
SysRefresh()
IF nLinha >= 2800
	IF PARTE2 > 0
		IF PARTE2 == 1
			nLi_Fim2:=nLinha
		ELSE
			nLi_Fim2:=(nLinha+50)
			nLi_Fim:=0
		ENDIF
		PO557FIM()
	ENDIF
	
	SysRefresh()
	AVNEWPAGE
	
	PO557CAB_INI()
	
	IF PARTE2 > 0
		nLi_Fim:=nLi_Fim2:=nLi_Ini:=nLinha
		PO557_CAB2()
	ENDIF
	RETURN .T.
ENDIF
RETURN .F.

*----------------------------*
Static FUNCTION PO557_CAB2()
*----------------------------*
SysRefresh()
RETURN NIL

*--------------------------*
Static FUNCTION PO557FIM()
*--------------------------*
RETURN NIL

*----------------------------*
Static FUNCTION PO557CAB_INI()
*----------------------------*
nLinha:=40
Pagina:=Pagina+1

if file("\sigaadv\mslogo.bmp")
   alert("achei")
endif   
oSend( oPrn, "SayBitmap",NLinha,110, "\sigaadv\mslogo.BMP", 567,190)
oSend( oPrn, "SayBitmap",NLinha,1850, "\sigaadv\logoiso.BMP", 254,280)

oPrn:Line( nLinha:=nLinha+260, 110, nLinha  , 2240 )

oPrn:Say( nLinha:=nLinha+60, 1800,"CGC: 49.520.521/0001-69",aFontes:TIMES_NEW_ROMAN_10 )
oPrn:Say( nLinha:=nLinha+60, 1800,"Ins. : 110.663.323.118", aFontes:TIMES_NEW_ROMAN_10 )

nLinha:=nLinha+90
//oSend( oPrn, "Say",  2900 ,1900, "pagina "+STR(PAGINA,8),aFontes:TIMES_NEW_ROMAN_10 ) //"Page.:"
oPrn:Line( 3000,110,3000, 2240 )
oPrn:Say( 3060, 110,"Intermed Equip. Médico Hosp. Ltda.",aFontes:TIMES_NEW_ROMAN_14_BOLD )
oPrn:Say( 3120, 110,"Av. Cupecê, 1786 Cep-04366-000 - Tel. (011)5670-1309 - Fax (011)5562-5461 - SãoPaulo - www.intermedbr.com",aFontes:TIMES_NEW_ROMAN_10 )


RETURN NIL

Static FUNCTION EXT(valor,larg,sing,plur)
LOCAL unidades:={"um","dois","tres","quatro","cinco","seis","sete","oito","nove"},;
      unidonze:={"onze","doze","treze","quatorze","quinze","dezesseis",;
                 "dezessete","dezoito","dezenove"},;
      decimais:={"","vinte","trinta","quarenta","cinquenta","sessenta","setenta",;
                 "oitenta","noventa"},;
      centos:={"cento","duzentos","trezentos","quatrocentos","quinhentos","seiscentos",;
               "setecentos","oitocentos","novecentos"},;
      vEXTENSO:="", cnum:=LEFT(STR(valor,12,2),9), volta:="", calex:="", compri:=0, cents:="", vez:=0, rest:=""

* cheques Milhoes
IF SUBSTR(cnum,1,1)>"0"
    vEXTENSO=centos[VAL(SUBSTR(cnum,1,1))]
ENDIF
IF vEXTENSO > " "
    IF SUBSTR(cnum,2,2) <> "00"
        vEXTENSO = vEXTENSO + " e "
    ENDIF
ENDIF

*
DO CASE
    CASE SUBSTR(cnum,2,1)>"1"
        vEXTENSO=vEXTENSO+decimais[VAL(SUBSTR(cnum,2,1))]
        IF vEXTENSO > " "
            IF SUBSTR(cnum,3,1) <> "0"
                vEXTENSO = vEXTENSO + " e "
            ENDIF
        ENDIF
        IF SUBSTR(cnum,3,1)>"0"
            vEXTENSO=vEXTENSO+unidades[VAL(SUBSTR(cnum,3,1))]
        ENDIF
        vEXTENSO=vEXTENSO+" milhoes"
                                 
    CASE SUBSTR(cnum,2,1)="1"
       	vEXTENSO=vEXTENSO+unidonze[VAL(SUBSTR(cnum,3,1))]+" milhoes"
                       
    CASE SUBSTR(cnum,2,2)="00"
     	vEXTENSO=SUBSTR(vEXTENSO,1,LEN(vEXTENSO)) + " milhoes"
        IF SUBSTR(cnum,1,1)="1"
            vEXTENSO = "cem milhoes"
        ENDIF
                            
    CASE SUBSTR(cnum,3,1)>" "
        vEXTENSO=vEXTENSO+unidades[VAL(SUBSTR(cnum,3,1))]+" milhoes"
                             
ENDCASE
IF vEXTENSO = "um milhoes"
    vEXTENSO = "um milhao"
ENDIF
IF SUBSTR(cnum,4,6) = "000000"
    vEXTENSO = vEXTENSO+" de"
ENDIF	                           
                          
* cheques de Centenas e Milhares
                                
IF vEXTENSO > " "
    IF SUBSTR(cnum,4,3) <> "000"
        vEXTENSO = vEXTENSO+", "
    ENDIF
ENDIF
	               	
IF SUBSTR(cnum,4,1)>" "
    IF SUBSTR(cnum,4,1)<>"0"
        vEXTENSO=vEXTENSO+centos[VAL(SUBSTR(cnum,4,1))]	
    ENDIF
ENDIF
IF vEXTENSO > " "
    IF SUBSTR(cnum,5,2) <> "00"
        IF RIGHT(vEXTENSO,2) = ", "
          vEXTENSO = SUBSTR(vEXTENSO,1,LEN(vEXTENSO)-2) + " e "
        ELSE
          vEXTENSO = RTRIM(vEXTENSO) + " e "
        ENDIF
    ENDIF
ENDIF

*
DO CASE
                
    CASE SUBSTR(cnum,5,1)>"1"
        vEXTENSO=vEXTENSO+decimais[VAL(SUBSTR(cnum,5,1))]
        IF vEXTENSO > " "
            IF SUBSTR(cnum,6,1) <> "0"
                vEXTENSO = vEXTENSO + " e "
            ENDIF
       	ENDIF
       	IF SUBSTR(cnum,6,1)>"0"
            vEXTENSO=vEXTENSO+unidades[VAL(SUBSTR(cnum,6,1))]
       	ENDIF
       	vEXTENSO=vEXTENSO+" mil"

    CASE SUBSTR(cnum,5,1)="1"
        IF SUBSTR(cnum,6,1)<>"0"
            vEXTENSO=vEXTENSO+unidonze[VAL(SUBSTR(cnum,6,1))]+" mil"
        ELSE
            vEXTENSO=vEXTENSO+"dez mil"
        ENDIF

    CASE SUBSTR(cnum,5,2)="00"
	IF RIGHT(vEXTENSO,2) <> "de"
            IF SUBSTR(cnum,4,3) <> "000"
             vEXTENSO=SUBSTR(vEXTENSO,1,LEN(vEXTENSO)) + " mil"
            ENDIF
       	    IF SUBSTR(cnum,4,1)="1"
                vEXTENSO = LEFT(vEXTENSO,LEN(vEXTENSO)-9)+"cem mil"
	    ENDIF
	ENDIF

    CASE SUBSTR(cnum,6,1)>" "
        vEXTENSO=vEXTENSO+unidades[VAL(SUBSTR(cnum,6,1))]+" mil"

ENDCASE

* cheques Centenas
IF vEXTENSO > " "
    IF SUBSTR(cnum,7,3) <> "000"
        vEXTENSO = vEXTENSO + ", "
    ENDIF
ENDIF
IF SUBSTR(cnum,7,1)>"0"
    vEXTENSO=vEXTENSO+centos[VAL(SUBSTR(cnum,7,1))]
ENDIF

IF SUBSTR(cnum,7,3) = "100"
    vEXTENSO = SUBSTR(vEXTENSO,1,LEN(vEXTENSO)-5) + "cem"
ENDIF

* cheques dezenas e unidades

IF vEXTENSO > " "
    IF SUBSTR(cnum,8,2) <> "00"
        IF RIGHT(vEXTENSO,2)=", "
          vEXTENSO = SUBSTR(vEXTENSO,1,LEN(vEXTENSO)-2) + " e "
        ELSE
          vEXTENSO = RTRIM(vEXTENSO) + " e "
        ENDIF
    ENDIF
ENDIF
DO CASE
    CASE SUBSTR(cnum,8,1)>"1"
        vEXTENSO=vEXTENSO+decimais[VAL(SUBSTR(cnum,8,1))]
	IF RIGHT(cnum,1)>"0"
            vEXTENSO=vEXTENSO+" e "+ unidades[VAL(RIGHT(cnum,1))]
       	ENDIF
    CASE SUBSTR(cnum,8,1)="1"
        IF RIGHT(cnum,1)<>"0"
    	    vEXTENSO=vEXTENSO+unidonze[VAL(RIGHT(cnum,1))]
        ELSE
            vEXTENSO=vEXTENSO+"dez"
        ENDIF

    CASE RIGHT(cnum,2)=" 0"
        vEXTENSO=" "

    OTHERWISE
        IF RIGHT(cnum,1)<>"0"
            vEXTENSO=vEXTENSO+unidades[VAL(RIGHT(cnum,1))]
        ENDIF
ENDCASE
IF vEXTENSO = "cem e "
    vEXTENSO = "cem"
ENDIF

*
cents=RIGHT(STR(valor,12,2),2)
vEXTENSO=RTRIM(vEXTENSO)+" "+ALLTRIM(plur)
IF vEXTENSO = "um "+ALLTRIM(plur)
    vEXTENSO = "um "+ALLTRIM(sing)
ENDIF

* cheque Centavos
IF LTRIM(vEXTENSO) = ALLTRIM(plur)
    vEXTENSO =""
ENDIF
IF cents <> "00"
    IF vEXTENSO > " "
        vEXTENSO = vEXTENSO + " e "
    ENDIF
ENDIF

DO CASE
    CASE SUBSTR(cents,1,1)>"1"
    	vEXTENSO=vEXTENSO+decimais[VAL(SUBSTR(cents,1,1))]
       	IF RIGHT(cents,1)>"0"
            vEXTENSO=vEXTENSO+" e "+ unidades[VAL(RIGHT(cents,1))]
       	ENDIF
    CASE SUBSTR(cents,1,1)="1"
        IF RIGHT(cents,1)="0"
           vEXTENSO=vEXTENSO+"dez"
        ELSE
           vEXTENSO=vEXTENSO+unidonze[VAL(RIGHT(cents,1))]
        ENDIF

    OTHERWISE
        IF RIGHT(cents,1)<>"0"
            vEXTENSO=vEXTENSO+unidades[VAL(RIGHT(cents,1))]
        ENDIF
ENDCASE
IF cents <> "00"
    vEXTENSO=vEXTENSO + " centavos"
ENDIF
IF cents = "01"
    vEXTENSO=SUBSTR(vEXTENSO,1,LEN(vEXTENSO)-8) + "centavo"
ENDIF

compri = LEN(vEXTENSO)

*
IF compri > larg
    vez:=compri/larg
    vez:=INT(IF((vez-INT(vez))>0,vez+1,vez))
    rest:=vEXTENSO
    DO WHILE vez!=0
        IF SUBSTR(rest,larg,1)<>" "
            IF ISUPPER(SUBSTR(rest,larg,1))
                calex:=SUBSTR(rest,1,larg-1)+"-"
                contar = larg
            ENDIF
        ELSE
            calex:=SUBSTR(rest,1,larg-1)+" "
            contar = larg
        ENDIF
        IF SUBSTR(rest,larg+1,1)=" "
            calex:=SUBSTR(rest,1,larg)
            contar = larg+1
        ENDIF
        IF EMPT(calex)        
            contar = larg
        ENDIF
        DO WHILE .NOT. SUBSTR(rest,contar,1)=" " .AND. EMPTY(calex)
            IF ISUPPER(SUBSTR(rest,contar,1))
                calex:=SUBSTR(rest,1,contar-1)+"-"+REPLIC(" ",larg-contar)
                EXIT
            ENDIF
            contar-=1
        ENDDO
        IF EMPTY(calex)
            calex:=SUBSTR(rest,1,contar-1)+REPLI(" ",larg-(contar-1))
        ENDIF
        volta+=calex
        calex:=""
        rest:=LTRIM(SUBSTR(rest,contar))
        vez-=1
        IF vez=1
            volta=volta+rest+REPLIC(" ",larg-LEN(rest))
            EXIT
        ENDIF
    ENDDO
ELSE
    volta:=vEXTENSO+REPLIC(" ",larg-compri)
ENDIF
RETURN(ALLTRIM(volta))
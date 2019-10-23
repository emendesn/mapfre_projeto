//#include "fivewin.ch"
#INCLUDE "RWMAKE.CH"
//#Include "Protheus.ch"
//#Include "topconn.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณObrigCampoณ Autor ณ Richard Anderson      ณ Data ณ 05/06/01 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Transforma um campo nao obrigatorio para obrigatorio e     ณฑฑ
ฑฑณ          ณ vice e versa.                                              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Generico - Cliente Golden -                                ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function ObrigCampo(cCampo,cBloqueio)

LOCAL nPos := 0

cCampo := Padr( cCampo, 10 )

If cBloqueio == NIL
	cBloqueio := "T"
EndIf

nPos := Ascan( aGets, { | e | Substr( e, 9, 10 ) == cCampo } )

If nPos > 0
	aGets[ nPos ] := Stuff( aGets[ nPos ], 22, 1, cBloqueio )
EndIf

Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVECAMPO   บAutor  ณAndressa Favero     บ Data ณ  18/12/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Torna obrigatorio os campos do cadastro de fornecedores    บฑฑ
ฑฑบ          ณ para aplicacao do PAGFOR                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Uso Exclusivo para o cliente Golden Cargo                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VECAMPO()

U_OBRIGCAMPO("A2_BANCO","F")
U_OBRIGCAMPO("A2_AGENCIA","F")
U_OBRIGCAMPO("A2_NUMCON","F")
U_OBRIGCAMPO("A2_DIGCTA","F")
U_OBRIGCAMPO("A2_TPCON","F")

If M->A2_TIPOPAG $ "2/3"
	
	U_OBRIGCAMPO("A2_BANCO","T")
	U_OBRIGCAMPO("A2_AGENCIA","T")
	U_OBRIGCAMPO("A2_NUMCON","T")
	U_OBRIGCAMPO("A2_DIGCTA","T")
	U_OBRIGCAMPO("A2_TPCON","T")
	
EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVECAMPO2  บAutor  ณAndressa Favero     บ Data ณ  18/12/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Torna obrigatorio os campos do cadastro de contas a pagar  บฑฑ
ฑฑบ          ณ para aplicacao do PAGFOR                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Uso Exclusivo para o cliente Golden Cargo                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VeCampo2()



// inicializa as variaveis

U_OBRIGCAMPO("E2_CODBAR","F")
U_OBRIGCAMPO("E2_BANCO","F")
U_OBRIGCAMPO("E2_AGENCIA","F")
U_OBRIGCAMPO("E2_NUMCON","F")
U_OBRIGCAMPO("E2_DIGCTA","F")


If M->E2_TIPOPAG $ "2/3"
	
	U_OBRIGCAMPO("E2_BANCO","T")
	U_OBRIGCAMPO("E2_AGENCIA","T")
	U_OBRIGCAMPO("E2_NUMCON","T")
	U_OBRIGCAMPO("E2_DIGCTA","T")
	
ElseIf M->E2_TIPOPAG $ "4/5"
	
	U_OBRIGCAMPO("E2_CODBAR","T")
	
EndIf

Return()

/*/
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณ Valcod1  ณ Autor ณMicrosiga              ณ Data ณ 31/07/02 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ Calculo do modulo 11                                       ณฑฑ
ฑฑณ          ณ funcao usada como validacao do campo E2_CODBAR.            ณฑฑ
ฑฑณ          ณ                                                            ณฑฑ
ฑฑณ          ณ Nome        Tipo   Tamanho   Validacao                     ณฑฑ
ฑฑณ          ณ -----------  --     ----     ----------------------------  ณฑฑ
ฑฑณ          ณ E2_CODBAR    C       47      EXECBLOCK("VALCOD1")          ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
/*/

User Function VALCOD1()

LRET := .F.

if ValType(M->E2_CODBAR) == NIL
	Return(.t.)
Endif

cStr := M->E2_CODBAR

i := 0
nMult := 2
nModulo := 0
cChar := SPACE(1)
cDigito := SPACE(1)

If len(AllTrim(cStr)) > 44  // linha digitada
	
	cDV1    := SUBSTR(cStr,10, 1)
	cDV2    := SUBSTR(cStr,21, 1)
	cDV3    := SUBSTR(cStr,32, 1)
	
	cCampo1 := SUBSTR(cStr, 1, 9)
	cCampo2 := SUBSTR(cStr,11,10)
	cCampo3 := SUBSTR(cStr,22,10)
	
	/*
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
	ฑฑณDescri…o ณ Calculo do modulo 10 sugerido pelo ITAU. Esta funcao       ณฑฑ
	ฑฑณ          ณ somente e utilizada como validacao do campo E2_CODBAR      ณฑฑ
	ฑฑณ          ณ Verifica a digitacao do codigo de barras                   ณฑฑ
	ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	*/
	
	//
	// Calcula DV1
	//
	
	nMult := 2
	nModulo := 0
	nVal := 0
	
	For i := Len(cCampo1) to 1 Step -1
		cChar := Substr(cCampo1,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := Val(cChar)*nMult
		If nModulo >= 10
			nVal := NVAL + 1
			nVal := nVal + (nModulo-10)
		Else
			nVal := nVal + nModulo
		EndIf
		nMult:= if(nMult==2,1,2)
	Next
	nCalc_DV1 := 10 - (nVal % 10)
	if nCalc_DV1 == 10
		nCalc_DV1:=0
	endif
	
	//
	// Calcula DV2
	//
	nMult := 2
	nModulo := 0
	nVal := 0
	
	For i := Len(cCampo2) to 1 Step -1
		cChar := Substr(cCampo2,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := Val(cChar)*nMult
		If nModulo >= 10
			nVal := nVal + 1
			nVal := nVal + (nModulo-10)
		Else
			nVal := nVal + nModulo
		EndIf
		nMult:= if(nMult==2,1,2)
	Next
	nCalc_DV2 := 10 - (nVal % 10)
	if nCalc_DV2==10
		nCalc_DV2:=0
	endif
	//
	// Calcula DV3
	//
	nMult := 2
	nModulo := 0
	nVal := 0
	
	For i := Len(cCampo3) to 1 Step -1
		cChar := Substr(cCampo3,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := Val(cChar)*nMult
		If nModulo >= 10
			nVal := nVal + 1
			nVal := nVal + (nModulo-10)
		Else
			nVal := nVal + nModulo
		EndIf
		nMult:= if(nMult==2,1,2)
	Next
	nCalc_DV3 := 10 - (nVal % 10)
	
	if nCalc_DV3==10
		nCalc_DV3:=0
	endif
	
	if !(nCalc_DV1 == Val(cDV1) .and. nCalc_DV2 == Val(cDV2) .and. nCalc_DV3 == Val(cDV3) )
		Help(" ",1,"INVALCODBAR")
		lRet := .f.
	else
		lRet := .t.
	endif
	
Else
	cDigito := SUBSTR(cStr,5, 1)
	cStr    := SUBSTR(cStr,1, 4)+ ;
	SUBSTR(cStr,6,39)
	
	/*
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
	ฑฑณDescri…o ณ Calculo do modulo 11 sugerido pelo ITAU. Esta funcao       ณฑฑ
	ฑฑณ          ณ somente e utilizada como validacao do campo E2_CODBAR.     ณฑฑ
	ฑฑณ          ณ Verifica o codigo de barras grafico (Atraves de leitor)    ณฑฑ
	ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
	ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
	*/
	
	cStr := AllTrim(cStr)
	
	if Len(cStr) < 43
		Help(" ", 1, "FALTADG")
		Return(.f.)
	Endif
	
	For i := Len(cStr) to 1 Step -1
		cChar := Substr(cStr,i,1)
		if isAlpha(cChar)
			Help(" ", 1, "ONLYNUM")
			Return(.f.)
		endif
		nModulo := nModulo + Val(cChar)*nMult
		nMult:= if(nMult==9,2,nMult+1)
	Next
	nRest := 11 - (nModulo % 11)
	nRest := if(nRest==10 .or. nRest==11,1,nRest)
	if nRest <> Val(cDigito)
		Help(" ",1,"DgCnab")
		lRet := .f.
	else
		lRet := .t.
	endif
	
Endif

Return(lRet)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGAT001    บAutor  ณMicrosiga           บ Data ณ  11/09/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTransforma a linha digitavel em codigo de barras.           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP5                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

// Variแveis utilizadas no programa

User Function GAT001()


_cMonta1 := ""
_cMonta2 := ""
_cMonta3 := ""
_cMonta4 := ""
_cMonta5 := ""
_cMonta6 := ""
_cMonta7 := ""
_cReturn := ""
_cCodbar := Trim(M->E2_CODBAR)
_nTamCod := Len(_cCodbar)
_nTamVal := Len(_cCodbar)-33

// Verifica tamanho da linha digitแvel

If _nTamCod == 44
	_cReturn := _cCodbar
Else
	If _nTamVal < 14        // Codigo de Barras sem fator de vencimento.
		_cMonta3 := "0000"
		_cMonta4 := Strzero(Val(Substr(_cCodbar,34,_nTamVal)),10)
	Else                    // Codigo de Barras com fator de vencimento.
		_cMonta3:= Substr(_cCodbar,34,4)
		_cMonta4:= Substr(_cCodbar,38,10)
	Endif
	
	// Monta o Codigo de Barras
	
	_cMonta1:= Substr(_cCodbar,1,4)
	_cMonta2:= Substr(_cCodbar,33,1)
	_cMonta5:= Substr(_cCodbar,5,5)
	_cMonta6:= Substr(_cCodbar,11,10)
	_cMonta7:= Substr(_cCodbar,22,10)
	
	_cCodBar := _cMonta1 + _cMonta2 + _cMonta3 + _cMonta4 + _cMonta5 + _cMonta6 + _cMonta7
	_cReturn := _cCodbar
Endif

Return(_cReturn)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCTAATIV   บAutor  ณCristian Gutierrez  บ Data ณ  18/12/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho para validacao da conta contabil, verifica se esta  บฑฑ
ฑฑบ          ณou nao ativa.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico para o cliente Golden Cargo                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CTAATIV()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclaracao de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet     := .T.
Local aArea    := GetArea()
Local aAreaSI1 := SI1->(GetArea())
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณValida o status da conta contabil, se ativa ou nao.ณ
//ณSomente aceita contas com status Ativo.            ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

DbSelectArea("SI1")
DbSetOrder(1)
If MsSeek(xFilial("SI1")+&(ReadVar())) .And. SI1->I1_CTAATIV == "N"
	Aviso("Conta Inativa","A conta contแbil selecionada estแ inativa. Selecione uma conta ativa",{"OK"},,"Conta: "+&(ReadVar()))
	lRet := .F.

EndIF   

RestArea(aAreaSI1)
RestArea(aArea)

Return(lRet)              


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGAT002	   บAutor  ณCristian Gutierrez  บ Data ณ  07/06/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณUtilizado no gatilho para o campo d1_cod, sequencia 3       บฑฑ
ฑฑบ          ณcomo condicao                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Exclusivo para o cliente Golden                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GAT002()

lRet := .T.

If Empty(SA2->A2_CONTA) .And. !Empty(SD1->D1_CONTA)
	lRet := .F.
EndIf        

Return(lRet)             

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGAT003	   บAutor  ณCristian Gutierrez  บ Data ณ  07/06/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao utilizada no gatilho do campo E5_BANCO, para alimentaบฑฑ
ฑฑบ          ณcao automatica dos campos de cc e conta contabil.           บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Exclusivo para o cliente Golden                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function GAT003()                                     
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclaracao de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aArea    := GetArea()
Local aAreaSA6	:= SA6->(GetArea())
Local aAreaSED	:= SED->(GetArea())     

If cRECPAG == "R"

	DbSelectArea("SA6")
	DbSetOrder(1)
	If DbSeek(xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA)
		M->E5_DEBITO	:= SA6->A6_CONTA
		M->E5_CCD		:= SA6->A6_CC
	EndIf
   //M->E5_DEBITO := Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA,SA6->A6_CONTA)
	//M->E5_CCD		:= Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA,SA6->A6_CC)
	
	DbSelectArea("SED")
	DbSetOrder(1)
	If DbSeek(xFilial("SED")+M->E5_NATUREZ)
		M->E5_CREDITO	:= SED->ED_CTACRED
		M->E5_CCC		:= SED->ED_CC
	EndIf
 	//M->E5_CREDITO 	:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CTACRED)
	//M->E5_CCC 		:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CC)

ElseIF cRECPAG == "P"
	
	DbSelectArea("SA6")
	DbSetOrder(1)
	If DbSeek(xFilial("SA6")+M->E5_BANCO+M->E5_AGENCIA+M->E5_CONTA)
		M->E5_CREDITO	:= SA6->A6_CONTA
		M->E5_CCC		:= SA6->A6_CC
	EndIf
   //M->E5_CREDITO	:= Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+E5_AGENCIA+M->E5_CONTA,SA6->A6_CONTA)
	//M->E5_CCC			:= Posicione("SA6",1,xFilial("SA6")+M->E5_BANCO+E5_AGENCIA+M->E5_CONTA,SA6->A6_CC)	
	
		DbSelectArea("SED")
	DbSetOrder(1)
	If DbSeek(xFilial("SED")+M->E5_NATUREZ)
		M->E5_DEBITO 	:= SED->ED_CTADEB 
		M->E5_CCD		:= SED->ED_CC
	EndIf
	//M->E5_CCD 		:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CC)
	//M->E5_DEBITO  	:= Posicione("SED",1,xFilial("SED")+M->E5_NATUREZ,SED->ED_CTADEB)
	
Else
	Return(M->E5_BANCO)

EndIf

RestArea(aAreaSA6)                 
RestArea(aAreaSED)
RestArea(aArea)   

Return(M->E5_BANCO)      


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CCATIV   บAutor  ณCristian Gutierrez  บ Data ณ  18/12/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGatilho para validacao da conta contabil, verifica se esta  บฑฑ
ฑฑบ          ณou nao ativa.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico para o cliente Golden Cargo                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CCATIV()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclaracao de Variaveisณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local lRet     := .T.
Local aArea    := GetArea()
Local aAreaSI3 := SI3->(GetArea())
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณVerifica o campo aceita lancamento no cadastro de  ณ
//ณCentros de Custos, aceita lancam. para S ou Branco ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

DbSelectArea("SI3")
DbSetOrder(1)
If MsSeek(xFilial("SI3")+&(ReadVar())) .And. SI3->I3_LANC == "N"
	Aviso("Centro de Custo Invalido","Este centro de custo ้ sint้tico e nao aceita lancamentos. Selecione um centro de custos analํtico",{"OK"},,"Conta: "+&(ReadVar()))
	lRet := .F.

EndIF   

RestArea(aAreaSI3)
RestArea(aArea)

Return(lRet)              



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLOTECON   บAutor  ณAndreza Favero      บ Data ณ  10/01/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณDefinir o numero do lote contabil diferente para contas a   บฑฑ
ฑฑบ          ณpagar e contas a receber.                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function LoteGolden

Local aArea:= GetArea()

If FUNNAME() == "FINA370"
	If MV_PAR06 == 1         // Contas a Receber
		cLote:= "8850"
	ElseIf MV_PAR06 == 2     // Contas a Pagar
		cLote:= "8851"
	ElseIf MV_PAR06 == 3     // Cheques
		cLote:= "8851"
	ElseIf MV_PAR06 == 4     // Todas - recebera o numero padrao do sistema
		cLote:= "8850"
	EndIf      
Else  
   If cModulo == "SIGAFIN"
      cLote:= "8850"
   Else
      cLote:= Substr(X5_DESCRI,1,Iif(CtbinUse(),6,4))	
   EndIf   
EndIf

RestArea(aArea)

Return(cLote)
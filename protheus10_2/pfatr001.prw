#include "rwmake.ch"

User Function PFATR001()

SetPrvt("CTITULO,CCADASTRO,LEND,CDELFUNC,AROTINA,CINDEX")
SetPrvt("CKEY,CFILTER,NINDEX,CPERG,CFILTRASF2")

cTitulo   := "Impressao de Etiquetas versus Nostas Fiscais"
cMark     := GetMark(,"SF2","F2_OK")
cCadastro := OEMTOANSI (cTitulo)

cPerg := "PFAT01"
ValidPerg()

If ! Pergunte(cPerg,.T.)
	Return()
EndIf

aRotina := {{"Pesquisar","AxPesqui" , 0 , 1},;
			{"Imprimir",'U_PIMPETQ()', 0 , 3}}

dbSelectArea("SF2")
cFiltraSF2 := "dtos(F2_EMISSAO) >= '"+dtos(MV_PAR01)+"' .AND. dtos(F2_EMISSAO) <= '"+dtos(MV_PAR02)+"'"
cFiltraSF2 += " .AND. F2_DOC >= '"+MV_PAR03+"' .AND. F2_DOC <= '"+MV_PAR04+"'"
SF2->(dbSetFilter({|| &cFiltraSF2 }, cFiltraSF2 ))

Markbrow("SF2","F2_OK",,,,GetMark(,"SF2","F2_OK"))

SF2->(dbSetFilter({|| .T. }, ".T." ))

Return()
/*************************************************************************************************************/
USER Function PIMPETQ()      
Private _aEtiq1a := {}
Private _aEtiq2a := {}
Private _aEtiq3a := {}
Private _aEtiq4a := {}
Private _aEtiq5a := {}
Private _aEtiq6a := {}
Private _aEtiq7a := {}
Private _aEtiq8a := {}

SF2->(dbSetFilter({|| &cFiltraSF2 }, cFiltraSF2 ))
SF2->(dbgotop())
Do While ! SF2->(eof()) 
	If SF2->(IsMark("F2_OK"))
		SA1->(dbSeek(XFILIAL('SA1')+SF2->(F2_CLIENTE+F2_LOJA)))		
		aadd(_aEtiq1a,ALLTRIM(SA1->A1_NOME))
		aadd(_aEtiq2a,UPPER(ALLTRIM(SA1->A1_CONTATO)))
		aadd(_aEtiq3a,ALLTRIM(SA1->A1_END))
 		aadd(_aEtiq4a," ")
		aadd(_aEtiq5a,ALLTRIM(SA1->A1_BAIRRO))
		aadd(_aEtiq6a,ALLTRIM(SA1->A1_MUN)) 
		aadd(_aEtiq7a," / "+ALLTRIM(SA1->A1_EST))
		aadd(_aEtiq8a,TRANSFORM(SA1->A1_CEP,"@R 99999-999"))
			    
	Endif
	sf2->(dbskip())
EndDo    
                     
If len(_aEtiq1a) > 0
	If (len(_aEtiq1a) % 2) > 0
		aadd(_aEtiq1a," ");aadd(_aEtiq2a," ");aadd(_aEtiq3a," ");aadd(_aEtiq4a," ")
		aadd(_aEtiq5a," ");aadd(_aEtiq6a," ");aadd(_aEtiq7a," ");aadd(_aEtiq8a," ")
	EndIf
	u_ImpEtiqCli()
EndIf

SF2->(dbSetFilter({|| &cFiltraSF2 }, cFiltraSF2 ))
SF2->(dbgotop())

Return()

User Function ImpEtiqCli()
Private oPrint // impressão grafica
Private oFont12 := TFont():New("Courier New",9,11.5,.T.,.F.,5,.T.,5,.T.,.F.)
Private nlin := 0

oPrint:=TMSPrinter():New( "Etiquetas de Cliente por Emissao de Nota Fiscal" )	// inicialização do formulário
oPrint:SetPortrait() // retrato
oPrint:StartPage()	// inicializacao pagina

_nImp := 1
do while _nImp <= len(_aEtiq1a)
	If nlin >= 2900 //2750
		oPrint:EndPage() // Finaliza a página
		oPrint:StartPage()	// inicializacao pagina
		nlin := 0
	EndIf
    // imprime nome
   	nlin += 120 //80
	oPrint:Say  (nlin,0050,_aEtiq1a[_nImp],oFont12)
	oPrint:Say  (nlin,1300,_aEtiq1a[_nImp+1],oFont12)	
    
	// contato		                        
   	nlin += 36 //44
	oPrint:Say  (nlin,0050,_aEtiq2a[_nImp],oFont12)
	oPrint:Say  (nlin,1300,_aEtiq2a[_nImp+1],oFont12)	

    // imprime endereco
   	nlin += 36 //44
	oPrint:Say  (nlin,0050,_aEtiq3a[_nImp],oFont12)
	oPrint:Say  (nlin,1300,_aEtiq3a[_nImp+1],oFont12)	

	// imprime complemento e bairro
   	nlin += 36 //44
	oPrint:Say  (nlin,0050,_aEtiq5a[_nImp],oFont12)
	oPrint:Say  (nlin,1300,_aEtiq5a[_nImp+1],oFont12)	

	// imprime municipio e estado 
   	nlin += 36 //44
	oPrint:Say  (nlin,0050,_aEtiq6a[_nImp]+_aEtiq7a[_nImp],oFont12)
	oPrint:Say  (nlin,1300,_aEtiq6a[_nImp+1]+_aEtiq7a[_nImp+1],oFont12)	

	// imprime cep
   	nlin += 36 //44
	oPrint:Say  (nlin,0050,_aEtiq8a[_nImp],oFont12)
	oPrint:Say  (nlin,1300,_aEtiq8a[_nImp+1],oFont12)	

	_nImp += 2
enddo

oPrint:EndPage() // Finaliza a página
oPrint:Preview() // Visualiza antes de imprimir

Return()

/*
Private titulo   := "EMISSAO DE ETIQUETAS 2 COLUNAS"
Private cDesc1   := "Este programa ir emitir etiquetas em 2 colunas conforme"
Private cDesc2   := "parametros especificados."
Private cDesc3   := ""
Private cString  := ""
PRIVATE tamanho := "P"
Private nTipo := 18
//cString  := "SF2"
Private aReturn  := { "Zebrado", 1,"Administracao", 2, 2, 1, "",1 }
Private cPerg    := ""
Private nLastKey := 0

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT.                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="PFATR001" 
//wnrel:= SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,.F.,"P")
wnrel:= SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

SetDefault(aReturn,cString)

If LastKey() == 27 .Or. nLastKey == 27
   Return()
Endif

SetPrc(0,0)  // (Zera o Formulario)                         
@ prow(),000 PSAY CHR(18)
_nImp := 1
do while _nImp <= len(_aEtiq1a)
    // imprime nome
	@ prow()+1,000 PSAY _aEtiq1a[_nImp]
	@ prow()  ,045 PSAY _aEtiq1a[_nImp+1]

	// contato		                        
	@ prow()+1,000 PSAY _aEtiq2a[_nImp]
	@ prow()  ,045 PSAY _aEtiq2a[_nImp+1]

    // imprime endereco
	@ prow()+1,000 PSAY _aEtiq3a[_nImp]
	@ prow()  ,045 PSAY _aEtiq3a[_nImp+1]

	// imprime complemento e bairro
	@ prow()+1,000 PSAY _aEtiq5a[_nImp] //alltrim(_aEtiq4a[_nImp])+" "+alltrim(_aEtiq5a[_nImp])
	@ prow()  ,045 PSAY _aEtiq5a[_nImp+1] //alltrim(_aEtiq4a[_nImp+1])+" "+alltrim(_aEtiq5a[_nImp+1])
                                   
	// imprime municipio e estado 
	@ prow()+1,000 PSAY _aEtiq6a[_nImp]+_aEtiq7a[_nImp]
	@ prow()  ,045 PSAY _aEtiq6a[_nImp+1]+_aEtiq7a[_nImp+1]

	// imprime cep
	@ prow()+1,000 PSAY _aEtiq8a[_nImp]
	@ prow()  ,045 PSAY _aEtiq8a[_nImp+1]
	_nImp += 2
	
	@ prow()+0.5,000 PSAY "" //quantidade de linhas entre as etiquetas.
enddo
@ 78,000 PSAY CHR(18)		                                   
SetPrc(0,0)  // (Zera o Formulario)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em Disco, chama Spool.                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If aReturn[5] == 1
   Set Printer To 
   dbCommitAll()
   ourspool(wnrel)
Endif
MS_FLUSH()

RETURN()
/*
/*************************************************************************************************************/
Static Function ValidPerg()
ssAlias      := Alias()
cPerg        := PADR(cPerg,len(sx1->x1_grupo))
aRegs        := {}
dbSelectArea("SX1")
dbSetOrder(1)  //                                                                1v 1p 1e 1i 1c 2v 2p 2e 2i 2c 3v 3p 3e 3i 3c 4v 4p 4e 4i 4c 5v 5p 5e 5i 5c f3 py gr he pi
AADD(aRegs,{cPerg,"01","Emissao de ","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"02","Emissao ate","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"03","Nota de    ","","","mv_ch3","C",06,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"04","Nota ate   ","","","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
For i := 1 to Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j := 1 to FCount()
			FieldPut(j,aRegs[i,j])
		Next
		MsUnlock()
	Endif
Next
DbSelectArea(ssAlias)
Return()

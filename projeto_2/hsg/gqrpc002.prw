#include "rwmake.ch"
#INCLUDE "MSOLE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRPCPR006  บAutor  ณTrade               บ Data ณ  23/12/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  ORDEM DE PRODUวรO - PA                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP Programa especifico para GEQUIMICA - MADRE DE DEUS      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function GQRPC002()

wnrel      :="GQRPC002"
Titulo     :="CONTROLE DE PROCESSOS - PA"
cDesc1     :="EMITE CONTROLE DE PROCESSOS "
cDesc2     :=""
cDesc3     :=""
cString    :="SC2"
nLastKey   := 0
aReturn    := { "Especial", 1,"Compras", 1, 2, 1, "",1 }
cPerg      := "GQRPC003"
LI		   := 0
_cBitMap:= "lgrl1010.bmp"


ValidPerg()

pergunte(cPerg,.F.)

wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,"","","","",.F.)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
Endif

RptStatus({|| RptDetail()})
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑบ					Inicio da rotina RptDetail							  บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function RptDetail()

Private oFont03:= TFont():New("Arial",,03,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont04:= TFont():New("Arial",,04,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont05:= TFont():New("Arial",,05,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont06:= TFont():New("Arial",,06,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont07:= TFont():New("Arial",,07,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont08:= TFont():New("Arial",,08,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont09:= TFont():New("Arial",,09,,.f.,,,,,.F.) 		//Tamanhos de fonte
Private oFont09n:= TFont():New("Arial",,09,,.t.,,,,,.F.) 		//Tamanhos de fonte
Private oFont10:= TFont():New("Arial",,10,,.f.,,,,,.F.) 		//Tamanhos de fonte
Private oFont10n:= TFont():New("Arial",,10,,.t.,,,,,.F.) 		//Tamanhos de fonte
Private oFont11:= TFont():New("Arial",,11,,.f.,,,,,.F.)  		//Tamanhos de fonte
Private oFont12:= TFont():New("Arial",,12,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont12N:= TFont():New("Arial",,12,,.T.,,,,,.f.)  		//Tamanhos de fonte
Private oFont14:= TFont():New("Arial",,14,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont16:= TFont():New("Arial",,16,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont18:= TFont():New("Arial",,18,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont24:= TFont():New("Arial",,24,,.f.,,,,,.f.)  		//Tamanhos de fonte

Private oPrn:=TMSPrinter():New()								// Declara o objeto a ser impresso

Private nCont := 1
Private nProx := 1
Private npag  := 1

//Filtra SC2
#IFDEF TOP
cQRY := ""
cQRY += "SELECT * "
cQRY += "FROM "+RetSqlname("SC2")+" SC2 WHERE SC2.D_E_L_E_T_ <> '*' AND C2_FILIAL BETWEEN  '"+MV_PAR01+"' AND  '"+MV_PAR02+"' "
cQRY += "AND SC2.C2_NUM+SC2.C2_ITEM+SC2.C2_SEQUEN BETWEEN '"+MV_PAR03+"' AND  '"+MV_PAR04+"' "

If Select("CPSC2") > 0
   DbselectArea("CPSC2")
   DbcloseArea()
Endif
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQRY),"CPSC2",.T.,.F.)


	DbSelectArea("CPSC2")
	Dbgotop()
	While CPSC2->(!Eof())
#ELSE
	 DbSelectArea("SC2")
	 DbSetOrder(1)
	 If empty(MV_PAR01+MV_PAR03) 
    	 Dbgotop()
	 Else
	    DbSeek(MV_PAR01+MV_PAR03,.F.)   
	 Endif
	 While SC2->(!Eof()) .And. SC2->(C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN)>= MV_PAR01+MV_PAR03 .And. SC2->(C2_FILIAL+C2_NUM+C2_ITEM+C2_SEQUEN)<= MV_PAR02+MV_PAR04
#ENDIF

oPrn:SetLandscape()
oPrn:StartPage() 	// Inicia pagina
IMPTXTFIX()    		// Imprime Texto
LI := 0
IMPOPS()            // Imprime dados da OP

oPrn:EndPage()		// Fim da Pagina

	#IFDEF TOP
		DbSelectArea("CPSC2")
		DbSkip()
	#ELSE
	    DbSelectArea("SC2")
		DbSkip()
	#Endif
	
eNDDO
oPrn:Preview() // Para visualizar

MS_FLUSH()



Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณIMPTXTFIX ณ Autor ณ Alex Menezes          ณ Data ณ 15.03.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ IMRESSAO texto fixo   				                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ IMPTXTFIX()                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Generico                                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function IMPTXTFIX()

oPrn:Box(0035,0035,0450,3100)//CABECALHO
oPrn:Box(0100,0950,0450,3100-200)//CABECALHO     35

oPrn:Say(0035,0952,"Nฐ OP:",oFont10n,100)
oPrn:Say(0035,1503,"Data Inํcio Produ็ใo:",oFont10,100)
oPrn:box(0035,2300,00100,2300)
oPrn:Say(0035,2303,"Data Fim Produ็ใo:",oFont10,100)

oPrn:Box(0100,0950,0450,3100-400) // 7 QUADRO  35

oPrn:Say(0100,1503,"Hora Inํco:",oFont10,100)
oPrn:box(0100,2103,0100,2103)
oPrn:Say(0100,2103,"Hora Fim:",oFont10,100)
//
oPrn:Say(0100,2715,"Rolo",oFont10,100)
oPrn:Say(0170,2728,"2 (   )",oFont10,100)
oPrn:Say(0240,2728,"3 (   )",oFont10,100)
oPrn:Say(0310,2728,"4 (   )",oFont10,100)
oPrn:Say(0380,2728,"5 (   )",oFont10,100)

oPrn:Say(0100,2908,"Sandvik",oFont10,100)
oPrn:Say(0170,2928,"1 (   )",oFont10,100)
oPrn:Say(0240,2928,"2 (   )",oFont10,100)
oPrn:Say(0310,2928,"3 (   )",oFont10,100)
oPrn:Say(0380,2928,"4 (   )",oFont10,100)

//
oPrn:Say(0170,1503,"Parametros do Processo",oFont10,100)
//oPrn:box(0100,2103,0100,2103)
oPrn:Say(0170,2308,"Temp. Inicial (*C)",oFont10,100)
oPrn:Say(0170,2108,"Mแximo",oFont10,100)
oPrn:Say(0170,1908,"Mํnimo",oFont10,100)
oPrn:Say(0310,1508,"Temp (*C)",oFont10,100)

oPrn:Box(0170,0950,0450,3100-800)  //6 QUADRO  0035

oPrn:Box(0170,0950,0450,3100-1000) // 5 QUADRO 0035

oPrn:Box(0170,0950 ,0450,3100-1200) // 4 QUADRO //170
oPrn:Say(0100,0952,"QTD:",oFont10n,100)
/* */
//
oPrn:Box(240,3100-1200,0450,3100-1400)//3 QUADRO

//oPrn:Box(240,1700,0240,2100)//3 QUADRO
oPrn:Box(240,1700,0310,2100)//3 QUADRO
oPrn:Box(310,1700,0380,2100)//3 QUADRO
oPrn:Say(0240,1710,"Produto",oFont10,100)
oPrn:Say(0310,1710,"มgua",oFont10,100)
oPrn:Say(0380,1710,"Vasca",oFont10,100)

oPrn:Say(0170,0952,"ORIGEM:",oFont10n,100)
//LINHA SUPERIOR 3

oPrn:Box(035,0950,0100  ,3100)//3 QUADRO  1500
oPrn:Box(0100,0950,170  ,2700)//3 QUADRO
oPrn:Box(0170,0950,240  ,2700)//3 QUADRO
//LINHA PARTE INFERIOR 3
oPrn:Box(240,01900,0310  ,2700)//3 QUADRO
oPrn:Box(0310,01900,0380  ,2700)//3 QUADRO
oPrn:Box(0380,01900,0450  ,2700)//3 QUADRO

oPrn:Box(0240,0950,0310  ,1500)//3 QUADRO
oPrn:Box(0310,0950,0380 ,1500)//3 QUADRO
oPrn:Box(0380,0950,0450 ,1500)//3 QUADRO
oPrn:Say(0240,0952,"MQ/RL:",oFont10n,100)
oPrn:Say(0310,0952,"LOTE:" ,oFont10n,100)
oPrn:Say(0380,0952,"TURNO:",oFont10n,100)

/*
*/

oPrn:Box(0035,0950,0450,3100-1600)// 2 QUADRO
oPrn:Box(0035,0950,0450,3100-2150)// 1 QUADRO

LI+= 041
oPrn:SayBitmap(LI,0041,_cBitMap,320,100)
LI:= 045
oPrn:Say(LI,0320,"CONTROLE E PROCESSOS",oFont12N,100)
oPrn:Say(0170,0042,"PRODUTO:",oFont10n,100)
oPrn:Say(0240,0042,"EMISSรO:",oFont10n,100)
oPrn:Say(0310,0042,"PREV. INICIO:",oFont10n,100)
oPrn:Say(0380,0042,"PREV. TERMINO:",oFont10n,100)
// quadrado detalhe

oPrn:Box(0455,0035,0655,0220)// 2 QUADRO
OPrn:Box(0455,0220,0525,3100)// 2 QUADRO
//
oPrn:Box(0525,0220,0655,3100)// 2 QUADRO
//
LI:=0655

OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120
// 2
OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120
//3
OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120
//4
OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120
//5
OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120
//6
OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120
//7
OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120
// 8
OPrn:Box(LI,0035,LI+060,1700)// 2 QUADRO
OPrn:Box(LI,1700,LI+120,2100)// 2 QUADRO
OPrn:Box(LI+60,0035,LI+120,1700)// 2 QUADRO
//
OPrn:Box(LI,2100,LI+60,2700)// 2 QUADRO
OPrn:Box(LI+60,2100,LI+120,2700)// 2 QUADRO
OPrn:Box(LI,2700,LI+120,3100)// 2 QUADRO
LI+=120

oPrn:Box(LI,0035,LI+0060,1700)// LINHA
oPrn:Box(LI+60,0035,LI+120,1700)// LINHA
oPrn:Box(LI+120,0035,LI+180,1700)// LINHA
oPrn:Box(LI+180,0035,LI+240,1700)// LINHA

// DIVISAO
oPrn:Box(0655,0035,LI+180,0220) //655
oPrn:Box(0525,0220,LI+180,0405 ) //455 //525
oPrn:Box(0525,0405,LI+180,0590 )
oPrn:Box(0525,0590,LI+180,0775 )
oPrn:Box(0525,0775,LI+180,0960 )
oPrn:Box(0525,0960,LI+180,1145 )
oPrn:Box(0525,1145,LI+180,1330 )
oPrn:Box(0525,1330,LI+180,1515 )
oPrn:Box(0525,1515,LI+180,1700 )
//

// ;;;oPrn:Box(0655,17005,LI+180,0220) //655
//CABECALHO
oPrn:Say(0462   ,0042,"Medi็ใo",oFont10,100)
oPrn:Say(0462+45,0042,"(No.Carros)",oFont10,100)
oPrn:Say(0462+90,0042,"(No.Grades)",oFont10,100)
//
oPrn:Say(0462   ,0410,"Velocidade",oFont10n,100)
oPrn:Say(0462   ,0970,"Temperatura(C)",oFont10n,100)
oPrn:Say(0462   ,1340,"Tempo(Minutos)",oFont10n,100)
oPrn:Say(0462   ,2308,"ENTABLETADORA No.:",oFont10n,100)
//2308

oPrn:Say(0565   ,0220+10,"Esteira" ,oFont10,100)
oPrn:Say(0565   ,0405+10,"Rotoform",oFont10,100)
oPrn:Say(0565   ,0590+10,"Bomba"  ,oFont10,100)
oPrn:Say(0565   ,0775+10,"Produto",oFont10,100)
oPrn:Say(0565   ,0960+10,"มgua"   ,oFont10,100)
oPrn:Say(0565   ,1145+10,"Vasca"  ,oFont10,100)
oPrn:Say(0565   ,1330+10,"Hora"   ,oFont10,100)
oPrn:Say(0565   ,1515+10,"Efetivo",oFont10,100)

oPrn:Say(0565   ,1700+10,"DATA"   ,oFont10,100)
oPrn:Say(0565   ,1900+10,"No.",oFont10,100)

oPrn:Say(0565+120,1920,"1",oFont10,100)
oPrn:Say(0565+(120*2),1920,"2",oFont10,100)
oPrn:Say(0565+(120*3),1920,"3",oFont10,100)
oPrn:Say(0565+(120*4),1920,"4",oFont10,100)
oPrn:Say(0565+(120*5),1920,"5",oFont10,100)
oPrn:Say(0565+(120*6),1920,"6",oFont10,100)
oPrn:Say(0565+(120*7),1920,"7",oFont10,100)
oPrn:Say(0565+(120*8),1920,"8",oFont10,100)
////
oPrn:Say(0620+060   ,2110,"E=",oFont10,100)
oPrn:Say(0620+(060*2),2110,"R=",oFont10,100)
oPrn:Say(0620+(060*3),2110,"E=",oFont10,100)
oPrn:Say(0620+(060*4),2110,"R=",oFont10,100)
oPrn:Say(0620+(060*5),2110,"E=",oFont10,100)
oPrn:Say(0620+(060*6),2110,"R=",oFont10,100)
oPrn:Say(0620+(060*7),2110,"E=",oFont10,100)
oPrn:Say(0620+(060*8),2110,"R=",oFont10,100)
//
oPrn:Say(0620+(060*9)  ,2110,"E=",oFont10,100)
oPrn:Say(0620+(060*10),2110,"R=",oFont10,100)
oPrn:Say(0620+(060*11),2110,"E=",oFont10,100)
oPrn:Say(0620+(060*12),2110,"R=",oFont10,100)
oPrn:Say(0620+(060*13),2110,"E=",oFont10,100)
oPrn:Say(0620+(060*14),2110,"R=",oFont10,100)
oPrn:Say(0620+(060*15),2110,"E=",oFont10,100)
oPrn:Say(0620+(060*16),2110,"R=",oFont10,100)


//hsg
//
oPrn:Say(0565,2103,"HORมRIO ENCHIMENTO/RETIRA:",oFont10,100)
//
oPrn:Say(0565,2715,"Retirada da Amostra",oFont10,100)
OPrn:Box(0455+70,2700,0655,3100)// //retirada da amostra
//OPrn:Box(0455,0220,0525,3100)// 2 QUADRO
//
OPrn:Box(0525,1700,LI,1900)   // data
OPrn:Box(0525,1900,LI,2100)  // no.
OPrn:Box(0455,0220,0525,0775)// velocidade
OPrn:Box(0455,0775,0525,1330)// TEMPERATURA
OPrn:Box(0455,1330,0525,1700)// TEMPO (MINUTOS)

//
OPrn:Box(LI,1700,LI+240,3100)//CODIGO DE BARRA

OPrn:Box(LI+240,0035,LI+740,3100)//QUADRO FINAL
LI:=LI+240+20
oPrn:Say(LI,0042,"Qtd.(KG) Produzida no turno anterior",oFont10,100)
oPrn:Box(LI,0950,LI+60 ,1500)//QUADRO DO TOPICO ACIMA
oPrn:Say(LI,1700,"Qtd.(KG) Produzida Acumulada",oFont10,100)
oPrn:Box(LI,2650,LI+60 ,3100)//QUADRO DO TOPICO ACIMA

LI:=LI+60+20
oPrn:Say(LI,0042,"Qtd.Sacos/Caixas do ๚ltimo carro/grade turno anterior",oFont10,100)
oPrn:Box(LI,0950,LI+60 ,1500)//QUADRO DO TOPICO ACIMA
oPrn:Say(LI,1700,"Qtd.(KG) Sacos do ๚ltimo carro/grade turno atual",oFont10,100)
oPrn:Box(LI,2650,LI+60 ,3100)//QUADRO DO TOPICO ACIMA
LI:=LI+60+20
OPrn:Box(LI,0035,LI+60,1700)//ocorrencis/observa็๕es
oPrn:Say(LI,0555,"OCORRสNCIAS / OBSERVAวีES",oFont10,100)
LI:=LI+60+20
oPrn:Box(LI,0035,LI+60,1700)// LINHA
LI:=LI+60
oPrn:Box(LI,0035,LI+60,1700)// LINHA
LI:=LI+60
oPrn:Box(LI,0035,LI+60,1700)// LINHA
LI:=LI+60
oPrn:Box(LI,0035,LI+60,1700)
// LINHA DA ASSINATURA 1
oPrn:Box(LI,1700,LI,2150)// LINHA
oPrn:Say(LI+00,1750,"ASS.ENCARREGADO",oFont08,100)

//LINHA DA ASSINATURA 2
oPrn:Box(LI,2650,LI,3100)// LINHA
oPrn:Say(LI+00,2750,"ASS.AJUDANTE",oFont08,100)




MSBAR3("CODE128",14,16,"00000000000",oPrn,/*lCheck*/,/*Color*/,/*lHorz*/,.0811,1.2,/*lBanner*/,/*cFont*/,"C",.F.)


Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณValidPerg บAutor  ณTrade               บ Data ณ  23/03/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Validador de Paramentros                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Especifico                                                 บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ValidPerg()
_sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,10)
aRegs:={}

AADD(aRegs,{cPerg,"01","Filial de   ?        ","","","mv_ch1","C",02,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SC2","",""})
AADD(aRegs,{cPerg,"02","Filial At้  ?        ","","","mv_ch2","C",02,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SC2","",""})
AADD(aRegs,{cPerg,"03","Ordem de Produ็ใo De ?","","","mv_ch3","C",11,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SC2","",""})
AADD(aRegs,{cPerg,"04","Ordem de Produ็ใo At้?","","","mv_ch4","C",11,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SC2","",""})
AADD(aRegs,{cPerg,"05","Origem               ?","","","mv_ch5","C",03,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SM4","",""})
AADD(aRegs,{cPerg,"06","MQ/RL                ?","","","mv_ch6","C",15,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"07","Lote                 ?","","","mv_ch7","C",15,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"08","Turno                ?","","","mv_ch8","C",15,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"09","Conting๊ncia         ?","","","mv_ch9","N",01,0,0,"C","","mv_par09","Sim","Sim","Sim","","Nao","Nao","Nao","","","","","","","","","","","","","","","","","","","",""})

For i:=1 To Len(aRegs)
	If !DbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For J:=1 to FCount()
			If J <= Len(aRegs[i])
				FieldPut(J,aRegs[i,j])
			Else
				Exit
			EndIf
		Next
		MsUnlock()
	EndIf
Next
DbSelectArea(_sAlias)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMPOPS    บAutor  ณTrade              บ Data ณ  15/03/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime variaveis                                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function IMPOPS()

Local LII := 0
/*
oPrn:Say(0170,0042,"PRODUTO:",oFont10n,100)
oPrn:Say(0240,0042,"EMISSรO:",oFont10n,100)
oPrn:Say(0310,0042,"PREV. INICIO:",oFont10n,100)
oPrn:Say(0380,0042,"PREV. TERMINO:",oFont10n,100)
//
oPrn:Say(0035,0952,"Nฐ OP:",oFont10n,100)
oPrn:Say(0100,0952,"QTD:",oFont10n,100)
oPrn:Say(0170,0952,"ORIGEM:",oFont10n,100)
oPrn:Say(0240,0952,"MQ/RL:",oFont10n,100)
oPrn:Say(0310,0952,"LOTE:" ,oFont10n,100)
oPrn:Say(0380,0952,"TURNO:",oFont10n,100)
*/

#IFDEF TOP

	
	IF MV_PAR09 == 2
		LII := 35
		CCL := 230
		oPrn:Say(LII,0952+CCL,ALLTRIM(CPSC2->C2_NUM+CPSC2->C2_ITEM+CPSC2->C2_SEQUEN),oFont12n,100)
		
		SB1->(DbSetOrder(1) )
		SB1->(DbSeek(xfilial("SB1")+CPSC2->C2_PRODUTO ))
		//ALLTRIM(SC2->C2_PRODUTO)+" - "+ALLTRIM(SB1->B1_DESC),oFont10,100)
		
		LII +=65
		
		oPrn:Say(LII,0952+CCL,ALLTRIM(TRANSFORM(CPSC2->C2_QUANT, '@E 9,999,999')),oFont10,100)
		
		LII +=70
		oPrn:Say(LII,0042+CCL, ALLTRIM(CPSC2->C2_PRODUTO) ,oFont10,100)
		oPrn:Say(LII,0952+CCL,mv_par05,oFont10,100)
		
		
		//oPrn:Say(LII,0952+50,ALLTRIM(TRANSFORM(SC2->C2_QUANT, '@E 9,999,999')),oFont10,100)
		LII +=70
		oPrn:Say(LII,042+CCL,ALLTRIM(substr((CPSC2->C2_EMISSAO),7,2)+"/"+substr((CPSC2->C2_EMISSAO),5,2)+"/"+substr((CPSC2->C2_EMISSAO),1,4)),oFont10,100)
		oPrn:Say(LII,0952+CCL, MV_PAR06 ,oFont10,100) //MQ/RL
		//
		LII +=70
		oPrn:Say(LII,042+CCL,ALLTRIM(substr((CPSC2->C2_DATPRI),7,2)+"/"+substr((CPSC2->C2_DATPRI),5,2)+"/"+substr((CPSC2->C2_DATPRI),1,4)),oFont10,100)
		oPrn:Say(LII,0952+CCL,MV_PAR07 ,oFont10,100) // lote deve ser branco
		//
		LII +=70
		oPrn:Say(LII,042+CCL,ALLTRIM(substr((CPSC2->C2_DATPRF),7,2)+"/"+substr((CPSC2->C2_DATPRF),5,2)+"/"+substr((CPSC2->C2_DATPRF),1,4)),oFont10,100)
		oPrn:Say(LII,0952+CCL, MV_PAR08 ,oFont10,100) // TURNO
		
	ENDIF
	
#ELSE
	
	DbSelectArea("SC2")
	DbSetOrder(1)
	DbSeek(xfilial("SC2")+MV_PAR01)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xfilial("SB1")+SC2->C2_PRODUTO)
	
	IF MV_PAR09 == 2
		LII := 35
		
		oPrn:Say(LII,0952+50,ALLTRIM(SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN),oFont12n,100)
		
		SB1->(DbSetOrder(1) )
		SB1->(DbSeek(xfilial("SB1")+SC2->C2_PRODUTO ))
		//ALLTRIM(SC2->C2_PRODUTO)+" - "+ALLTRIM(SB1->B1_DESC),oFont10,100)
		
		LII +=65
		
		oPrn:Say(LII,0952+50,ALLTRIM(TRANSFORM(SC2->C2_QUANT, '@E 9,999,999')),oFont10,100)
		
		LII +=70
		oPrn:Say(LII,0042, ALLTRIM(SC2->C2_PRODUTO) ,oFont10,100)
		oPrn:Say(LII,0952+50,mv_par05,oFont10,100)
		
		
		//oPrn:Say(LII,0952+50,ALLTRIM(TRANSFORM(SC2->C2_QUANT, '@E 9,999,999')),oFont10,100)
		LII +=70
		oPrn:Say(LII,042+50,ALLTRIM(substr(DTOS(SC2->C2_EMISSAO),7,2)+"/"+substr(DTOS(SC2->C2_EMISSAO),5,2)+"/"+substr(DTOS(SC2->C2_EMISSAO),1,4)),oFont10,100)
		oPrn:Say(LII,0952+50, MV_PAR06 ,oFont10,100) //MQ/RL
		//
		LII +=70
		oPrn:Say(LII,042+50,ALLTRIM(substr(DTOS(SC2->C2_DATPRI),7,2)+"/"+substr(DTOS(SC2->C2_DATPRI),5,2)+"/"+substr(DTOS(SC2->C2_DATPRI),1,4)),oFont10,100)
		oPrn:Say(LII,0952+50,MV_PAR07 ,oFont10,100) // lote deve ser branco
		//
		LII +=70
		oPrn:Say(LII,042+50,ALLTRIM(substr(DTOS(SC2->C2_DATPRF),7,2)+"/"+substr(DTOS(SC2->C2_DATPRF),5,2)+"/"+substr(DTOS(SC2->C2_DATPRF),1,4)),oFont10,100)
		oPrn:Say(LII,0952+50, MV_PAR08 ,oFont10,100) // TURNO
		
	ENDIF
#ENDIF
Return


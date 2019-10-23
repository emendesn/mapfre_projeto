#include "rwmake.ch"
#INCLUDE "MSOLE.CH"
#include "protheus.ch"
#include "topconn.ch" 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  GQrTrd01  บAutor  ณTrade                บ Data ณ  23/03/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  DIARIO DE BORDO                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP Programa especifico para GEQUIMICA - MADRE DE DEUS      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function GQrTrd01()

wnrel      :="RPCPR006"
Titulo     :="ORDEM DE PRODUวรO - PA"
cDesc1     :="EMITE ORDEM DE PRODUวรO PARA PRODUTO ACABADO"
cDesc2     :=""
cDesc3     :=""
cString    :="SC2"
nLastKey   := 0
aReturn    := { "Especial", 1,"Compras", 1, 2, 1, "",1 }
cPerg      := "GQDBORD"
LI		   := 0
_cBitMap:= "lgrl1010.bmp"
_cBitDBR1:= "DBR1.BMP"
_cBitDBR2:= "DBR2.BMP"

_cBitd2_1:="d2_1.bmp" //ROTOFORM
_cBitd2_2:="d2_2.bmp" //ESTEIRA
_cBitd2_3:="d2_3.bmp" //BOMBA
_cBitd2_4:="d2_4.bmp" //VAPOR
_cBitd2_5:="d2_5.bmp" //AGUA
_cBitd2_6:="d2_6.bmp" //SILO
_cBitd2_7:="d2_7.bmp" //BALANCA
_cBitd2_8:="d2_8.bmp" //INKJET
_cBitd2_9:="d2_9.bmp" //OUTROS
_cBitSilo2:="SILO02.bmp"
_cBitSilo3:="SILO03.bmp"
_cBitSilo4:="SILO04.bmp"
_cBitSilo5:="SILO05.bmp"
_cBitTanq:="TANQUE.bmp"
_cBitNrSi:="NUMSIM.bmp"
_cBitNrno:="NUMNAO.bmp"

// Chamada a valida็ใo da SX1
ValidPerg()

pergunte(cPerg,.F.)

/*
//Envia controle para a funcao SETP
*/

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

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณProgram   ณ RptDetail ณ Autor ณ Trade                ณ Data ณ23.03.2011ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณControle de Fluxo do Relatorio.                             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณRetorno   ณNenhum                                                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ       Objeto grafico de impressao                    (OPC) ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ   DATA   ณ Programador   ณManutencao efetuada                         ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ          ณ               ณ                                            ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function RptDetail()

Private oFont03:= TFont():New("Arial",,03,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont04:= TFont():New("Arial",,04,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont05:= TFont():New("Arial",,05,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont06:= TFont():New("Arial",,06,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont07:= TFont():New("Arial",,07,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont08:= TFont():New("Arial",,08,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont09:= TFont():New("Arial",,09,,.f.,,,,,.F.) 		//Tamanhos de fonte
Private oFont10:= TFont():New("Arial",,10,,.f.,,,,,.F.) 		//Tamanhos de fonte
Private oFont10N:=TFont():New("Arial",,10,,.t.,,,,,.t.) 		//Tamanhos de fonte negrito
Private oFont11:= TFont():New("Arial",,11,,.f.,,,,,.F.)  		//Tamanhos de fonte
Private oFont12:= TFont():New("Arial",,12,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont14:= TFont():New("Arial",,14,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont16:= TFont():New("Arial",,16,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont18:= TFont():New("Arial",,18,,.f.,,,,,.f.)  		//Tamanhos de fonte
Private oFont24:= TFont():New("Arial",,24,,.f.,,,,,.f.)  		//Tamanhos de fonte


Private oPrn:=TMSPrinter():New()								// Declara o objeto a ser impresso

Private nCont := 1
Private nProx := 1
Private npag  := 1

//Filtra SD4
#IFDEF TOP
cQRY := ""
cQRY += "SELECT * "
cQRY += "FROM "+RetSqlname("SC2")+" SC2 WHERE SC2.D_E_L_E_T_ <> '*' AND C2_FILIAL BETWEEN  '"+MV_PAR01+"' AND  '"+MV_PAR02+"' "
cQRY += "AND SC2.C2_NUM+SC2.C2_ITEM+SC2.C2_SEQUEN BETWEEN '"+MV_PAR03+"' AND  '"+MV_PAR04+"' "

If Select("OPSC2") > 0
   DbselectArea("OPSC2")
   DbcloseArea()
Endif

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQRY),"OPSC2",.T.,.F.)

	DbSelectArea("OPSC2")
	Dbgotop()
	While OPSC2->(!Eof())
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
	
	oPrn:SetSize(215,297)
	oPrn:SetPortrait()     // ou SetLandscape()
	oPrn:StartPage() 	   // Inicia pagina
	IMPDIARIOB()  	       // Imprime Borda
	//IMPTXTFIX()    		   // Imprime Texto
	LI := 0
	CABECOP()               // Imprime dados da OP hsg
	oPrn:EndPage()	      	// Fim da Pagina
	
	#IFDEF TOP
		DbSelectArea("OPSC2")
		DbSkip()
	#ELSE
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
ฑฑณFun…o    ณIMPBORDA  ณ Autor ณ GUILHERME             ณ Data ณ 23.12.10 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณ IMRESSAO DIARIO DE BORDO				                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ IMPDIARIOB ()                                              ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ Generico                                                   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function IMPDIARIOB()

//                 0525
oPrn:Box(0035,0035,0455,2300)//CABECALHO
LI:= 045

oPrn:Say(LI,0700,"DIARIO DE BORDO ",oFont14,100)
//
//LI+= 70
oPrn:Box(0035,1600,0105,2300)//Nฐ OP
oPrn:Say(LI,1610,"Nฐ OP:",oFont12,100)
LI+= 70
oPrn:Box(0035,1600,0105,2300)    //QTD
oPrn:Say(LI,040,"PRODUTO:",oFont12,100)
oPrn:Say(LI,1610,"QTD:",oFont12,100)
LI+= 70
oPrn:Box(0035,1600,0175,2300 )    //ORIGEM  1850
oPrn:Say(LI,040,"EMISSAO:",oFont12,100)
oPrn:Say(LI,1610,"ORIGEM:",oFont12,100)
LI+= 70
oPrn:Box(0035,1600,0245,2300)    //MQ/RL
oPrn:Say(LI,040,"PREV.INอCIO:",oFont12,100)

oPrn:Say(LI,1610,"MQ/RL",oFont12,100)
LI+= 70
oPrn:Box(0035,1600,0315,2300)   //LOTE 1850
oPrn:Say(LI,040,"PREV.TษRMINO:",oFont12,100)
oPrn:Say(LI,1610,"LOTE:",oFont12,100)
LI+= 70
oPrn:Box(0035,1600,0385,2300)   //TURNO
oPrn:Box(0035,1600,0455,2300)   //TURNO
oPrn:Say(LI,1610,"TURNO:",oFont12,100)
LI+= 70
oPrn:Box(LI-10,0035,LI+46.6,2300)
oPrn:Say(LI,0038,"1 - Ocorr๊ncias de Prepara็ใo da Linha para Produ็ใo ",oFont10,100)
LI+= 46.6

oPrn:Box(LI,0035,LI+233,0110) //112
oPrn:SayBitmap(LI+10,040,_cBitDBR1,80,190)
//divisorias
//*/
oPrn:Box(LI,0110,LI+233,0660)
oPrn:Box(LI,0660,LI+233,0880)
oPrn:Box(LI,0880,LI+233,01100)
oPrn:Box(LI,01100,LI+233,01320)
//

//linhas

oPrn:Box(LI,0110,LI+46.6,2300)
oPrn:Say(LI,0112,"Descri็ใo"   ,oFont10,100)
oPrn:Say(LI,0692,"Inํcio"      ,oFont10,100)
oPrn:Say(LI,0944,"Fim"         ,oFont10,100)
oPrn:Say(LI,01106,"Total(min)" ,oFont10,100)
oPrn:Say(LI,01722,"Observa็๕es",oFont10,100)


LI+= 46.6
oPrn:Box(LI,0110,LI+46.6,2300)
oPrn:Say(LI,0112,"Limpeza da Linha com vapor",oFont10,100)
LI+= 46.6

oPrn:Box(LI,0110,LI+46.6,2300)
oPrn:Say(LI,0112,"Limpeza dos Filtros",oFont10,100)
LI+= 46.6

oPrn:Box(LI,0110,LI+46.6,2300)
oPrn:Say(LI,0112,"Verificacao do Produto",oFont10,100)
LI+= 46.6

oPrn:Box(LI,0110,LI+46.6,2300)
oPrn:Say(LI,0112,"Ajustes p/Partida",oFont10,100)


LI+= 46.6
oPrn:Box(LI,0035,LI+93.2,0220)
oPrn:SayBitmap(LI+23.6,042,_cBitDBR2,120,70)

oPrn:Box(LI,0220,LI+46.6,2300)
oPrn:Say(LI,0222,"Encerramento do Lote",oFont10,100)
//divisorias
oPrn:Box(LI,0220,LI+93.2,0660)
oPrn:Box(LI,0660,LI+93.2,0880)
oPrn:Box(LI,0880,LI+93.2,01100)
oPrn:Box(LI,01100,LI+93.2,01320)

LI+= 46.6
oPrn:Box(LI,0220,LI+46.6,2300)
oPrn:Say(LI,0222,"Limpeza",oFont10,100)
//
LI+= 46.6

oPrn:Box(LI,0035,LI+93.2,2300)
LI+= 46.6
oPrn:Say(LI,038,"2 - Ajustes Durante o Processo com Parada de Linha/Paradas para Manuten็ใo Corretiva (Lentilha)",oFont10,100)

LI+= 46.6

oPrn:Box(LI,0035,LI+326.4,2300)
oPrn:SayBitmap(LI+23,0110+5-75,_cBitd2_1,70,110)
oPrn:SayBitmap(LI+23,0110+((75-075)*1)+5,_cBitd2_2,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*1)+5,_cBitd2_3,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*2)+5,_cBitd2_4,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*3)+5,_cBitd2_5,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*4)+5,_cBitd2_6,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*5)+5,_cBitd2_7,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*6)+5,_cBitd2_8,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*7)+5,_cBitd2_9,70,110)


/*
_cBitd2_1:="d2_1.bmp" //ROTOFORM
_cBitd2_2:="d2_2.bmp" //ESTEIRA
_cBitd2_3:="d2_3.bmp" //BOMBA
_cBitd2_4:="d2_4.bmp" //VAPOR
_cBitd2_5:="d2_5.bmp" //AGUA
_cBitd2_6:="d2_6.bmp" //SILO
_cBitd2_7:="d2_7.bmp" //BALANCA
_cBitd2_8:="d2_8.bmp" //INKJET
_cBitd2_9:="d2_9.bmp" //OUTROS
_cBitSilo2:="SILO02.bmp"
_cBitSilo3:="SILO03.bmp"
_cBitSilo4:="SILO04.bmp"
_cBitSilo5:="SILO05.bmp"

*/
// logo vertical

oPrn:Box(LI,0035,LI+326.4,0110)
oPrn:Box(LI,0035,LI+326.4,0110+(075*1))
oPrn:Box(LI,0035,LI+326.4,0110+(075*2))
oPrn:Box(LI,0035,LI+326.4,0110+(075*3))
oPrn:Box(LI,0035,LI+326.4,0110+(075*4))
oPrn:Box(LI,0035,LI+326.4,0110+(075*5))
oPrn:Box(LI,0035,LI+326.4,0110+(075*6))
oPrn:Box(LI,0035,LI+326.4,0110+(075*7))
oPrn:Box(LI,0035,LI+326.4,0110+(075*8))

//
oPrn:Box(LI,0035,LI+326.4,(710+220) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*1) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*2) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*3) )

//
oPrn:Say(LI,715         ,"Parou a",oFont10,100)
oPrn:Say(LI,935+(130*0) ,"Inํcio" ,oFont10,100)
oPrn:Say(LI,935+(130*1) ,"Fim "   ,oFont10,100)
oPrn:Say(LI,935+(130*2) ,"Parada" ,oFont10,100)
//
oPrn:Say(LI+46.6,715,"Prod.",oFont10,100)
oPrn:Say(LI+46.6,935+(130*2),"Total",oFont10,100)
oPrn:Say(LI+46.6,01722,"Causas",oFont10,100)
//
oPrn:Say(LI+93.2,715,"Sim/Nใo",oFont10,100)
oPrn:Say(LI+93.2,935+(130*2),"(mim)",oFont10,100)


//DIVISรO
oPrn:Box(LI,0035,LI+140,2300)
//
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)

LI+= 186.4-46.6
//
//Segundo

oPrn:Box(LI,0035,LI+46.6,2300)

oPrn:Say(LI,038,"2 - Ajustes Durante o Processo com Parada de Linha/Paradas para Manuten็ใo Corretiva (Pำ)",oFont10,100)

LI+= 46.6

oPrn:Box(LI,0035,LI+326.4,2300)
oPrn:Box(LI,0035,LI+326.4,0110)
oPrn:Box(LI,0035,LI+326.4,0110+(075*1))
oPrn:Box(LI,0035,LI+326.4,0110+(075*2))
oPrn:Box(LI,0035,LI+326.4,0110+(075*3))
oPrn:Box(LI,0035,LI+326.4,0110+(075*4))
oPrn:Box(LI,0035,LI+326.4,0110+(075*5))
oPrn:Box(LI,0035,LI+326.4,0110+(075*6))
oPrn:Box(LI,0035,LI+326.4,0110+(075*7))
oPrn:Box(LI,0035,LI+326.4,0110+(075*8))

oPrn:Box(LI,0035,LI+326.4,(710+220) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*1) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*2) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*3) )
//
//logo
oPrn:SayBitmap(LI+23,0110+5-75,_cBitSilo2,70,110)
oPrn:SayBitmap(LI+23,0110+((75-075)*1)+5,_cBitSilo3,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*1)+5,_cBitSilo4,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*2)+5,_cBitSilo5,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*3)+5,_cBitd2_5,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*4)+5,_cBitd2_6,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*5)+5,_cBitd2_7,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*6)+5,_cBitd2_8,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*7)+5,_cBitd2_9,70,110)


/*
_cBitd2_1:="d2_1.bmp" //ROTOFORM
_cBitd2_2:="d2_2.bmp" //ESTEIRA
_cBitd2_3:="d2_3.bmp" //BOMBA
_cBitd2_4:="d2_4.bmp" //VAPOR
_cBitd2_5:="d2_5.bmp" //AGUA
_cBitd2_6:="d2_6.bmp" //SILO
_cBitd2_7:="d2_7.bmp" //BALANCA
_cBitd2_8:="d2_8.bmp" //INKJET
_cBitd2_9:="d2_9.bmp" //OUTROS
_cBitSilo2:="SILO02.bmp"
_cBitSilo3:="SILO03.bmp"
_cBitSilo4:="SILO04.bmp"
_cBitSilo5:="SILO05.bmp"
_cBitTanq:="TANQUE.bmp"
_cBitNrSi:="NUMSIM.bmp"
_cBitNrno:="NUMNAO.bmp"

*/
// logo vertical
//
oPrn:Say(LI,715          ,"Parou a",oFont10,100)
oPrn:Say(LI,935+(130*0) ,"Inํcio" ,oFont10,100)
oPrn:Say(LI,935+(130*1) ,"Fim "   ,oFont10,100)
oPrn:Say(LI,935+(130*2) ,"Parada" ,oFont10,100)
//
oPrn:Say(LI+46.6,715,"Prod.",oFont10,100)
oPrn:Say(LI+46.6,935+(130*2),"Total",oFont10,100)
oPrn:Say(LI+46.6,01722,"Causas",oFont10,100)
//
oPrn:Say(LI+93.2,715,"Sim/Nใo",oFont10,100)
oPrn:Say(LI+93.2,935+(130*2),"(mim)",oFont10,100)
//
//DIVISรO
oPrn:Box(LI,0035,LI+140,2300)
//
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)



//terceiro

LI+= 186.4-46.6
oPrn:Box(LI,0035,LI+46.6,2300)

oPrn:Say(LI,038,"2 - Ajustes Durante o Processo com Parada de Linha/Paradas para Manuten็ใo Corretiva (Tablete)",oFont10,100)

LI+= 46.6

oPrn:Box(LI,0035,LI+140,2300)
oPrn:Box(LI,0035,LI+140,0110+(075*2) )

oPrn:Box(LI,0035,LI+140,0110+(075*3))
oPrn:Box(LI,0035,LI+140,0110+37.5+(075*4))

oPrn:Box(LI,0035,LI+140,0110+(075*5))

oPrn:Box(LI,0035,LI+140,0110+(075*6))
oPrn:Box(LI,0035,LI+326.4,0110+37.5+(075*7))

//FECHO
oPrn:Box(LI,0110+(075*8) ,LI+326.4,2300 )

oPrn:Box(LI,0035,LI+326.4,(710+220) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*1) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*2) )
oPrn:Box(LI,0035,LI+326.4, 930+(130*3) )


//////////////////////////////
//logo
oPrn:SayBitmap(LI+23,40,_cBitTanq,200,120)

oPrn:SayBitmap(LI+23,0110+((075)*2)+5,_cBitNrSi,70,110)
oPrn:SayBitmap(LI+23,0110+((075)*5)+5,_cBitNrno,70,110)


/*
_cBitd2_1:="d2_1.bmp" //ROTOFORM
_cBitd2_2:="d2_2.bmp" //ESTEIRA
_cBitd2_3:="d2_3.bmp" //BOMBA
_cBitd2_4:="d2_4.bmp" //VAPOR
_cBitd2_5:="d2_5.bmp" //AGUA
_cBitd2_6:="d2_6.bmp" //SILO
_cBitd2_7:="d2_7.bmp" //BALANCA
_cBitd2_8:="d2_8.bmp" //INKJET
_cBitd2_9:="d2_9.bmp" //OUTROS
_cBitSilo2:="SILO02.bmp"
_cBitSilo3:="SILO03.bmp"
_cBitSilo4:="SILO04.bmp"
_cBitSilo5:="SILO05.bmp"
_cBitTanq:="TANQUE.bmp"
_cBitNrSi:="NUMSIM.bmp"
_cBitNrno:="NUMNAO.bmp"

*/
// logo vertical
//
oPrn:Say(LI,715          ,"Parou a",oFont10,100)
oPrn:Say(LI,935+(130*0) ,"Inํcio" ,oFont10,100)
oPrn:Say(LI,935+(130*1) ,"Fim "   ,oFont10,100)
oPrn:Say(LI,935+(130*2) ,"Parada" ,oFont10,100)
//
oPrn:Say(LI+46.6,715,"Prod.",oFont10,100)
oPrn:Say(LI+46.6,935+(130*2),"Total",oFont10,100)
oPrn:Say(LI+46.6,01722,"Causas",oFont10,100)
//
oPrn:Say(LI+93.2,715,"Sim/Nใo",oFont10,100)
oPrn:Say(LI+93.2,935+(130*2),"(mim)",oFont10,100)
//
//DIVISรO
oPrn:Box(LI,0035,LI+140,2300)
//
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
oPrn:Say(LI+93.4,0112,"BOMBA ",oFont10,100)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
oPrn:Say(LI+93.4,0112,"ENTABLETADORA",oFont10,100)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
oPrn:Say(LI+93.4,0112,"COMP. REFRIGERAวรO",oFont10,100)
LI+= 46.6
oPrn:Box(LI+140,0035,LI+140,2300)
oPrn:Say(LI+93.4,0112,"ELETRICA",oFont10,100)

LI+= 186.4
oPrn:Box(LI-46.6,0035,3290 ,2300)
//// parte escrita
oPrn:Say(LI,038,"3. Inspe็ใo Visual da Impressใo / Etiqueta "   ,oFont10N,100)
LI+= 46.6

LI+= 46.6
//oPrn:Box(LI,0110,LI+46.6,2300)
oPrn:Say(LI,0112,"OK       (   )       Necessita Corre็ใo? (   )    (   ) Nใo      Corre็ใo a ser feita ____________________________",oFont10,100)
LI+= 46.6

LI+= 46.6
oPrn:Say(LI,038,"4. Ocorr๊ncias e Pessoal (Nro. de Operadores, falta, atrasos, troca de horแrio) "   ,oFont10N,100)
LI+= 46.6+23
oPrn:Box(LI,035,LI,2300)

LI+= 46.6
LI+= 46.6
oPrn:Say(LI,038,"5. Condi็๕es de Limpeza e Organiza็ใo da มrea: "   ,oFont10N,100)
LI+= 46.6 //+23
LI+= 46.6
oPrn:Say(LI,112,"Bom   (   )    Aceitแvel    (   )       Regular     (   )     Inaceitแvel    (   ) "   ,oFont10,100)
LI+= 46.6
LI+= 46.6
oPrn:Say(LI,038,"6. Embalagens danificadas    __________________________________________________________________________ "   ,oFont10N,100)

LI+= 46.6
LI+= 46.6
oPrn:Say(LI,038,"7. Residuo Gerado: "   ,oFont10N,100)
LI+= 46.6+30
oPrn:Say(LI,038,"Limpo                                   Limpo Nใo  "   ,oFont10,100)
LI+= 46.6
oPrn:Say(LI,038,"Reutilizado   __________________Kg      Reutilizado   __________________Kg      Sujo   __________________Kg "   ,oFont10,100)
LI+= 46.6
LI+= 46.6
oPrn:Say(LI,038,"8. Checagem Final do Produto Embalado - Todos os carros Ok?            Sim (    )  "   ,oFont10N,100)
LI+= (46.6*2)
oPrn:Say(LI,038,"Corre็ใo a ser feita __________________________________________________ "   ,oFont10,100)

LI+= (46.6*2)
oPrn:Say(LI,038,"Responsแvel pela verifica็ใo __________________________________________ "   ,oFont10,100)

//---------------------------------------------------------------------------------------
// Codigo de Barra
//MSBAR("INT25",25.5,1,"00000000000",oPrn,.F.,Nil,Nil,0.025,1.5,Nil,Nil,"A",.F.)
MsBar("INT25"  ,13.35,07,"00000000000001"  ,oPrn,.F.,,,0.012,.70,,,,.F.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIMPOPS    บAutor  ณTrade               บ Data ณ  23/03/11   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime variaveis                                          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABECOP()

Local LII := 0


#IFDEF TOP
	
	IF MV_PAR09 == 2
		LII := 45
		oPrn:Say(LI,1860,ALLTRIM(OPSC2->(C2_NUM+C2_ITEM+C2_SEQUEN)),oFont16,100)
		//
		LII := 108
		oPrn:Say(115,1860,ALLTRIM(TRANSFORM(OPSC2->C2_QUANT, '@E 9,999,999')),oFont16,100)
		LII := 240
		SB1->(DbSetOrder(1) )
		SB1->(DbSeek(xfilial("SB1")+OPSC2->C2_PRODUTO ))
		oPrn:Say(115,0342,ALLTRIM(OPSC2->C2_PRODUTO)+" - "+ALLTRIM(SB1->B1_DESC) ,oFont10,100)
		//
		
		SM4->(DbSetOrder(1) )
		SM4->(DbSeek(xfilial("SM4")+MV_PAR05))
		LII := 185
		oPrn:Say(LII,1860,ALLTRIM(substr(SM4->M4_DESCR,1,10)),oFont16,100)
		
		LII := 185
		oPrn:Say(LII,0342,ALLTRIM(substr(OPSC2->C2_EMISSAO,7,2)+"/"+substr(OPSC2->C2_EMISSAO,5,2)+"/"+substr(OPSC2->C2_EMISSAO,1,4)),oFont10,100)
		//
		//prev inicio e MQ/RL
		
		LII := 255
		oPrn:Say(LII,0342,ALLTRIM(substr(OPSC2->C2_DATPRI,7,2)+"/"+substr(OPSC2->C2_DATPRI,5,2)+"/"+substr(OPSC2->C2_DATPRI,1,4)),oFont10,100)
		oPrn:Say(LII,1860, MV_PAR06 ,oFont10,100)
		
		//PREV. FINAL E LOTE
		LII := 325
		oPrn:Say(LII+5,0343,ALLTRIM(substr(OPSC2->C2_DATPRF,7,2)+"/"+substr(OPSC2->C2_DATPRF,5,2)+"/"+substr(OPSC2->C2_DATPRF,1,4)),oFont10,100)
		oPrn:Say(LII,1860, MV_PAR07 ,oFont10,100)
		//
		LII := 395
		oPrn:Say(LII,1860, MV_PAR08 ,oFont10,100)
		
		LII := 710
		
	ENDIF
	
#ELSE
	
	/*
	LI:= 045
	
	oPrn:Say(LI,0700,"DIARIO DE BORDO ",oFont14,100)
	//
	//LI+= 70
	oPrn:Box(0035,1600,0105,2300)//Nฐ OP
	oPrn:Say(LI,1610,"Nฐ OP:",oFont12,100)
	LI+= 70
	
	oPrn:Box(0035,1600,0105,2300)    //QTD
	oPrn:Say(LI,040,"PRODUTO:",oFont12,100)
	oPrn:Say(LI,1610,"QTD:",oFont12,100)
	LI+= 70
	oPrn:Box(0035,1600,0175,2300 )    //ORIGEM  1850
	oPrn:Say(LI,040,"EMISSAO:",oFont12,100)
	oPrn:Say(LI,1610,"ORIGEM:",oFont12,100)
	LI+= 70
	oPrn:Box(0035,1600,0245,2300)    //MQ/RL
	oPrn:Say(LI,040,"PREV.INอCIO:",oFont12,100)
	
	oPrn:Say(LI,1610,"MQ/RL",oFont12,100)
	LI+= 70
	oPrn:Box(0035,1600,0315,2300)   //LOTE 1850
	oPrn:Say(LI,040,"PREV.TษRMINO:",oFont12,100)
	oPrn:Say(LI,1610,"LOTE:",oFont12,100)
	LI+= 70
	oPrn:Box(0035,1600,0385,2300)   //TURNO
	oPrn:Box(0035,1600,0455,2300)   //TURNO
	oPrn:Say(LI,1610,"TURNO:",oFont12,100)
	LI+= 70
	
	*/
	SB1->(DbSelectArea("SB1") )
	SB1->(DbSetOrder(1) )
	SB1->( DbSeek(xfilial("SB1")+SC2->C2_PRODUTO) )
	IF MV_PAR09 == 2
		
		LII := 45
		oPrn:Say(LII,1860,ALLTRIM(SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN) ,oFont16,100)
		//
		LII := 108
		oPrn:Say(115,1860,ALLTRIM(TRANSFORM(SC2->C2_QUANT, '@E 9,999,999')) ,oFont16,100)
		LII := 240
		SB1->(DbSetOrder(1) )
		SB1->(DbSeek(xfilial("SB1")+SC2->C2_PRODUTO ))
		oPrn:Say(115,0342,ALLTRIM(SC2->C2_PRODUTO)+" - "+ALLTRIM(SB1->B1_DESC),oFont10,100)
		//
		
		SM4->(DbSetOrder(1) )
		SM4->(DbSeek(xfilial("SM4")+MV_PAR05))
		LII := 185
		oPrn:Say(LII,1860,ALLTRIM(substr(SM4->M4_DESCR,1,10)),oFont16,100)
		
		LII := 185
		oPrn:Say(LII,0342,ALLTRIM(substr(DTOS(SC2->C2_EMISSAO),7,2)+"/"+substr(DTOS(SC2->C2_EMISSAO),5,2)+"/"+substr(DTOS(SC2->C2_EMISSAO),1,4)) ,oFont10,100)
		//
		//prev inicio e MQ/RL
		
		LII := 255
		oPrn:Say(LII,0342,ALLTRIM(substr(DTOS(SC2->C2_DATPRI),7,2)+"/"+substr(DTOS(SC2->C2_DATPRI),5,2)+"/"+substr(DTOS(SC2->C2_DATPRI),1,4)),oFont10,100)
		oPrn:Say(LII,1860, MV_PAR06 ,oFont10,100)
		
		//PREV. FINAL E LOTE
		LII := 325
		oPrn:Say(LII+5,0343,ALLTRIM(substr(DTOS(SC2->C2_DATPRF),7,2)+"/"+substr(DTOS(SC2->C2_DATPRF),5,2)+"/"+substr(DTOS(SC2->C2_DATPRF),1,4)),oFont10,100)
		oPrn:Say(LII,1860, MV_PAR07 ,oFont10,100)
		//
		LII := 395
		oPrn:Say(LII,1860, MV_PAR08 ,oFont10,100)
		
	ENDIF
	
#Endif


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

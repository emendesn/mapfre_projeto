//#INCLUDE "rwmake.ch
//#INCLUDE "TOPCONN.CH"

User Function EST02()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Local cDesc1        := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2        := "de acordo com os parametros informados pelo usuario."
Local cDesc3        := "Calculo do Fator de Venda"
Local cPict         := ""
Local titulo        := "Calculo do Fator de Venda"
Local nLin          := 80

Local Cabec1        := ""
Local Cabec2        := ""
Local imprime       := .T.

Private aOrd        := {"Nome de Cliente","Descricao de Produto","Numero da Oferta"}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private CbTxt       := ""
Private limite      := 220 //132
Private tamanho     := "G" //"M"
Private nomeprog    := "EST02"
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey    := 0
Private cPerg       := "EST02"
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private wnrel       := "EST02"
Private cString     := "SB1"

dbSelectArea("SB1")
dbSetOrder(1)

Pergunte(cPerg,.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Monta a interface padrao com o usuario...                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.T.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)                        
Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    쿝UNREPORT � Autor � AP6 IDE            � Data �  31/03/05   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o � Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS 볍�
굇�          � monta a janela com a regua de processamento.               볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery     := ""

IF SELECT("TRB") <> 0
	TRB->(DBCLOSEAREA())
ENDIF

dbSelectArea(cString)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� mv_par01 -> Area de Vendas: (C)Comutadores (E)Eletronicos (P)Pecas  �
//� mv_par02 -> Data de Emissao Inicial                                 �
//� mv_par03 -> Data de Emissao Final                                   �
//� mv_par04 -> Codigo do Cliente Inicial                               �
//� mv_par05 -> Codigo do Cliente Final                                 �
//� mv_par06 -> Familia                                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//If MV_PAR01 == 1
//	_cAreaVen := "C"
//ElseIf MV_PAR01 == 2
//	_cAreaVen := "E"
//Else
//	_cAreaVen := "P"
//EndIf

nOrdem := aReturn[8]

If nOrdem == 1         //Nome de Cliente
	//           "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//           "0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	Cabec1    := "CLIENTE               OFERTA      DATA      CLIENTE FINAL                             PAIS  MOEDA  GRUPO  PRODUTO          DESCRICAO                                              QUANTIDADE   VALOR UNIT   FATOR    CAMBIO"
	Titulo    := Alltrim(Titulo) + " - Por Nome de Cliente"
//	_cOrderBy := " ORDER BY GRP.ZD_FILIAL, A1_NREDUZ, GRP.ZD_NUM, GRP.ZD_GRUPO "
ElseIf nOrdem == 2     //Descricao de Produto
	//           "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//           "0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	Cabec1    := "PRODUTO                                             CODIGO           OFERTA      DATA      CLIENTE               CLIENTE FINAL                             PAIS  MOEDA  GRUPO     QUANTIDADE   VALOR UNIT   FATOR    CAMBIO"
	Titulo    := Alltrim(Titulo) + " - Por Descri豫o de Produto"
	_cOrderBy := " ORDER BY GRP.ZD_FILIAL, ZD_DESCRI "
ElseIf nOrdem == 3     //Numero da Oferta
	//           "01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
	//           "0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
	Cabec1    := "OFERTA      DATA      CLIENTE               CLIENTE FINAL                             PAIS  MOEDA  GRUPO  PRODUTO          DESCRICAO                                              QUANTIDADE   VALOR UNIT   FATOR    CAMBIO"
	Titulo    := Alltrim(Titulo) + " - Por N�mero de Oferta"
	_cOrderBy := " ORDER BY GRP.ZD_FILIAL, GRP.ZD_NUM, GRP.ZD_GRUPO "
Endif


	//旼컴컴컴커
	//� SELECT �
	//읕컴컴컴켸
	cQuery := "SELECT SB2.B2_COD COD"      // 01
	cQuery += ", SB1.B1_TIPO TIPO"         // 02
	cQuery += ", SB1.B1_GRUPO GRUPO"       // 03
	cQuery += ", SB1.B1_DESC DESCRI"       // 04
	cQuery += ", SB1.B1_UM UM"             // 05
	//旼컴컴커
	//� FROM �
	//읕컴컴켸
	cQuery += (" FROM "+RetSqlName('SB2')+" SB2, "+RetSqlName('SB1')+" SB1")
	//旼컴컴컴�
	//� WHERE �
	//읕컴컴컴�
	cQuery += " WHERE"
	cQuery += ("     SB2.B2_QATU >= 0 ")
	cQuery +=  " AND    SB1.B1_COD  = SB2.B2_COD"
	cQuery +=  " AND SB2.D_E_L_E_T_ = ' '"
	cQuery +=  " AND SB1.D_E_L_E_T_ = ' '"
	cQuery += (" AND SB2.B2_FILIAL  >='" + mv_par02 + "'")
	cQuery += (" AND SB2.B2_FILIAL  <='" + mv_par03 + "'")
	cQuery += " AND SB1.B1_FILIAL = SB2.B2_FILIAL"

	//旼컴컴컴컴커
	//� GROUP BY �
	//읕컴컴컴컴켸

//	cQuery += " GROUP BY SB2.B2_GRUPO"
      
	//旼컴컴컴컴커
	//� ORDER BY �
	//읕컴컴컴컴켸

	cQuery += " ORDER BY SB1.B1_COD"


  //	cQuery := ChangeQuery(cQuery)
//	MsAguarde({|| dbUseArea(.T.,'TOPCONN', TCGenQry(,,cQuery),.F.,.T.)}) //"Selecionando Registros ..."


//cQuery += _cOrderBy

//cQuery := ChangeQuery(cQuery)

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB",.T.,.T.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SetRegua(RecCount())

dbSelectArea("TRB")
dbGoTop()



   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
   //� Verifica o cancelamento pelo usuario...                             �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
   

   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
   //� Impressao do cabecalho do relatorio. . .                            �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
   If nLin > 55
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
   Endif

//	_cEmissao := Right(TRB->ZC_EMISSAO,2) + "/" + Substr(TRB->ZC_EMISSAO,5,2) + "/" + Substr(TRB->ZC_EMISSAO,3,2)
	_cEmissao := DDATABASE
//	If nOrdem == 1  // Por Cliente
		@nLin,000 PSAY SB2->B2_COD
		@nLin,022 PSAY SB1->B1_TIPO
//		@nLin,032 PSAY _cEmissao
		@nLin,044 PSAY SB1->B1_DESC
		@nLin,086 PSAY SB1->B1_GRUPO
//	@nLin,175 PSAY TRB->ZD_QTDVEN   PICTURE "@E 99,999,999.99"
//	@nLin,187 PSAY TRB->VALOFE / TRB->ZD_QTDVEN     PICTURE "@E 99,999,999.99"
//	@nLin,202 PSAY TRB->FATOR       PICTURE "@E 999.99"
//	@nLin,211 PSAY TRB->ZC_CAMBIO   PICTURE "@E 99.9999"

   nLin := nLin + 1

//	@nLin,_nPosTrafo PSAY "Id Trafo:        " + TRB->ZD_IDTRAFO
//	_cTrTipo := Iif(TRB->ZC_TRTIPO == "A","Auto-Trafo",Iif(TRB->ZC_TRTIPO == "B","Transformador"," "))
//	Do Case
//		Case TRB->ZC_TRSERV == "R"
//			_cTrServ := "Rede"
//		Case TRB->ZC_TRSERV == "G"
//			_cTrServ := "Geracao"
//		Case TRB->ZC_TRSERV == "F"
//			_cTrServ := "Forno"
//		Case TRB->ZC_TRSERV == "E"
//			_cTrServ := "Eletrolise"
//		OtherWise
//			_cTrServ := " "
//	EndCase
//	_cTrFreq := Iif(TRB->ZC_TRFREQ == "A", "50 Hz", Iif(TRB->ZC_TRFREQ == "B", "60 Hz", " "))
//	_cTrTemp := Iif(TRB->ZC_TRTEMP == "A", "-30 a +50 C", Iif(TRB->ZC_TRTEMP == "B", "-40 a +50 C (artico)", " "))

//	@nLin,000 PSAY "Caract.Trafo: " //14
//	@nLin,015 PSAY "Tipo Tranf. "   + _cTrTipo //12 C 1              +13
//	@nLin,042 PSAY "Serv. em "      + _cTrServ //09 C 1              +10
//	@nLin,060 PSAY "Pot. MVA "      + Alltrim(Transform(TRB->ZC_TRPOT,"@E 9,999.99"))  //09 N 7 2  9,999.99  +08
//	@nLin,080 PSAY "Freq. "         + _cTrFreq //07 C 1              +05
//	@nLin,096 PSAY "Uff (Kv) "      + Alltrim(Transform(TRB->ZC_TRUFF,"@E 999.99"))  //09 N 6 2    999.99  +06
//	@nLin,112 PSAY "Regul. + "      + Alltrim(Transform(TRB->ZC_TRREGP,"@E 999.99")) //09 N 6 2    999.99  +06
//	@nLin,128 PSAY "Regul. - "      + Alltrim(Transform(TRB->ZC_TRREGN,"@E 999.99")) //09 N 6 2    999.99  +06
//	@nLin,144 PSAY "% Regul. "      + Alltrim(Transform(TRB->ZC_TRREGX,"@E 999.99")) //09 N 6 2    999.99  +06
//	@nLin,160 PSAY "Ust (V) "       + Alltrim(Transform(TRB->ZC_TRUST,"@E 9999.99"))  //08 N 7 2   9999.99  +07
//	@nLin,176 PSAY "Imax (A) "      + Alltrim(Transform(TRB->ZC_TRIMAX,"@E 9999.99")) //09 N 7 2   9999.99  +07
//	@nLin,194 PSAY "Temp. "         + _cTrTemp //06 C 1              +20

//   nLin := nLin + 1
//	@nLin,000 PSAY Replicate("-",limite)
//   nLin := nLin + 1
//	TRB->(DBSKIP())

//ENDDO

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Copia os dados do relatorio para arquivo XLS                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
cArqExel := "\SYSTEM\MODELOS\EST02.XLS"
Copy to &cArqExel

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Fecha arquivo temporario criado pela Query SQL                      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
TRB->(DBCLOSEAREA())

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Finaliza a execucao do relatorio...                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
SET DEVICE TO SCREEN

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Se impressao em disco, chama o gerenciador de impressao...          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return


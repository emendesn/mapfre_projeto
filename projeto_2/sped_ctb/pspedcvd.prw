#include "rwmake.ch"
#include "fileio.ch"

USER Function PSPEDCVD()

Private _cNomeArq1 := space(70)

@ 000,000 TO 230,470 DIALOG _oDlg TITLE "Leitura de arquivo PRN"
@ 005,005 TO 050,230
@ 010,010 Say "Esta rotina estara gerando o para CVD a partir"
@ 020,010 Say "de arquivo no formato PRN pre-configurado."

@ 035,010 Say "Informe Abaixo"
@ 055,005 SAY "Arquivo...."
@ 055,035 GET _cNomeArq1  Picture '@!' Size 160,9 When .T.
@ 055,200 BMPBUTTON TYPE 5 ACTION F_VERARQ1()

@ 100,170 BMPBUTTON TYPE 1 ACTION Processa({|lEnd| F_IMPORTA(_cNomeArq1)}, 'Processando...')
@ 100,200 BMPBUTTON TYPE 2 ACTION Close(_oDlg)
ACTIVATE DIALOG _oDlg CENTERED

Return

/*************************************************************/
Static Function F_VERARQ1()
_cNomeArq1 := cGetFile("Cadastro|*.*",OemToAnsi("Selecione o Arquivo..."))
_oDlg:Refresh()
Return

/*************************************************************/
Static Function F_IMPORTA(cArq)
Local _cBuffer := ''
Local _xBuffer := ''
Local _nconta := 0

If !File(Alltrim(cArq))
	MsgStop("Arquivo Informado - Nao Encontrado")
	Return
Endif
close(_oDlg)

//Abre o arquivo
FT_FUSE(cArq)

//Posiciona no inicio
FT_FGOTOP()

ProcRegua(FT_FLASTREC())

While !FT_FEOF()
	_nconta ++
	IncProc("Incluido Linha..."+strzero(_nconta,15))
	
	_cBuffer := FT_FREADLN()
	
	dbSelectArea("CVD")
	dbSetOrder(1)        
	If empty(substr(_cBuffer,1,20))
		FT_FSKIP()
		loop
	EndIf	
	
	If ! dbseek(xfilial("CVD")+alltrim(substr(_cBuffer,1,20)))
		RecLock("CVD",.t.)
		CVD_ENTREF := "10"
		CVD_CTAREF := UPPER(alltrim(substr(_cBuffer,21)))
		CVD_CONTA := UPPER(alltrim(substr(_cBuffer,1,20)))
		CVD_CODPLA := "001"
		MsUnLock()
	Endif
	FT_FSKIP()
	
Enddo

FT_FUSE()							//Fecha o arquivo texto.

RETURN()
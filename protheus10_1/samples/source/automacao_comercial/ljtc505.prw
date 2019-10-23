#INCLUDE "PROTHEUS.CH"   
#INCLUDE "LJTC505.CH"

#DEFINE SEPARADOR "|"                          // utilizado com delimitador na gera��o do arquivo

User Function LJTC505()                        // "dummy" function - Internal Use
	Local oArqTC505 := Nil                     // objeto da Classe LJCGeraArqTC505
	oArqTC505 := LJCGeraArqTC505():New()  
Return

/*
������������������������������������������������������������������������������������
������������������������������������������������������������������������������������
��������������������������������������������������������������������������������ͻ��
���Classe    �LJCGeraArqTC505  �Autor  �Vendas Clientes     � Data �  23/06/08   ���
��������������������������������������������������������������������������������͹��
���Desc.     �Classe responsavel em gerar arquivo de produtos                    ���
���          �sera lido pelo Terminal de Consulta TC505 da GERTEC       	     ���
��������������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                  		 ���
��������������������������������������������������������������������������������ͼ��
������������������������������������������������������������������������������������
������������������������������������������������������������������������������������
*/
Class LJCGeraArqTC505     

	Data oArquivo                                              //Objeto para manupulacao de dados
	Data cPath                                                 //Caminho para o arquivo
	Data cNomeArq                                              //Nome do arquivo
	Data cArquivo                                              //Nome do arquivo + Path
	Data lRetorno                                              //Passa retorno dos metodos
    Data aProdutos                                             //Array onde ser� armazenado Codigo, Descri��o e Pre�o
	
	Method New()                                               //Construtor da Classe
	Method Executar()                                          //Method que Executa os Metodos outros Metodos da Classe e Verifica os Retornos
	Method PegaPath()                                          //Metodo responsavel em pegar path do arquivo informado pelo usuario
	Method RenCriar()                                          //Metodo que renomeia e cria um arquivo novo
	Method BuscaProd()                                         //Metodo que busca os produtos 
    Method Escreve()                                           //Metodo que escreve no arquivo
    Method FormatVal()                                         //Metodo que formata o pre�o dos produtos

EndClass

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Metodo    �New       �Autor  �Vendas Clientes     � Data �  23/06/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Construtor da classe LJCGeraArqTC505  		              ���
�������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                    ���
�������������������������������������������������������������������������͹��
���Parametros�                                              			  ���
���          �                                          			      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method New() Class LJCGeraArqTC505     
    ::oArquivo:= Nil
	::cPath:= "" 
	::cNomeArq:= ""
	::cArquivo:= ""
	::lRetorno:= .F.      
    ::aProdutos:= {}      
	::Executar() 
Return Self

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Metodo    �Executar  �Autor  �Vendas Clientes     � Data �  23/06/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Executa os Metodos da Classe e Verifica os Retornos         ���
�������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                    ���
�������������������������������������������������������������������������͹��
���Parametros�                                                            ���
���          �   			                                              ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method Executar() Class LJCGeraArqTC505

	//n�o tem path ou foi precionado a tecla cancela
	If ::PegaPath() == .F.
	    Return()
	EndIf
	
	::oArquivo:= LJCArquivo():New(::cArquivo)

	//nao conseguiu renomear ou criar o arquivo 	
	If ::RenCriar() == .F.     
	    Alert(STR0001)
	    Return()
	EndIf

    //carrega array aProdutos
    ::BuscaProd()           
    
    //n�o consegui escrever no arquivo
    If ::Escreve() == .F.
	    Alert(STR0002)
	    Return()
    EndIf      
      
    //n�o consegui fechar o arquivo
   	If ::oArquivo:Fechar() == .F.         
	    Alert(STR0003)
	    Return()
   	EndIf        
   	                                
   	//apresenta mensagem de Sucesso
   	MsgAlert(STR0004,STR0005)

Return(Nil) 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Metodo    �PegaPath  �Autor  �Vendas Clientes     � Data �  23/06/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Monta tela e pega o Path do Arquivo informado pelo Usuario  ���
�������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                    ���
�������������������������������������������������������������������������͹��
���Parametros�                                               			  ���
�������������������������������������������������������������������������ͺ��
���Retorno   �::lRetorno:= retorno logico do Metodo                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method PegaPath() Class LJCGeraArqTC505

   Local cMask  := PadR('Texto (*.txt)',27) + '|*.txt|' + PadR('Todos (*.*)',27)+ '|*.*|'     // mascara passada para Fun��o cGetFile
   Local oGrupo := Nil                                                                         // objeto grupo box
   Local oGet   := Nil                                                                         // objeto caixa de texto
   Local oDlg   := Nil                                                                         // objeto janela de dialogo
   Local nOpca  := 0                                                                           // indica que bot�o foi precionado

   DEFINE MSDIALOG oDlg TITLE "Gera Arquivo" FROM 323,412 TO 450,800 PIXEL STYLE DS_MODALFRAME STATUS

   oGrupo := TGroup():New(5,2,62,195,"Arquivo de Pre�o de Produtos",,,,.T.)                          
   
   oGet := TGet():New(14,8, bSETGET(::cArquivo),,150,10,,,,,,,,.T.,,,,,,,.T.,,,)

   SButton():New(14,160,14,{|| ::cArquivo := cGetFile(cMask, "Selecione o Arquivo",0,,.F.,GETF_LOCALHARD + GETF_OVERWRITEPROMPT)},)
 
   DEFINE SBUTTON FROM 45, 70 TYPE 1 ACTION (nOpca:= 1, oDlg:End());
   ENABLE OF oDlg
    
   DEFINE SBUTTON FROM 45, 101 TYPE 2 ACTION (nOpca:= 2, oDlg:End());
   ENABLE OF oDlg
      
   ACTIVATE MSDIALOG oDlg CENTERED                         
   
   If nOpca == 1 .AND. ::cArquivo <> ""
      ::lRetorno:= .T.
   EndIf
	
Return(::lRetorno) 

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Metodo    �RenCriar  �Autor  �Vendas Clientes     � Data �  23/06/08   ���
�������������������������������������������������������������������������͹��
���Desc.     |Renomeia o arquivo ******_old.*** e cria um novo            ���
�������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                    ���
�������������������������������������������������������������������������͹��
���Parametros�                                              			  ���
�������������������������������������������������������������������������ͺ��
���Retorno   �::lRetorno:= retorno logico do Metodo                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method RenCriar()Class LJCGeraArqTC505   

	Local nRetorno:= 0                        // recebe o retorno da fun��o Remonear do objeto ::oArquivo

	If ::oArquivo:Existe(::cArquivo)                     
	    
	    // renomeia o arquivo adicionando "_OLD" no seu fim
	    nRetorno:= ::oArquivo:Renomear(Stuff(::cArquivo,RAT(".",::cArquivo),1,"_OLD."))
	    
		If(nRetorno > -1)
		   ::lRetorno:= ::oArquivo:Criar()	
		Else
		   ::lRetorno:= .F.   
		EndIf
		
	EndIf      
	
Return(::lRetorno) 
          
/*
������������������������������������������������������������������������������
������������������������������������������������������������������������������
��������������������������������������������������������������������������ͻ��
���Metodo    �BuscaProd �Autor  �Vendas Clientes     � Data �  23/06/08    ���
��������������������������������������������������������������������������͹��
���Desc.     �Busca os Produtos no formato:                                ���
���          �    - Codigo de Barras|Descri��o|Pre�o de Venda|             ���
���          �Carrega array aProdutos                                      ���
��������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                     ���
��������������������������������������������������������������������������͹��
���Parametros�                                              			   ���
���          �                                          			       ���
��������������������������������������������������������������������������ͼ��
������������������������������������������������������������������������������
������������������������������������������������������������������������������
*/
Method BuscaProd() Class LJCGeraArqTC505
	
	Local cCodBar    := ""                   // recebe codigo de barras da tabela SB1->B1_CODBAR
	Local cDescricao := ""                   // recebe a descricao do produto da tabela SB1->B1_DESC
	Local nPreco     := 0                    // recebe o preco do produto da tabela SB1->B1_PRV1 

	dbSelectArea("SB1")
	dbsetorder(1)
	dbSeek(xFilial("SB1"))
	
	While !Eof()
		cCodBar   := SB1->B1_CODBAR
		cDescricao:= SB1->B1_DESC
		nPreco    := SB1->B1_PRV1

		AADD(::aProdutos, {ALLTRIM(cCodBar), RTRIM(cDescricao), nPreco})
		SB1->(dbSkip())
	End 
	
Return(Nil)  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Metodo    �Escreve   �Autor  �Vendas Clientes     � Data �  23/06/08   ���
�������������������������������������������������������������������������͹��
���Desc.     �Adciona informa��es no Arquivo                              ���
�������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                    ���
�������������������������������������������������������������������������͹��
���Parametros�                                               			  ���
�������������������������������������������������������������������������ͺ��
���Retorno   �::lRetorno:= retorno logico do Metodo                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method Escreve() Class LJCGeraArqTC505

	Local cTexto := ""                       // linha de informacao que ser� gravada no arquivo
	Local nCont  := 0                        // variavel auxiliar utilizada no For                       	

	For nCont:= 1 To Len(::aProdutos)
		
		//contatena codigo do produto com descricao e preco formado pelo metodo FormatVal()
		cTexto:= ::aProdutos[nCont][1] + SEPARADOR + ::aProdutos[nCont][2] + SEPARADOR ;
		         + ::FormatVal(::aProdutos[nCont][3]) + SEPARADOR
		         
	    ::lRetorno:= ::oArquivo:Escrever(cTexto)
	Next	    
	
Return(::lRetorno)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Metodo    �FormatVal �Autor  �Vendas Clientes     � Data �  23/06/08   ���
�������������������������������������������������������������������������͹��
���Desc.     |Formata o preco com 2 casas decimais  		              ���
�������������������������������������������������������������������������͹��
���Uso       �SigaLoja                                                    ���
�������������������������������������������������������������������������͹��
���Parametros�nPreco:= preco n�o formatado                     			  ���
�������������������������������������������������������������������������ͺ��
���Retorno   �xRetorno:= Retorna um caracter como valor com 2 casas       ���
���          �           decimais                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Method FormatVal(nPreco) Class LJCGeraArqTC505  

	Local xRetorno:= 0                       // o retorno do metodo que recebe um numero e retorno um caracter
	
    nPreco*= 100
	xRetorno:= Transform(nPreco, "9999999999,99")
	
Return(ALLTRIM(CVALTOCHAR(xRetorno)))

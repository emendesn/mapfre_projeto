#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

User Function Eicpo15s()        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de variaveis utilizadas no programa atraves da funcao    �
//� SetPrvt, que criara somente as variaveis definidas pelo usuario,    �
//� identificando as variaveis publicas do sistema utilizadas no codigo �
//� Incluido pelo assistente de conversao do AP5 IDE                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetPrvt("ACAMPOS,CNOMARQ,")

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴엽�
굇� Rotina para ser executada chamada a partir de um RDMake  -  A.W.R.    낢�
굇�                                                                       낢�
굇� Cliente :  Sadia.                                                     낢�
굇�                                                                       낢�
굇� - Faz parte do EICPO150.PRW ( Emissao do Pedido );                    낢�
굇� - Serve como acumulador de quantidades para os itens que tem em comun 낢�
굇�   o Numero a Data Prev. o Fabricante e o Preco;                       낢�
굇� - Deixando bater apenas os itens que nao tem essas caracteristicas    낢�
굇�   iguais;                                                             낢�
굇읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/

IF lCriaWork
   aCampos:={"W3_CC"    ,"W3_SEQ",;
             "W3_COD_I" , "W3_FABR", "W3_FORN" ,;
             "W3_PRECO" , "W3_QTDE", "W3_DT_EMB"}

   cNomArq:=E_CriaTrab()

   INDEX ON W3_COD_I+W3_FABR+DTOS(W3_DT_EMB)+STR(W3_PRECO,15,5) TO (cNomArq)

ELSE

   TRB->(__DBZAP())
   SW3->(dbSeek(XFILIAL("SW3")+SW2->W2_PO_NUM))

   While SW3->(!Eof()) .AND. SW3->W3_FILIAL == XFILIAL("SW3") .AND.;
                             SW3->W3_PO_NUM == SW2->W2_PO_NUM

       If SW3->W3_SEQ #0
          SW3->(DBSKIP())
          LOOP
       Endif
     
       IF !TRB->(DBSEEK(SW3->W3_COD_I+SW3->W3_FABR+DTOS(SW3->W3_DT_EMB)+STR(SW3->W3_PRECO,15,5)))
           TRB->(DBAPPEND())
           TRB->W3_CC    :=SW3->W3_CC    
           TRB->W3_COD_I :=SW3->W3_COD_I 
           TRB->W3_FABR  :=SW3->W3_FABR  
           TRB->W3_FORN  :=SW3->W3_FORN  
           TRB->W3_PRECO :=SW3->W3_PRECO 
           TRB->W3_QTDE  :=SW3->W3_QTDE  
           TRB->W3_DT_EMB:=SW3->W3_DT_EMB
           TRB->W3_SEQ   :=SW3->W3_SEQ   
       ELSE
           TRB->W3_QTDE  :=TRB->W3_QTDE+SW3->W3_QTDE  
       ENDIF

       SW3->(DBSKIP())

   ENDDO
   
   TRB->(DBGOTOP())

ENDIF


Return(nil)        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01


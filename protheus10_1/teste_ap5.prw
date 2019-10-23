#include "rwmake.ch"        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

User Function Teste()        // incluido pelo assistente de conversao do AP5 IDE em 21/06/01

dbSelectArea("SIA")
COPY TO SIA

dbSelectArea("SI3")
COPY TO SI3

dbSelectArea("SI1")
COPY TO SI1

ALERT("FIM DA EXPORTACAO")

RETURN

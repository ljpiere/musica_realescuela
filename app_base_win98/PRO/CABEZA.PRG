PARAMETERS OPCION1,CABEZA
@  1,  0  TO 22, 79    DOUBLE
@  3,  1  TO  3, 78
DO CASE
   CASE OPCION1=1
        @  2,  1  SAY "            TITULO            |         ORQUESTA       | CASS. | LADO |  No."
        COL=0
        COL=INT((80-(LEN(RTRIM(CABEZA))+12))/2)
        ENCABEZA="INTERPRETE: "+RTRIM(INTERPRETE)
        @ 0, COL GET ENCABEZA
        CLEAR GETS
   CASE OPCION1=2
        @  2,  1  SAY "       INTERPRETE       |        ORQUESTA       |  CASSETTE  |  LADO  |  No."
        COL=0
        COL=INT((80-(LEN(RTRIM(CABEZA))+8))/2)
        ENCABEZA="TITULO: "+RTRIM(TITULO)
        @ 0, COL GET ENCABEZA
        CLEAR GETS
   CASE OPCION1=3
        @  2,  1  SAY "            TITULO            |      INTERPRETE        | CASS. | LADO |  No."
        COL=0
        COL=INT((80-(LEN(TRIM(CABEZA))+7))/2)
        ENCABEZA="ORQUESTA: "+RTRIM(ORQUESTA)
        @ 0, COL GET ENCABEZA
        CLEAR GETS
ENDCASE
RETURN

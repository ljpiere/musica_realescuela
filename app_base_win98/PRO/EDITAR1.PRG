*PROGRAMA EDITAR1
*PROGRAMA PARA LA EDICION DE TITULOS
TAG1=.T.
REVISOR=.T.
SALIR=0
USE DISCOS
DO WHILE TAG1
   IF SALIR>3
      EXIT
   ENDIF
   IF REVISOR
      OPCION1=0
      CLEAR
      SET FORMAT TO BUSCAR
      READ
      CLOSE FORMAT
      CLEAR
   ENDIF
   DO CASE
      CASE OPCION1=1
           TCODIGO=SPACE (8)
           @ 10, 27  SAY "CODIGO DESEADO:" GET TCODIGO PICTURE "@!"
           @  8, 24  TO 12, 53    DOUBLE
           READ
           CLEAR
           SET INDEX TO DCODIGO
           FIND &TCODIGO
           IF EOF()
              @ 24,1 SAY "El Codigo Digitado no Existe, Presione ENTER"
              WAIT " " TO W
              @ 24,1 SAY "                                             "
              SALIR=SALIR+1
           ELSE
              TAG2=.T.
     DO WHILE TAG
      CLEAR
      @  9, 15  TO 19, 63    DOUBLE
      @  5, 15  TO  7, 63
      @  6, 29  SAY "MODIFICACION DE DISCOS"
      @ 10, 18  SAY "Codigo......"
      @ 10, 30  GET  DISCOS->CODIGO  PICTURE "@!"
      CLEAR GETS
      @ 12, 18  SAY "Titulo......"
      @ 12, 30  GET  DISCOS->TITULO  PICTURE "@!"
      @ 14, 18  SAY "Interprete.."
      @ 14, 30  GET  DISCOS->INTERPRETE PICTURE "@!"
      @ 16, 18  SAY "Autor......."
      @ 16, 30  GET DISCOS->AUTOR   PICTURE "@!"
      @ 18, 18  SAY "Orquesta...."
      @ 18, 30  GET DISCOS->ORQUESTA PICTURE "@!"
      READ
      CORRECTO=" "
      @ 20,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE "A"
      READ
      @ 20,30 SAY "                 "
      IF UPPER(CORRECTO)="S"
       MAS=" "
       @ 20,30 SAY "CONTINUA (S/N):" GET MAS PICTURE "A"
       READ
       @ 20,30 SAY "                  "
       IF UPPER(MAS)="S"
        REVISOR=.T.
        EXIT
       ELSE
        TAG1=.F.
        EXIT
       ENDIF
      ELSE
       LOOP
      ENDIF
     ENDDO
    ENDIF
   CASE OPCION1=2
        TTITULO=SPACE(32)
        @ 16, 16  SAY "TITULO DESEADO:" GET TTITULO PICTURE "@!"
        @ 14, 14  TO 18, 65    DOUBLE
        READ
        CLEAR
        SET INDEX TO DCANCION
        FIND &TTITULO
        IF EOF()
           @ 24,1 SAY "El Titulo Digitado no Existe, Presione ENTER"
           WAIT " " TO W
           @ 24,1 SAY "                                             "
           SALIR=SALIR+1
        ELSE
           TAG2=.T.
           DO WHILE TAG
              CLEAR
              @  9, 15  TO 19, 63    DOUBLE
              @  5, 15  TO  7, 63
              @  6, 31  SAY "EDICION DE DISCOS"
              @ 10, 18  SAY "Codigo......"
              @ 10, 30  GET  DISCOS->CODIGO  PICTURE "@!"
              CLEAR GETS
              @ 12, 18  SAY "Titulo......"
              @ 12, 30  GET  DISCOS->TITULO  PICTURE "@!"
              @ 14, 18  SAY "Interprete.."
              @ 14, 30  GET  DISCOS->INTERPRETE PICTURE "@!"
              @ 16, 18  SAY "Autor......."
              @ 16, 30  GET DISCOS->AUTOR   PICTURE "@!"
              @ 18, 18  SAY "Orquesta...."
              @ 18, 30  GET DISCOS->ORQUESTA PICTURE "@!"
              READ
              CORRECTO=" "
              @ 20,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE "A"
              READ
              @ 20,30 SAY "                 "
              IF UPPER(CORRECTO)="S"
                 MAS=" "
                 @ 20,30 SAY "CONTINUA (S/N):" GET MAS PICTURE "A"
                 READ
                 @ 20,30 SAY "                  "
                 IF UPPER(MAS)="S"
                    REVISOR=.T.
                    EXIT
                 ELSE
                    TAG1=.F.
                    EXIT
                 ENDIF
              ELSE
                 LOOP
              ENDIF
           ENDDO
        ENDIF
  CASE OPCION1=0
       TAG1=.F.
       EXIT
       *DO EDITAR1
  ENDCASE
ENDDO
RETURN

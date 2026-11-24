*PROGRAMA EDITAR
*PROGRAMA PARA LA EDICION DE TITULOS
TAG1=.T.
REVISOR=.T.
SALIR=0
USE CASSETTE
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
           TCODIGO=SPACE (9)
           @ 10, 27  SAY "CODIGO DESEADO:" GET TCODIGO picture  "@!"
           @  8, 24  TO 12, 53    DOUBLE
           READ
           CLEAR
           SET INDEX TO CODIGO
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
                 SET FORMAT TO CASSETE1
                 READ
                 CLOSE FORMAT
                 CORRECTO=" "
                 @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO picture  "A"
                 READ
                 @ 18,30 SAY "                 "
                 IF UPPER(CORRECTO)="S"
                    MAS=" "
                    @ 18,30 SAY "CONTINUA (S/N):" GET MAS picture  "A"
                    READ
                    @ 18,30 SAY "                  "
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
           @ 16, 16  SAY "TITULO DESEADO:" GET TTITULO picture  "@!"
           @ 14, 14  TO 18, 65    DOUBLE
           READ
           CLEAR
           SET INDEX TO CANCION
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
                 SET FORMAT TO CASSETE2
                 READ
                 CLOSE FORMAT
                 CORRECTO=" "
                 @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO picture  "A"
                 READ
                 @ 18,30 SAY "                 "
                 IF UPPER(CORRECTO)="S"
                    MAS=" "
                    @ 18,30 SAY "CONTINUA (S/N):" GET MAS picture  "A"
                    READ
                    @ 18,30 SAY "                  "
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
   ENDCASE
ENDDO
RETURN

*PROGRAMA CARIBE
TAG=.T.
 STORE "ARCHIVO MAESTRO DE BOLEROS" TO HEADING
 STORE 26 TO LIN
DO WHILE TAG
 OPCION=0
 CLEAR
 @  2, 26  SAY "OPCIONES  PARA EL MANEJO DEL"
 @  3, LIN SAY HEADING
 @  6, 30  SAY "1.NUEVOS TITULOS"
 @  8, 30  SAY "2.MODIFICAR TITULOS"
 @ 10, 30  SAY "3.ELIMINAR TITULOS"
 @ 12, 30  SAY "4.MENU PRINCIPAL"
 @ 15, 35  SAY "OPCION:" GET OPCION PICTURE "#" RANGE 1,5
 @ 14, 25  TO 14, 55
 @  0, 21  TO 17, 59    DOUBLE
 @  1, 24  TO  4, 56    DOUBLE
 @  5, 24  TO 16, 56    DOUBLE
 READ
 DO CASE
  CASE OPCION=1
       CANUEVO()
  CASE OPCION=2
       CAEDITAR()
  CASE OPCION=3
       CAANULAR()
  OTHERWISE
   CLEAR
   STORE " " TO ORDEN
   @ 12,26 SAY "Ordenar Archivos (S/N):  ( )"
   @ 12,52 GET ORDEN PICTURE "!"
   READ
   @ 12,1 SAY SPACE(60)
   IF ORDEN="S"
    @ 20,5 SAY "El proceso de salida toma aproximadamente 5 minutos..."
    USE CARIBE
    SET INDEX TO ACANCION
    REINDEX
    SET INDEX TO ACANTA
    REINDEX
    SET INDEX TO ATOCA
    REINDEX
    set index to Acompone
    reindex
    SET INDEX TO ACODIGO
    REINDEX
   ENDIF
   TAG=.F.
 ENDCASE
ENDDO
CLOSE DATABASES
SET EXACT OFF
RETURN


FUNCTION  CANUEVO
*PROGRAMA NUEVO
*PROGRAMA PARA EL REGISTRO DE NUEVAS CANCIONES
TAG1=.T.
REVISOR=.T.
USE CARIBE INDEX ACODIGO
DO WHILE TAG1
IF REVISOR
CLEAR
TCASETE=SPACE(9)
@  5, 15  TO 17, 63    DOUBLE
@  1, 15  TO  3, 63
@  2, 27  SAY "CREACION DE NUEVOS BOLEROS"
@  7, 18  SAY "Cassette...."
@  7, 30  GET  TCASETE  PICTURE  "@!"
READ
CORRECTO=" "
@ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE "A"
READ
@ 18,30 SAY "                 "
IF UPPER(CORRECTO)<>"S"
 LOOP
ENDIF
FIND &TCASETE
IF .NOT. EOF()
 @ 18,1 SAY "El Codigo Digitado ya Existe !"
 WAIT " " TO W
 @ 18,1 SAY "                               "
 LOOP
ENDIF
APPEND BLANK
REPLACE CARIBE->CASETE WITH TCASETE
ENDIF
@  7, 18  SAY "Cassette...."
@  7, 30  GET  CARIBE->CASETE  PICTURE  "@!"
CLEAR GETS
@  9, 18  SAY "Titulo......"
@  9, 30  GET  CARIBE->TITULO  PICTURE  "@!"
@ 11, 18  SAY "Interprete.."
@ 11, 30  GET  CARIBE->INTERPRETE  PICTURE  "@!"
@ 13, 18  SAY "Autor......."
@ 13, 30  GET  CARIBE->AUTOR  PICTURE  "@!"
@ 15, 18  SAY "Orquesta...."
@ 15, 30  GET  CARIBE->ORQUESTA  PICTURE  "@!"
READ
CORRECTO=" "
@ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE  "A"
READ
@ 18,30 SAY "                 "
IF UPPER(CORRECTO)="S"
 MAS=" "
 @ 18,30 SAY "CONTINUA (S/N):" GET MAS PICTURE  "A"
 READ
 @ 18,30 SAY "                  "
 IF UPPER(MAS)="S"
  REVISOR=.T.
 ELSE
  EXIT
 ENDIF
ELSE
 REVISOR=.F.
ENDIF
ENDDO
RETURN




FUNCTION  CAEDITAR
*PROGRAMA EDITAR
*PROGRAMA PARA LA EDICION DE TITULOS
TAG1=.T.
REVISOR=.T.
SALIR=0
USE CARIBE
DO WHILE TAG1
 IF SALIR>3
  EXIT
 ENDIF
 IF REVISOR
  OPCION1=0
  CLEAR
  *SET FORMAT TO BUSCAR
  @  4, 31  SAY "SELECCIONE OPCION"
  @  5, 31  SAY "BUSQUEDA  BOLEROS"
  @  9, 31  SAY "1. POR CODIGO"
  @ 11, 31  SAY "2. POR TITULO"
  @ 14, 34  SAY "OPCION:" GET OPCION1 PICTURE "9" RANGE 1,2
  @ 13, 30  TO 13, 48
  @  3, 29  TO  6, 49 DOUBLE
  @  7, 29  TO 15, 49 DOUBLE
  @  1, 27  TO 17, 51 DOUBLE
  READ
  IF OPCION1=0
     RETURN
  ENDIF
  CLEAR
 ENDIF
  DO CASE
   CASE OPCION1=1
    TCODIGO=SPACE (9)
    @ 10, 27  SAY "CODIGO DESEADO:" GET TCODIGO PICTURE  "@!"
    @  8, 24  TO 12, 53    DOUBLE
    READ
    CLEAR
    SET INDEX TO ACODIGO
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
      *SET FORMAT TO CASSETE1
      @  5, 15  TO 17, 63    DOUBLE
      @  1, 15  TO  3, 63
      @  2, 27  SAY "MODIFICACION DE BOLEROS"
      @  9, 18  SAY "Titulo......"
      @  9, 30  GET  CARIBE->TITULO  PICTURE  "@!"
      @ 11, 18  SAY "Interprete.."
      @ 11, 30  GET  CARIBE->INTERPRETE  PICTURE  "@!"
      @ 13, 18  SAY "Autor......."
      @ 13, 30  GET  CARIBE->AUTOR  PICTURE  "@!"
      @ 15, 18  SAY "Orquesta...."
      @ 15, 30  GET  CARIBE->ORQUESTA  PICTURE  "@!"
      READ
      CORRECTO=" "
      @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE  "A"
      READ
      @ 18,30 SAY "                 "
      IF UPPER(CORRECTO)="S"
       MAS=" "
       @ 18,30 SAY "CONTINUA (S/N):" GET MAS PICTURE  "A"
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
    @ 16, 16  SAY "TITULO DESEADO:" GET TTITULO PICTURE  "@!"
    @ 14, 14  TO 18, 65    DOUBLE
    READ
    CLEAR
    SET INDEX TO ACANCION
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
     *SET FORMAT TO CASSETE2
      @  5, 15  TO 17, 63    DOUBLE
      @  1, 15  TO  3, 63
      @  2, 27  SAY "MODIFICACION DE BOLEROS"
      @  9, 18  SAY "Titulo......"
      @  9, 30  GET  CARIBE->TITULO  PICTURE  "@!"
      @ 11, 18  SAY "Interprete.."
      @ 11, 30  GET  CARIBE->INTERPRETE  PICTURE  "@!"
      @ 13, 18  SAY "Autor......."
      @ 13, 30  GET  CARIBE->AUTOR  PICTURE  "@!"
      @ 15, 18  SAY "Orquesta...."
      @ 15, 30  GET  CARIBE->ORQUESTA  PICTURE  "@!"
     READ
     CLOSE FORMAT
     CORRECTO=" "
     @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE  "A"
     READ
     @ 18,30 SAY "                 "
     IF UPPER(CORRECTO)="S"
      MAS=" "
      @ 18,30 SAY "CONTINUA (S/N):" GET MAS PICTURE  "A"
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


FUNCTION CAANULAR
*PROGRAMA PARA ELIMINAR UN TITULO DEL ARCHIVO
*PROGRAMA ANULAR
TAG1=.T.
REVISOR=.T.
SALIR=0
USE CARIBE INDEX ACODIGO
DO WHILE TAG1
 IF SALIR>3
  EXIT
 ENDIF
 CLEAR
 TCODIGO=SPACE (9)
 @ 10, 27  SAY "CODIGO DESEADO:" GET TCODIGO PICTURE "@!"
 @  8, 24  TO 12, 53    DOUBLE
 READ
 CLEAR
 SET ORDER TO 1
 FIND &TCODIGO
 IF EOF()
  @ 23,1 SAY "El Codigo Digitado no Existe, Presione ENTER"
  WAIT " " TO W
  @ 23,1 SAY "                                             "
  SALIR=SALIR+1
 ELSE
  CLEAR
  @  2, 27  SAY "ANULACION DE BOLEROS"
  @  7, 18  SAY "Titulo......"
  @  7, 30  SAY  CARIBE->TITULO  PICTURE "@!"
  @  9, 18  SAY "Interprete.."
  @  9, 30  SAY  CARIBE->INTERPRETE  PICTURE "@!"
  @ 11, 18  SAY "Autor......."
  @ 11, 30  SAY  CARIBE->AUTOR  PICTURE  "@!"
  @ 13, 18  SAY "Orquesta...."
  @ 13, 30  SAY  CARIBE->ORQUESTA  PICTURE  "@!"
  @ 15, 18  SAY "Cassette...."
  @ 15, 30  SAY  CARIBE->CASETE  PICTURE  "@!"
  @  5, 15  TO 17, 63    DOUBLE
  @  1, 15  TO  3, 63
  CORRECTO=" "
  @ 18,30 SAY "CORRECTO (S/N):" GET CORRECTO PICTURE  "A"
  READ
  @ 18,30 SAY "                 "
  IF UPPER(CORRECTO)="S"
   DELETE
   WAIT "El Titulo ha Sido Borrado, Presione ENTER" TO W
   @ 19,0 SAY "                                          "
   MAS=" "
   @ 18,30 SAY "CONTINUA (S/N):" GET MAS PICTURE "A"
   READ
   @ 18,30 SAY "                  "
   IF UPPER(MAS)<>"S"
    CLEAR
    @ 20, 5 SAY "Un momento por favor..."
    CLOSE INDEX
    PACK
    EXIT
   ENDIF
  ELSE
   EXIT
  ENDIF
 ENDIF
ENDDO
RETURN

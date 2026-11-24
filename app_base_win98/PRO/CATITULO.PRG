*PROGRAMA TITULO
*PROGRAMA PARA LA LOCALIZACION E INFORMACION SOBRE TITULOS
SET EXACT OFF
TAG1=.T.
SW=.T.
REVISOR=.T.
SALIR=0
SELECT 2
USE WORK1
SELECT 1
USE CARIBE
DO WHILE TAG1
  SELECT 1
  OPCION1=0
  CLEAR
  @  4, 31  SAY "SELECCIONE OPCION"
  @  5, 34  SAY "DE CONSULTA"
  @  9, 31  SAY "1. POR INTERPRETE"
  @ 11, 31  SAY "2. POR TITULO"
  @ 13, 31  SAY "3. POR ORQUESTA"
  @ 15, 31  SAY "4. MENU PRINCIPAL"
  @ 18, 34  SAY "OPCION:" GET OPCION1 PICTURE "9" RANGE 1,4
  @ 17, 30  TO 17, 48
  @  3, 29  TO  6, 49 DOUBLE
  @  7, 29  TO 19, 49 DOUBLE
  @  1, 27  TO 21, 51 DOUBLE
  READ
  CLEAR
  DO CASE
   CASE OPCION1=1
    TCANTA=SPACE (32)
    @ 13, 17  SAY "INTERPRETE DESEADO: " GET TCANTA PICTURE  "@!"
    @ 11, 13 TO 15, 75   DOUBLE
    READ
    IF TCANTA=SPACE(32)
     LOOP
    ENDIF
    STORE "interprete" TO LITERAL
    SET INDEX TO ACANTA
    @ 16, 27 SAY "Un momento por favor..."
    STORE TRIM(TCANTA) TO TCANTA
    FIND  &TCANTA
    IF .NOT. EOF()
     OPCION2=0
     @ 18, 15  SAY ":1: Pantalla de Detalle     :2: Pantalla de Resumen"
     @ 20, 35  SAY "OPCION : :"
     @ 20, 43  GET OPCION2 PICTURE "9" RANGE 1,2
     @ 17, 13  TO 21, 67    DOUBLE
     @ 19, 14  TO 19, 66
     READ
    IF OPCION2=2
     CLEAR
     SW1=.T.
     CONTLIN=0
     CUANTOS=0
     SELECT 2
     ZAP
     SELECT 1
     STORE .T. TO SW1
     DO WHILE SW1
      STORE TITULO     TO TTITULO
      STORE INTERPRETE TO TINTERPRETE
      STORE ORQUESTA   TO TORQUESTA
      STORE AUTOR      TO TAUTOR
      STORE CASETE     TO TCODIGO
      SELECT 2
      APPEND BLANK
      REPLACE TITULO     WITH TTITULO
      REPLACE INTERPRETE WITH TINTERPRETE
      REPLACE ORQUESTA   WITH TORQUESTA
      REPLACE AUTOR      WITH TAUTOR
      REPLACE CASETE     WITH TCODIGO
      SELECT 1
      IF .NOT. EOF()
       SKIP
      ELSE
       EXIT
      ENDIF
      IF INTERPRETE<>TCANTA
       SW1=.F.
      ENDIF
     ENDDO
     SELECT 2
     IF OPCION1=2
      INDEX ON INTERPRETE TO WORK1
     ELSE
      INDEX ON TITULO TO WORK1
     ENDIF
     DO CABEZA WITH OPCION1,TCANTA
     DO WHILE .NOT. EOF()
      IF CONTLIN>16
       MAS=" "
       @ 23,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "A"
       READ
       @ 23,2 SAY "                                            "
       IF UPPER(MAS)="N"
        EXIT
       ENDIF
       CLEAR
       DO CABEZA WITH OPCION1,TCANTA
       CONTLIN=0
      ENDIF
      IF TITULO=SPACE(32)
       @ (CONTLIN+5),1 SAY "NO REGISTRADO"
      ELSE
       @ (CONTLIN+5),1  SAY TITULO
      ENDIF
      IF ORQUESTA=SPACE(32)
       @ (CONTLIN+5),34 SAY "NO REGISTRADO"
      ELSE
       @ (CONTLIN+5),34 SAY ORQUESTA
      ENDIF
      @ (CONTLIN+5),70 SAY SUBSTR(CASETE,1,3)
      @ (CONTLIN+5),74 SAY SUBSTR(CASETE,5,1)
      @ (CONTLIN+5),76 SAY SUBSTR(CASETE,7,2)
      CONTLIN=CONTLIN+1
      CUANTOS=CUANTOS+1
      SKIP
      IF EOF()
       @ 23,2 SAY "Total titulos registrados..."
       @ 23,30 SAY LTRIM(STR(CUANTOS,3,0))
       @ 23,34 SAY "Presione ENTER."
       WAIT " " TO W
       @ 23,2 SAY "                                                          "
      ENDIF
     ENDDO
    ELSE
     SW1=.T.
     DO WHILE SW1
      CLEAR
      DO CACANTAR WITH OPCION1
      MAS=" "
      @ 22,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "!"
      READ
      @ 22,2 SAY "                                "
      IF MAS="S"
       SKIP
       IF INTERPRETE<>TCANTA.OR.EOF()
        SW1=.F.
        SW=.T.
       ENDIF
      ELSE
       SW=.F.
       EXIT
      ENDIF
     ENDDO
     IF SW
      @ 22,2 SAY "No hay mas titulos registrados..."
      WAIT " " TO W
      @ 22,2 SAY "                                  "
     ENDIF
    ENDIF
    ELSE
     CLEAR
     @ 22, 2 SAY "El "
     ?? LITERAL+" "+"solicitado no se encuentra registrado... Presione ENTER."
     WAIT " " TO W
     @ 22, 2 SAY "                                                                               "
    ENDIF
   CASE OPCION1=2
    TTITULO=SPACE(32)
    @ 13, 16  SAY " TITULO DESEADO: " GET TTITULO PICTURE  "@!"
    @ 11, 13  TO 15, 75    DOUBLE
    READ
    IF TTITULO=SPACE(32)
     LOOP
    ENDIF
    STORE "titulo" TO LITERAL
    SET INDEX TO ACANCION
    STORE TRIM(TTITULO) TO TTITULO
    @ 16, 27 SAY "Un momento por favor..."
    FIND  &TTITULO
    IF .NOT. EOF()
     OPCION2=0
     @ 18, 15  SAY ":1: Pantalla de Detalle     :2: Pantalla de Resumen"
     @ 20, 35  SAY "OPCION : :"
     @ 20, 43  GET OPCION2 PICTURE "9" RANGE 1,2
     @ 17, 13  TO 21, 67    DOUBLE
     @ 19, 14  TO 19, 66
     READ
    IF OPCION2=2
     CLEAR
     SW1=.T.
     CONTLIN=0
     CUANTOS=0
     SELECT 2
     ZAP
     SELECT 1
     STORE .T. TO SW1
     DO WHILE SW1
      STORE TITULO     TO TTEMA
      STORE INTERPRETE TO TINTERPRETE
      STORE ORQUESTA   TO TORQUESTA
      STORE AUTOR      TO TAUTOR
      STORE CASETE     TO TCODIGO
      SELECT 2
      APPEND BLANK
      REPLACE TITULO     WITH TTEMA
      REPLACE INTERPRETE WITH TINTERPRETE
      REPLACE ORQUESTA   WITH TORQUESTA
      REPLACE AUTOR      WITH TAUTOR
      REPLACE CASETE     WITH TCODIGO
      SELECT 1
      IF .NOT. EOF()
       SKIP
      ELSE
       EXIT
      ENDIF
      IF TITULO<>TTITULO
       SW1=.F.
      ENDIF
     ENDDO
     SELECT 2
     IF OPCION1=2
      INDEX ON INTERPRETE TO WORK1
     ELSE
      INDEX ON TITULO TO WORK1
     ENDIF
     DO CABEZA WITH OPCION1,TTITULO
     DO WHILE .NOT. EOF()
      IF CONTLIN>16
       MAS=" "
       @ 23,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "A"
       READ
       @ 23,2 SAY "                                            "
       IF UPPER(MAS)="N"
        EXIT
       ENDIF
       CLEAR
       DO CABEZA WITH OPCION1,TTITULO
       CONTLIN=0
      ENDIF
      IF INTERPRETE=SPACE(32)
       @ (CONTLIN+5),1 SAY "NO REGISTRADO"
      ELSE
       @ (CONTLIN+5),1  SAY INTERPRETE
      ENDIF
      IF ORQUESTA=SPACE(32)
       @ (CONTLIN+5),34 SAY "NO REGISTRADO"
      ELSE
       @ (CONTLIN+5),34 SAY ORQUESTA
      ENDIF
      @ (CONTLIN+5),60 SAY SUBSTR(CASETE,1,3)
      @ (CONTLIN+5),68 SAY SUBSTR(CASETE,5,1)
      @ (CONTLIN+5),74 SAY SUBSTR(CASETE,7,2)
      CONTLIN=CONTLIN+1
      CUANTOS=CUANTOS+1
      SKIP
      IF EOF()
       @ 23,2 SAY "Total titulos registrados..."
       @ 23,30 SAY LTRIM(STR(CUANTOS,3,0))
       @ 23,34 SAY "Presione ENTER."
       WAIT " " TO W
       @ 23,2 SAY "                                                          "
      ENDIF
     ENDDO
    ELSE
     SW1=.T.
     DO WHILE SW1
      CLEAR
      DO CACANTAR WITH OPCION1
      MAS=" "
      @ 22,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "!"
      READ
      @ 22,2 SAY "                                "
      IF MAS="S"
       SKIP
       IF TITULO<>TTITULO.OR.EOF()
        SW1=.F.
       ENDIF
      ELSE
       SW=.F.
       EXIT
      ENDIF
     ENDDO
     IF SW
      @ 22,2 SAY "No hay mas titulos registrados..."
      WAIT " " TO W
      @ 22,2 SAY "                                  "
     ENDIF
    ENDIF
    ELSE
     CLEAR
     @ 22, 2 SAY "El "
     ?? LITERAL+" "+"solicitado no se encuentra registrado... Presione ENTER."
     WAIT " " TO W
     @ 22, 2 SAY "                                                                                  "
    ENDIF
   CASE OPCION1=3
    TAUTOR=SPACE(32)
    @ 13, 16 SAY " ORQUESTA DESEADA: " GET TAUTOR PICTURE  "@!"
    @ 11, 13 TO 15, 75   DOUBLE
    READ
    IF TAUTOR=SPACE(32)
     LOOP
    ENDIF
    STORE "orquesta" TO LITERAL
    SET INDEX TO ATOCA
    STORE TRIM(TAUTOR) TO TAUTOR
    @ 16, 27 SAY "Un momento por favor..."
    FIND  &TAUTOR
    IF .NOT. EOF()
     OPCION2=0
     @ 18, 15  SAY ":1: Pantalla de Detalle     :2: Pantalla de Resumen"
     @ 20, 35  SAY "OPCION : :"
     @ 20, 43  GET OPCION2 PICTURE "9" RANGE 1,2
     @ 17, 13  TO 21, 67    DOUBLE
     @ 19, 14  TO 19, 66
     READ
    IF OPCION2=2
     CLEAR
     SW1=.T.
     CONTLIN=0
     CUANTOS=0
     SELECT 2
     ZAP
     SELECT 1
     STORE .T. TO SW1
     DO WHILE SW1
      STORE TITULO     TO TTITULO
      STORE INTERPRETE TO TINTERPRETE
      STORE ORQUESTA   TO TORQUESTA
      STORE AUTOR      TO TQUIEN
      STORE CASETE     TO TCODIGO
      SELECT 2
      APPEND BLANK
      REPLACE TITULO     WITH TTITULO
      REPLACE INTERPRETE WITH TINTERPRETE
      REPLACE ORQUESTA   WITH TORQUESTA
      REPLACE AUTOR      WITH TQUIEN
      REPLACE CASETE     WITH TCODIGO
      SELECT 1
      IF .NOT. EOF()
       SKIP
      ELSE
       EXIT
      ENDIF
      IF ORQUESTA<>TAUTOR
       SW1=.F.
      ENDIF
     ENDDO
     SELECT 2
     IF OPCION1=2
      INDEX ON INTERPRETE TO WORK1
     ELSE
      INDEX ON TITULO TO WORK1
     ENDIF
     DO CABEZA WITH OPCION1,TAUTOR
     DO WHILE .NOT. EOF()
      IF CONTLIN>16
       MAS=" "
       @ 23,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "A"
       READ
       @ 23,2 SAY "                                            "
       IF UPPER(MAS)="N"
        EXIT
       ENDIF
       CLEAR
       DO CABEZA WITH OPCION1,TAUTOR
       CONTLIN=0
      ENDIF
      IF TITULO=SPACE(32)
       @ (CONTLIN+5),1 SAY "NO REGISTRADO"
      ELSE
       @ (CONTLIN+5),1  SAY TITULO
      ENDIF
      IF INTERPRETE=SPACE(32)
       @ (CONTLIN+5),34 SAY "NO REGISTRADO"
      ELSE
       @ (CONTLIN+5),34 SAY INTERPRETE
      ENDIF
      @ (CONTLIN+5),70 SAY SUBSTR(CASETE,1,3)
      @ (CONTLIN+5),74 SAY SUBSTR(CASETE,5,1)
      @ (CONTLIN+5),76 SAY SUBSTR(CASETE,7,2)
      CONTLIN=CONTLIN+1
      CUANTOS=CUANTOS+1
      SKIP
      IF EOF()
       @ 23,2 SAY "Total titulos registrados..."
       @ 23,30 SAY LTRIM(STR(CUANTOS,3,0))
       @ 23,34 SAY "Presione ENTER."
       WAIT " " TO W
       @ 23,2 SAY "                                                          "
      ENDIF
     ENDDO
    ELSE
     SW1=.T.
     DO WHILE SW1
      CLEAR
      DO CACANTAR WITH OPCION1
      MAS=" "
      @ 22,2 SAY "Siguiente pantalla (S/N):" GET MAS PICTURE  "!"
      READ
      @ 22,2 SAY "                                "
      IF MAS="S"
       SKIP
       IF ORQUESTA<>TAUTOR.OR.EOF()
        SW1=.F.
       ENDIF
      ELSE
       SW=.F.
       EXIT
      ENDIF
     ENDDO
     IF SW
      @ 22,2 SAY "No hay mas titulos registrados..."
      WAIT " " TO W
      @ 22,2 SAY "                                  "
     ENDIF
    ENDIF
    ELSE
     CLEAR
     @ 22, 2 SAY "La "
     ?? LITERAL+" "+"solicitada no se encuentra registrada... Presione ENTER."
     WAIT " " TO W
     @ 22, 2 SAY "                                                                                     "
    ENDIF
   OTHERWISE
    EXIT
  ENDCASE
  MAS=" "
  @ 23,2 SAY "Continua (S/N):" GET MAS PICTURE  "A"
  READ
  @ 23,2 SAY "                  "
  IF UPPER(MAS)<>"S"
   TAG1=.F.
  ENDIF
ENDDO
CLOSE DATABASES
RETURN

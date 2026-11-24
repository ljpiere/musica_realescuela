@ 23,12 SAY '                                                                 '
@ 23,12 SAY 'ARCHIVO:'+DBF()
@ 23,32 SAY 'TOTAL REGISTROS:'
@ 23,48 SAY RECCOUNT()
@ 23,60 SAY 'ACTUAL:'
@ 23,71 SAY RECNO()
DECLARE m1[FCOUNT()], m2[FCOUNT()], m3[FCOUNT()], m4[FCOUNT()]
FOR i = 1 TO LEN(m1)
    m1[i] = FIELDNAME(i)
NEXT
sepcabe = CHR(205)
seproda = CHR(196)
sepcol = CHR(186)

l1 = 4
c1 = 0
l2 = 21
c2 = 79
@l1-1,c1-1 TO l2+1,c2+1 DOUBLE
DBEDIT(l1,c1,l2,c2,m1,"testatecla",m3,m2,sepcabe,sepcol,seproda,m4)
SET CURSOR ON



FUNCTION testatecla
PARAMETERS mode, counter
SET CURSOR OFF
@ 23,12 SAY '                                                                 '
@ 23,12 SAY 'ARCHIVO:'+DBF()
@ 23,32 SAY 'TOTAL REGISTROS:'
@ 23,48 SAY RECCOUNT()
@ 23,60 SAY 'ACTUAL:'
@ 23,71 SAY RECNO()
DO CASE
   CASE mode = 0
        IF DELETED()
           @24,70 SAY "ELIMINADO"
               ELSE
                  @24,70 SAY REPLICATE(" ",9)
               ENDIF
               RETURN(1)                              && Nada se modifico
   CASE mode = 1
        @24,55 SAY "INICIO DEL ARCHIVO"        && Se presiono PgUp o flecha
        INKEY(.5)                              && hacia arriba en un registro
        @24,55 SAY REPLICATE(" ",20)
        RETURN(1)
   CASE mode = 2                               && Se presiono PgDn o flecha
        @24,55 SAY "FIN DE ARCHIVO"            && hacia abajo al ultimo
        INKEY(.5)                              && registro
        @24,55 SAY REPLICATE(" ",20)
        RETURN(1)
   CASE mode = 3
        @24,10 SAY "ARCHIVO VACIO"
        INKEY(1)
        RETURN(0)
        ** Verifica ultima tecla presionada
   CASE mode = 4
        DO CASE
           CASE LASTKEY() = 27                 && Se presiono Esc
                RETURN(0)                      && Abandona DBEDIT()
           CASE LASTKEY() = 13                 && Se presiono Enter, en este caso edita
                ** remos el campo actual.
                campo = FIELDNAME(counter)
                IF TYPE("&campo") = "M"
                   memotela = SAVESCREEN(9,44,21,76)
                                 moldura(9,44,21,76,.F.,"CAMPO MEMO")
                                 REPLACE &campo WITH MEMOEDIT(&campo,10,45,20,75,.T.)
                                 RESTSCREEN(9,44,21,76,memotela)
                              ELSE
                                 coled = COL()               && Obtiene columna actual
                                 lined = ROW()               && Obtiene linea actual
                                 @ 24,30 GET &campo          && Edita el campo actual
                                 SET CURSOR ON
                                 READ
                                 SET CURSOR OFF
                              ENDIF
                              KEYBOARD CHR(4)                && Mueve el cursor hacia la columna
                              RETURN(1)                      && de la derecha con CHR(4) (->)
               ENDCASE
      OTHERWISE
      RETURN(1)
ENDCASE



FUNCTION moldura(topo,esq,dir,baixo,duplo,texto)
IF PCOUNT() < 6
   @23,10 SAY "Numero de parametros invalidos"
   RETURN(NIL)
ENDIF
IF duplo
   @topo,esq CLEAR TO dir,baixo
   @topo,esq TO dir,baixo DOUBLE
ELSE
   @topo,esq CLEAR TO dir,baixo
   @topo,esq TO dir,baixo
ENDIF
IF LEN(texto) > 0
   tam = baixo - esq
   novapos = (tam - LEN(texto))/2
   @topo,esq+novapos SAY texto
ENDIF
RETURN(NIL)



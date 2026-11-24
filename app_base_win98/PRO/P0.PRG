CLEAR
CLOSE ALL
SET STATUS OFF
SET BELL OFF
SET ECHO OFF
SET TALK OFF
SET SCOREBOARD OFF
SET ESCAPE OFF
SET SAFETY OFF
SET EXACT ON
*SET PATH TO a:
PUBLIC ALL
STORE .T. TO TT
DO WHILE TT
   CLEAR
   O=0
   @  3, 27  SAY " M E N U   G E N E R A L "
   @ 07, 28  SAY "1. CONTROL DISCOS"
   @ 09, 28  SAY "2. CONTROL SELECCIONES"
*   @ 10, 28  SAY "3. CONTROL CINTAS"
   @ 11, 28  SAY "3. SALIR DEL SISTEMA"
   @ 15, 35  SAY "OPCION:" GET O PICTURE "9" RANGE 1,3
   @  2, 25  TO  4, 55    DOUBLE
   @  5, 25  TO 17, 55    DOUBLE
   @ 14, 26  TO 16, 54
   @  0, 23  TO 18, 57    DOUBLE
   READ
   DO CASE
      CASE O=1
           DO P1
      CASE O=2
           DO P2
      CASE O=3
           quit
*      CASE O=4
*           QUIT
      OTHERWISE
      EXIT
   ENDCASE
ENDDO
CLOSE ALL
QUIT


Function DIGA
Param x,y,coi,cof,men
setcolor(coi)
@x,y say men
setcolor(cof)
Return(.f.)

* ---------------------------------------------------------------------------
*|Funcion : ZOOM (x,y,w,z,sombra,forma)                                      |
*|Definic.: Dibuja una caja en la pantalla segun las coordenadas, con o sin  |
*|          sombra real, y puede abrirse desde cualquier angulo y con 5 tipos|
*|          de linea.                                                        |
*|Paramet : X = Linea esquina Izq Superior      Y = Columna esquina Izq Sup. |
*|          W = Linea esquina Der Inferior      Z = Columna esquina Der Inf. |
*|     SOMBRA = 0-> sin sombra  1-> con sombra                               |
*|     FORMA  = "MN" M[ 0-centro, 1-izq.sup, 2-der.sup, 3-izq.inf, 4-der.inf |
*|                    [ 5-abajo , 6-arriba , 7-derecha, 8-izuierda,9-Mnu     |
*|                 N[ 1-senci, 2-doble, 3-gruesa, 4-dble-sen, 5-sen-dbl,6-Cgt|
*|                    7-Tabla                                                |
*|___________________________________________________________________________|

function ZOOM
param AR,IZ,AB,DR,SOM,FORM
private X,Y,W,Z,XTL,MARCO,E,XVIA,IN,INX
do case
   case pcount()<5
        SOM =0
        FORM='01'
   case pcount()<6
        FORM='01'
   case pcount()<4 .or.AB-AR<0
        wait "Error parametros para la caja." to E
        retu(.f.)
endcase
XTL=subs(FORM,2,1)
do case
   case XTL  = '2'
        MARCO= 'ÉÍ»º¼ÍÈº '
   case XTL  = '3'
        MARCO= 'ÛÛÛÛÛÛÛÛ '
   case XTL  = '4'
        MARCO= 'ÕÍ¸³¾ÍÔ³ '
   case XTL  = '5'
        MARCO= 'ÖÄ·º½ÄÓº '
   case XTL  = '6'
        MARCO= 'ÑÍÑ³ÙÄÀ³ '
   case XTL  = '7'
        MARCO= 'ÛÛÛ³ÙÄÀ³ '
   otherw &&case XTL  = '1'
        MARCO= 'ÚÄ¿³ÙÄÀ³ '
endcase
XVIA=subs(FORM,1,1)
do case

   case XVIA='1'
        X=AR
        W=IZ
        Y=X+1
        Z=W+1
   case XVIA='2'
        X=AR+1
        W=DR-1
        Y=AR
        Z=DR
   case XVIA='3'
        X=IZ
        W=AB
        Y=X-1
        Z=W+1
   case XVIA='4'
        X=AB-1
        W=DR-1
        Y=AB
        Z=DR
   case XVIA='5'
        X=AB
        W=IZ
        Y=AB
        Z=DR
   case XVIA='6'
        X=AR
        W=IZ
        Y=AR
        Z=DR
   case XVIA='7'
        X=AR
        W=DR
        Y=AB
        Z=DR
   case XVIA='8'
        X=AR
        W=IZ
        Y=AB
        Z=IZ
   case XVIA='9'
        X=AR+1
        W=IZ+1
        Y=AB-1
        Z=DR-1
   otherw && case XVIA='0'
        IN=AR+int((AB-AR)/2)
        X=IN
        Y=X
        INX=IZ+int((DR-IZ)/2)
        W=INX
        Z=W
endcase
do while .t.
   if X>AR
      X=X-1
   endi
   if Y<ab
       Y=Y+1
   endif
   if W>IZ
      W=W-Iif(W-2<IZ,1,2)
   endi
   if Z<DR
       Z=Z+Iif(Z+2>DR,1,2)
   endif
   @X,W,Y,Z box MARCO
   if (X=AR .and.Y=AB)
      if (W=IZ.and.Z=DR)
         do case
            case som=1
                 SOMBRA(AR,IZ,AB,DR)
            case som=2
                 SOMBRA(AR,IZ,AB,DR,1)
         endcase
         exit
      endif
   else
      E=inkey(0.01)
   endif
enddo

function SOMBRA
param x1,y1,x2,y2,ne
private OLDCOL,XX,YY
if PCOUNT() <5
   NE=0
endif
If X2>=24.or.Y2>=79
   retu(.f.)
Endif
OLDCOL=setcolor("B/")
set color to
XX=savescreen(X1+1,Y2+1,X2,Y2+1)
YY=savescreen(X2+1,Y1+1,X2+1,Y2+1)
For I=2 to len(XX) step 2
    XX=Stuff(XX,I,1,chr(7))
Next
For I=2 to len(YY) step 2
    YY=Stuff(YY,I,1,chr(7))
Next
RestScreen(X1+1,Y2+1,X2,Y2+1,XX)
RestScreen(X2+1,Y1+1,X2+1,Y2+1,YY)
OLDCOL=setcolor(OLDCOL)
retu(.t.)




FUNCTION PASO
!VOL C: >DGES0000.DAT
USE DGES
ZAP
APPE FROM DGES0000.DAT DELI
DELE FOR CADENA='              '
PACK
!DEL DGES0000.DAT
USE
USE DGES
GO BOTTOM
STORE CADENA TO CADE2
DELE ALL
PACK
USE
*Lo trae con la orden VOL [UNIDAD]: > TEMP.DAT,  y con ^KR COPIA SOLO EL NUMERO DE SERIE
STORE 'El n£mero de serie del volumen es 239B-8A94' TO CADE1
IF TRIM(CADE1) <> TRIM(CADE2)
   QUIT
   RETURN
ENDIF



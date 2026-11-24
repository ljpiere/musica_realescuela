set talk off
set echo off
close all
use discos
set inde to codigo
go top
set print on
set device to prin
set console off
?chr(15)
do while .not. eof()
   rev0=substr(codigo,1,2)
   ?'Gaveta :'+rev0
   linea=' '
   do while rev0=substr(codigo,1,2)
      rev1=substr(codigo,4,2)
      linea=linea+rev1+'  '
      do while rev1=substr(codigo,4,2)
         skip
         if rev0<>substr(codigo,1,2)
            exit
         endif
      enddo
   enddo
   ?linea
enddo
set print off
set device to screen
set console on
cancel            
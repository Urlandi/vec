.MODEL SMALL
.DATA
 R    DD 0
 S    DD 0
 V    DD 0
 T    DD 4
 D    DD 3
.STACK 100H
.CODE
.STARTUP
         FLDPI
         FMUL  R
         FMUL  R
         FMUL  T
         
         FSTP  S

         FLDPI
         FMUL  R
         FMUL  R
         FMUL  R
         FMUL  T
         FDIV  D
         
         FSTP  V

         FINIT
.EXIT
END
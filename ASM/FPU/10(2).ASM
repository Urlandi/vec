.386P
.MODEL SMALL
.DATA
 X    DD 0
 Y    DD 0
 R1   DD 0
.STACK 100H
.CODE
.STARTUP
         FLD    X       ;X*X
         FMUL   X
         FSTP   X

         FLD    X
         FSIN
         FSTP   R1

         FLD    X
         FCOS

         FADD   R1

         FSTP   Y

         FINIT
.EXIT
END
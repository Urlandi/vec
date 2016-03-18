.MODEL SMALL
.DATA
 X    DD 0
 Y    DD 0
.STACK 100H
.CODE
.STARTUP
         FLD1
         FADD   X

         FDIV   X

         FLD1
         FYL2X

         FSTP   Y

         FINIT
.EXIT
END
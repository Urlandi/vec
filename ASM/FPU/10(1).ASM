.MODEL SMALL
.DATA
 A DD 0
 B DD 0
 Y DD 0
 T DD 2
.STACK 100H
.CODE
.STARTUP
         FLD    A       ;A*A
         FMUL   A

         FLD    B       ;B*B
         FMUL   B

         FADD   ST(0),ST(1)
         FSTP   Y

         FDECSTP
         FFREE   ST(0)

         FLD    A
         FLD    B
         FMUL   ST(0),ST(1)
         FLD    T
         FMUL   ST(0),ST(2)
         FADD   Y
         FSQRT

         FSTP   Y

         FINIT
.EXIT
END
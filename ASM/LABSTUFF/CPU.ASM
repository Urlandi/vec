.486
INCLUDE CPUGREG.INC

_TEXT   SEGMENT WORD PUBLIC USE16 'CODE'
ASSUME CS:_TEXT,DS:_DATA,ES:_DATA,SS:_STACK

START:                  MOV AX,_DATA
                        MOV DS,AX
                        MOV ES,AX
                        MOV GS,AX
                        MOV FS,AX
                        MOV AX,_STACK
                        MOV SS,AX
                        MOV SP,STACKSIZE

                        MOV AH,9
                        MOV DX,OFFSET MSGTITL
                        INT 21H

;Тестируем программно доступные регистры-------------------------------------
                        MOV AH,9
                        MOV DX,OFFSET MSGREGS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGSTRT
                        INT 21H

                        GREGTEST EAX,MSGEAX,MSGPASS,MSGFAIL,ERRREGS,FR1,PR1
                        GREGTEST EBX,MSGEBX,MSGPASS,MSGFAIL,ERRREGS,FR2,PR2
                        GREGTEST ECX,MSGECX,MSGPASS,MSGFAIL,ERRREGS,FR3,PR3
                        GREGTEST EDX,MSGEDX,MSGPASS,MSGFAIL,ERRREGS,FR4,PR4
                        GREGTEST ESI,MSGESI,MSGPASS,MSGFAIL,ERRREGS,FR5,PR5
                        GREGTEST EDI,MSGEDI,MSGPASS,MSGFAIL,ERRREGS,FR6,PR6
                        GREGTEST EBP,MSGEBP,MSGPASS,MSGFAIL,ERRREGS,FR7,PR7

                        MOV ECX,ESP
                        GREGTEST ESP,MSGESP,MSGPASS,MSGFAIL,ERRREGS,FR8,PR8
                        MOV ESP,ECX

                        SREGTEST DS,MSGDS,MSGPASS,MSGFAIL,ERRREGS,FR9,PR9
                        SREGTEST ES,MSGES,MSGPASS,MSGFAIL,ERRREGS,FRA,PRA
                        SREGTEST FS,MSGFS,MSGPASS,MSGFAIL,ERRREGS,FRB,PRB
                        SREGTEST GS,MSGGS,MSGPASS,MSGFAIL,ERRREGS,FRC,PRC
                        SREGTEST SS,MSGSS,MSGPASS,MSGFAIL,ERRREGS,FRD,PRD

                        JMP DONEREGS

ERRREGS:                MOV AH,9
                        MOV DX,OFFSET MSGREGS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGERROR
                        INT 21H

.EXIT

DONEREGS:               MOV AH,9
                        MOV DX,OFFSET MSGREGS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGDONE
                        INT 21H
;---------------------------------------------------------------------------
;Тестируем устройство сегментации-------------------------------------------
                        MOV AH,9
                        MOV DX,OFFSET MSGSEGA
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGSTRT
                        INT 21H

                        MOV DX,OFFSET MSGDIRECT
                        MOV AH,09H
                        INT 21H

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:MEMDATA
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:MEMDATA
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:MEMDATA
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:MEMDATA
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:MEMDATA
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:MEMDATA
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:MEMDATA
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:MEMDATA
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:MEMDATA
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:MEMDATA
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:MEMDATA
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:MEMDATA
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        MOV DX,OFFSET MSGPASS
                        MOV AH,09H
                        INT 21H

                        MOV DX,OFFSET MSGDIRECTI
                        MOV AH,09H
                        INT 21H

                        XOR SI,SI
                        MOV DI,SI

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:MEMDATA[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:MEMDATA[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:MEMDATA[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:MEMDATA[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:MEMDATA[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:MEMDATA[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:MEMDATA[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:MEMDATA[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:MEMDATA[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:MEMDATA[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:MEMDATA[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:MEMDATA[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:MEMDATA[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:MEMDATA[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:MEMDATA[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:MEMDATA[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:MEMDATA[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:MEMDATA[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:MEMDATA[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:MEMDATA[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:MEMDATA[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:MEMDATA[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:MEMDATA[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:MEMDATA[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT
                        MOV DX,OFFSET MSGPASS
                        MOV AH,09H
                        INT 21H


                        MOV DX,OFFSET MSGINDIRECT
                        MOV AH,09H
                        INT 21H

                        MOV BX,OFFSET MEMDATA
                        MOV SI,BX
                        MOV DI,BX

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:[BX]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:[BX]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:[BX]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:[BX]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:[BX]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:[BX]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:[BX]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:[BX]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:[BX]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:[BX]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:[BX]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:[BX]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:[SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:[SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:[SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:[DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:[DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:[DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT



                        MOV DX,OFFSET MSGPASS
                        MOV AH,09H
                        INT 21H

                        MOV DX,OFFSET MSGBASE
                        MOV AH,09H
                        INT 21H

                        XOR SI,SI
                        MOV DI,SI

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:[BX][SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:[BX][SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:[BX][SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR DS:[BX][DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR DS:[BX][DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR DS:[BX][DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:[BX][SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:[BX][SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:[BX][SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR ES:[BX][DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR ES:[BX][DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR ES:[BX][DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:[BX][SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:[BX][SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:[BX][SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR FS:[BX][DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR FS:[BX][DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR FS:[BX][DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:[BX][SI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:[BX][SI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:[BX][SI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AL,BYTE PTR GS:[BX][DI]
                        CMP AL,0AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV AX,WORD PTR GS:[BX][DI]
                        CMP AX,0A5AAH
                        JNE ERRSPUT

                        XOR EAX,EAX
                        MOV EAX,DWORD PTR GS:[BX][DI]
                        CMP EAX,0555AA5AAH
                        JNE ERRSPUT

                        MOV DX,OFFSET MSGPASS
                        MOV AH,09H
                        INT 21H

                        JMP DONESPUT

ERRSPUT:                MOV DX,OFFSET MSGFAIL
                        MOV AH,09H
                        INT 21H

                        MOV DX,OFFSET MSGSEGA
                        MOV AH,09H
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGERROR
                        INT 21H

.EXIT

DONESPUT:               MOV AH,9
                        MOV DX,OFFSET MSGSEGA
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGDONE
                        INT 21H
;---------------------------------------------------------------------------
;Тест арифметико логического устройства-------------------------------------
                        MOV AH,9
                        MOV DX,OFFSET MSGALU
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGSTRT
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGMOVE
                        INT 21H

                        XOR EBX,EBX
                        LEA EAX,[EBX+3]
                        CMP EAX,3
                        JNE ERRIPU

                        BSWAP EAX
                        CMP EAX,03000000H
                        JNE ERRIPU

                        XCHG EAX,EBX
                        CMP EAX,0
                        JNE ERRIPU
                        CMP EBX,03000000H
                        JNE ERRIPU

                        MOV EAX,80000000H
                        CDQ
                        CMP EDX,0FFFFFFFFH
                        JNE ERRIPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGBIN
                        INT 21H

                        MOV EAX,0FFH
                        MOV EBX,001H
                        ADD EAX,EBX
                        CMP EAX,100H
                        JNE ERRIPU

                        MOV AH,0FFH
                        MOV AL,001H
                        ADD AH,AL
                        ADC AH,AL
                        CMP AH,2
                        JNE ERRIPU

                        XADD AH,AL
                        CMP AL,2
                        JNE ERRIPU
                        CMP AH,3
                        JNE ERRIPU

                        SUB AH,AL
                        CMP AH,1
                        JNE ERRIPU

                        MUL AH
                        CMP AX,2
                        JNE ERRIPU

                        IMUL AX
                        CMP EAX,4
                        JNE ERRIPU

                        MOV BX,1
                        DIV BX
                        CMP AX,4
                        JNE ERRIPU

                        IDIV AX
                        CMP AX,1
                        JNE ERRIPU

                        INC EAX
                        CMP EAX,2
                        JNE ERRIPU

                        DEC EAX
                        CMP EAX,1
                        JNE ERRIPU

                        NEG EAX
                        CMP EAX,0FFFFFFFFH
                        JNE ERRIPU


                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGDEC
                        INT 21H

                        MOV AL,19H
                        INC AL
                        DAA
                        CMP AL,20H
                        JNE ERRIPU

                        DEC AL
                        DAS
                        CMP AL,19H
                        JNE ERRIPU

                        MOV AX,0BH
                        AAA
                        CMP AX,101H
                        JNE ERRIPU

                        SUB AX,2
                        AAS
                        CMP AL,09H
                        JNE ERRIPU


                        MOV AL,5
                        MOV BL,5
                        MUL BL
                        AAM
                        CMP AX,205H
                        JNE ERRIPU

                        AAD
                        DIV BL
                        CMP AL,5
                        JNE ERRIPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGLOG
                        INT 21H

                        MOV EAX,0FH
                        AND EAX,0FH
                        CMP EAX,0FH
                        JNE ERRIPU

                        OR  EAX,0F0H
                        CMP EAX,0FFH
                        JNE ERRIPU

                        XOR EAX,EAX
                        CMP EAX,0
                        JNE ERRIPU

                        NOT EAX
                        CMP EAX,NOT 0
                        JNE ERRIPU


                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGSHIFT
                        INT 21H

                        MOV EAX,1
                        SAL EAX,1
                        CMP EAX,2
                        JNE ERRIPU

                        SHL EAX,1
                        CMP EAX,4
                        JNE ERRIPU

                        SHR EAX,1
                        CMP EAX,2
                        JNE ERRIPU

                        SAR EAX,1
                        CMP EAX,1
                        JNE ERRIPU

                        ROR EAX,1
                        CMP EAX,80000000H
                        JNE ERRIPU

                        ROL EAX,1
                        CMP EAX,1
                        JNE ERRIPU

                        RCR EAX,1
                        JNC ERRIPU

                        MOV EAX,80000000H
                        RCL EAX,1
                        JNC ERRIPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGBIT
                        INT 21H

                        MOV EAX,1
                        BT  EAX,0
                        JNC ERRIPU

                        BT  EAX,1
                        JC  ERRIPU

                        BTS EAX,1
                        CMP EAX,3
                        JNE ERRIPU

                        BTR EAX,0
                        CMP EAX,2
                        JNE ERRIPU

                        BTC EAX,1
                        CMP EAX,0
                        JNE ERRIPU

                        MOV EAX,80000001H
                        BSF EBX,EAX
                        CMP EBX,0
                        JNE ERRIPU

                        BSR EBX,EAX
                        CMP EBX,31
                        JNE ERRIPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        JMP DONEIPU

ERRIPU:                 MOV DX,OFFSET MSGFAIL
                        MOV AH,09H
                        INT 21H

                        MOV DX,OFFSET MSGALU
                        MOV AH,09H
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGERROR
                        INT 21H

.EXIT


DONEIPU:                MOV AH,9
                        MOV DX,OFFSET MSGALU
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGDONE
                        INT 21H

;Тест математического сопроцессора------------------------------------------

                        MOV DX,OFFSET MSGFPU
                        MOV AH,09H
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGSTRT
                        INT 21H

                        MOV DX,OFFSET MSGEXIST
                        MOV AH,09H
                        INT 21H

                        FINIT
                        FSTCW WORD PTR FPUDATA
                        MOV AX,WORD PTR FPUDATA
                        CMP AX,037FH
                        JNE ERRFPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV DX,OFFSET MSGMOVFPU
                        MOV AH,09H
                        INT 21H

                        MOV EAX,DWORD PTR FPUDATA
                        FLD DWORD PTR FPUDATA
                        FSTP DWORD PTR FPUDATA
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        MOV EAX,DWORD PTR FPUDATA
                        FILD DWORD PTR FPUDATA
                        FISTP DWORD PTR FPUDATA
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        XOR EBX,EBX
                        MOV DWORD PTR FPUDATA, EBX
                        FLD DWORD PTR FPUDATA
                        MOV DWORD PTR FPUDATA, EAX
                        FLD DWORD PTR FPUDATA
                        FXCH
                        FSTP DWORD PTR FPUDATA
                        CMP EBX,DWORD PTR FPUDATA
                        JNE ERRFPU
                        FSTP DWORD PTR FPUDATA
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV DX,OFFSET MSGBASEFPU
                        MOV AH,09H
                        INT 21H


                        MOV DWORD PTR FPUDATA,1
                        FILD DWORD PTR FPUDATA
                        MOV DWORD PTR FPUDATA,2
                        FILD DWORD PTR FPUDATA
                        FADD ST(0),ST(1)
                        FIST DWORD PTR FPUDATA
                        MOV EAX,3
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FSUB ST(0),ST(1)
                        FIST DWORD PTR FPUDATA
                        DEC EAX
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FMUL ST(0),ST(0)
                        FIST DWORD PTR FPUDATA
                        MOV EAX,4
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FDIV ST(0),ST(1)
                        FIST DWORD PTR FPUDATA
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FCHS
                        FIST DWORD PTR FPUDATA
                        NEG EAX
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FABS
                        FIST DWORD PTR FPUDATA
                        NEG EAX
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FSCALE
                        FIST DWORD PTR FPUDATA
                        MOV EAX,8
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FADD ST(0),ST(1)
                        FSQRT
                        FIST DWORD PTR FPUDATA
                        MOV EAX,3
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV DX,OFFSET MSGCMPFPU
                        MOV AH,09H
                        INT 21H

                        FCOM ST(1)
                        FSTSW AX
                        AND AX,0100010100000000B
                        CMP AX,0
                        JNE ERRFPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        MOV DX,OFFSET MSGTRANS
                        MOV AH,09H
                        INT 21H

                        FFREE

                        FLDPI
                        FSINCOS
                        FISTP DWORD PTR FPUDATA
                        MOV EAX,-1
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FISTP DWORD PTR FPUDATA
                        INC EAX
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FLDPI

                        FPTAN
                        FISTP DWORD PTR FPUDATA
                        MOV EAX,1
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        FISTP DWORD PTR FPUDATA
                        DEC EAX
                        CMP EAX,DWORD PTR FPUDATA
                        JNE ERRFPU

                        MOV AH,9
                        MOV DX,OFFSET MSGPASS
                        INT 21H

                        JMP DONEFPU
ERRFPU:
                        MOV DX,OFFSET MSGFAIL
                        MOV AH,09H
                        INT 21H

                        MOV DX,OFFSET MSGFPU
                        MOV AH,09H
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGERROR
                        INT 21H

.EXIT


DONEFPU:                MOV AH,9
                        MOV DX,OFFSET MSGFPU
                        INT 21H

                        MOV AH,9
                        MOV DX,OFFSET MSGDONE
                        INT 21H
;---------------------------------------------------------------------------

.EXIT



_TEXT ENDS




_DATA   SEGMENT WORD PUBLIC USE16 'DATA'

        msgtitl         DB 'CPU UNITs TEST by Michael V. VT-562 VSTU 2006',0DH,0AH,'$'
        msgstrt         DB ' start',0DH,0AH,'$'
        msgdone         DB ' done',0DH,0AH,'$'
        msgpass         DB ' pass',0DH,0AH,'$'
        msgfail         DB ' fail',0DH,0AH,'$'
        msgerror        DB ' error',0DH,0AH,'$'

        msgregs         DB '/REGISTERS TEST$'
        msgsega         DB '/SEGMENT PROCESSING UNIT TEST$'
        msgalu          DB '/IPU TEST$'
        msgfpu          DB '/FPU TEST$'

        msgeax          DB ' ->EAX:$'
        msgebx          DB ' ->EBX:$'
        msgecx          DB ' ->ECX:$'
        msgedx          DB ' ->EDX:$'
        msgesi          DB ' ->ESI:$'
        msgedi          DB ' ->EDI:$'
        msgebp          DB ' ->EBP:$'
        msgesp          DB ' ->ESP:$'
        msgds           DB ' ->DS: $'
        msges           DB ' ->ES: $'
        msgfs           DB ' ->FS: $'
        msggs           DB ' ->GS: $'
        msgss           DB ' ->SS: $'

        msgdirect       DB ' ->Direct:              $'
        msgdirecti      DB ' ->Direct with indexing:$'
        msgindirect     DB ' ->Indirect and base:   $'
        msgbase         DB ' ->Base with indexing:  $'
        memdata         DB 0AAH,0A5H,05AH,055H

        msgmove         DB ' ->Move instruction group:           $'
        msgbin          DB ' ->Bin. arithmetic instruction group:$'
        msgdec          DB ' ->Dec. arithmetic instruction group:$'
        msglog          DB ' ->Bin. logic instruction group:     $'
        msgshift        DB ' ->Bin. shift instruction group:     $'
        msgbit          DB ' ->Bit processing instruction group: $'

        msgexist        DB ' ->Exists                          :$'
        msgmovfpu       DB ' ->Move instruction group          :$'
        msgbasefpu      DB ' ->Arithmetic instruction group    :$'
        msgcmpfpu       DB ' ->Compare instruction group       :$'
        msgtrans        DB ' ->Transcendental instruction group:$'
        fpudata         DB 4 DUP(0)


_DATA ENDS

_STACK SEGMENT PARA STACK USE16 'STACK'
       STACKBUFFER      DB 100H DUP(?)
       STACKSIZE        EQU $-STACKBUFFER
_STACK ENDS

END   START

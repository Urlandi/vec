;������ୠ� ࠡ�� �믮����� ��ᨫ쥢� ��堨��� - ��� 262
;������ ��ப� � 1-�� �⫨�� ᨬ�����. �᫨ ������ �⮣� ᨬ����
;����� 3 �뢥�� ��ப� �� ��࠭ ��� �⮣� ᨬ����, ���� ᮮ�饭�� �� �⮬.

.MODEL TINY       ;.COM 䠩�
.DATA             ;������� ������

CSTRING DB 'ZZZZZZZZ0ZZZZZZ';��ப� ��� ��ࠡ�⪨
STRING_LENGTH EQU $-CSTRING ;����� �⮩ ��ப�
EMESS   DB '�⫨�� ᨬ��� ����� ������ �� ����� 3$' ;����饭�� ��� �뢮��

.CODE             ;������� ����
.STARTUP          ;��窠 �室�

        MOV DI,OFFSET CSTRING ;���� ��ப� ��� ࠡ���
        MOV SI,DI             ;�㡫��㥬 ��� ���쭥�襩 ࠡ���

        MOV CX,STRING_LENGTH  ;��=����� ��ப� ��� ࠡ���
        MOV DX,CX             ;�㡫��㥬 ��� ���쭥�襩 ࠡ���

        MOV AL,[DI]           ;� AL ���� ᨬ��� ��ப�

        CLD                   ;�����塞 ���� �� �����⠭��
REPE    SCASB                 ;�஢�ઠ ��ப� �� ES:[DI]
                              ;�� �⫨�� �� AL ᨬ���

        SUB DX,CX             ;����塞 ������ �⮣� ᨬ����
        CMP DX,3              ;�᫨ �� ����� 3 �
        JBE PRNMSS            ;���室�� ��� �뢮�� ᮮ�饭��

        ADD CX,DX             ;CX=����� ��ப� ��� ࠡ���
        MOV AH,[DI-1]         ;AH=�⫨�� ᨬ���

        MOV DX,0B800H         ;��⠭�������� ���� ����������
        MOV ES,DX             ;� ⥪�⮢�� ०��� 80�25 ��� �뢮�� ��ப�

        XOR DI,DI             ;���孨� ���� 㣮�

RL:     LODSB                 ;AL=ᨬ��� �� ����� DS:[SI]
        CMP AL,AH             ;�᫨ � AL �⫨�� ᨬ��� �
        JE RLC                ;�� �뢮��� ���

        MOV ES:[DI],AL        ;�뢮� ᨬ�����
        MOV ES:[DI]+1,BYTE PTR 1BH

        INC DI                ;DI=DI+2
        INC DI
RLC:    DEC CX                ;CX=CX-1
        JNZ RL                ;�᫨ CX �� 0 �����塞 ����
        JMP STOPS             ;�����

PRNMSS: MOV AH,09H            ;9-�� �㭪�� DOS API 21h
        MOV DX,OFFSET EMESS   ;DX=���� ��ப� ��� �뢮��
        INT 21H               ;�뢮��� ��ப�

STOPS:  XOR AH,AH             ;������� ������ �� ������
        INT 16H
        RET                   ;��室 �� �ணࠬ��
END
;������ୠ� ࠡ�� �믮����� ��ᨫ쥢� ��堨��� - ��� 262
;���ᨢ ��⮨� �� 5 ������⮢, �᫨ ������⢮ 1 � ���ᨬ��쭮�
;������� ����� 0 � �뢥�� ᮮ�饭�� �� �⮬. � ��⨢��� ��砥
;��६����� ������⥫�� �������� ���ᨢ� � ����� ������� �����.

        .MODEL TINY     ;.COM 䠩�
        .CODE
        ORG 100H        ;��室�� PSP

START:  JMP ENTRY       ;��室�� ���� ������� ��६�����

SARRAY  DB 1,-1,2,01111100b,-15 ;������ ��室�� ���ᨢ
IARRAY  DB 5 DUP (0)    ;����ࢨ�㥬 ���� ��� ��६�饭�� ������⥫���

;������ ᮮ�饭�� ��� ࠧ��� ��室�� �ணࠬ��
MSGNO   DB '� MAX ��-�� ���-�� 1 ������ ���������� 0: ��������� �� ���������!$'
MSGYE   DB '� MAX ��-�� ���-�� 1 �� ������ ���������� 0: ��������� ���������!$'

ENTRY:  MOV BX,OFFSET SARRAY ;BX = ���� ��室���� ���ᨢ�

;��室�� �������訩 �������

        XOR SI,SI      ;SI = 0
        MOV CL,5       ;CL = 5
        MOV DL,[BX]    ;DL = ���� ������� ��室���� ���ᨢ�

REP1:   MOV AL,[BX+SI] ;AL = ������� ���ᨢ� ����� SI
        CMP AL,DL      ;�᫨ AL < DL
        JL CONT1       ;�� ��ࠡ��뢠�� ⥫� 横��

        MOV DL,AL      ;���� DL = AL, �.�. DL - ���ᨬ����

CONT1:  INC SI         ;SI = SI + 1
        DEC CL         ;CL = CL - 1
        JNZ REP1       ;�᫨ CL = 0 �������� 横�

;��⠥� ������⢮ 1 � �⮬ �������

        MOV AL,DL      ;AL = DL, �.�. ���ᨬ���� � AL
        XOR DL,DL      ;DL = 0
        MOV CL,8       ;CL = 8

REP2:   ROR AL,1       ;�뤢����� �� AL 1 ��� � CF
        JNC NONE       ;�᫨ CF = 0 �� ��ࠡ��뢠�� ⥫� 横��

        INC DL         ;DL = DL + 1, ��⠥� ���-�� 1

NONE:   DEC CL         ;CL = CL - 1
        JNZ REP2       ;�᫨ CL = 0 �������� 横�

;���室�� �᫨ ������⢮ 1 ����� 0

        CMP DL,4
        JA BIGER

;�믮��塞 ����뫪�

        MOV CL,5             ;CL = 5
        MOV DI,OFFSET IARRAY ;DI = ���� ���ᨢ� �ਥ�����
        XOR SI,SI            ;SI = 0

REP3:   MOV AL,[BX+SI] ;AL = ������� ���ᨢ� ���筨�� ����� SI
        ADD AL,0       ;�᫨ AL < 0
        JS CONT2       ;�� ��ࠡ��뢠�� ⥫� 横��

        MOV [DI],AL    ;� ���ᨢ �ਥ���� ���뫠�� AL
        INC DI         ;DI = DI + 1, ᫥���騩 ������� � ���ᨢ� �ਥ�����

CONT2:  INC SI         ;SI = SI + 1
        DEC CL         ;CL = CL - 1
        JNZ REP3       ;�᫨ CL = 0 �������� 横�

        MOV DX,OFFSET MSGYE ;DX = ���� ��ப� ᮮ�饭�� - '���� ����뫪�'
        JMP QUIT            ;���室 �� ��� �����襭��

;�뢮��� ᮮ�饭��

BIGER:  MOV DX,OFFSET MSGNO ;DX = ���� ��ப� ᮮ�饭�� - '��� ����뫪�'

QUIT:   MOV AH,09H     ;9-�� �㭪�� DOS API INT21
        INT 21H        ;��।�� �ࠢ����� DOS

        INT 20H        ;�������� ࠡ���

END  START

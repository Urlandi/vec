#### Assembler Intel x86

#### Make
##### .EXE DOS file
         TASM !.ASM
         TLINK /x !.OBJ
##### .COM DOS file
         TASM !.ASM
         TLINK /t /x !.OBJ
##### 32-BIT DOS file
        TASM /m !.ASM
        TLINK /3 /x !.OBJ
##### Console WINDOWS file
         [WPREASM](../Pascal/WPREASM.PAS) !.ASM PROCCALL.INC
         TASM /m /ml !.ASM
         TLINK32 /Tpe /ap /c /x !.OBJ
##### GUI WINDOWS file
         [WPREASM](../Pascal/WPREASM.PAS/) !.ASM PROCCALL.INC
         TASM /m /ml !.ASM
         TLINK32 /Tpe /aa /c /x !.OBJ
##### GUI WINDOWS file + .RES file
         [WPREASM](../Pascal/WPREASM.PAS) !.ASM PROCCALL.INC
         TASM /x /m /ml !.ASM
         TLINK32 /Tpe /aa /c /x !.OBJ,,,,,!.RES]
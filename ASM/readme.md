#### Assembler Intel x86

- /FONT - Работа с текстовыми шрифтами, знакогенератором
- /FPU - Примеры выполнения инструкций на математическом сопроцессоре
- /LABSTUFF - Общие тесты на чтение/запись, наличие функций
- /PRLABS - Базовые операции
- /README - Отображение файла Windows GUI
- /RESIDENT - Резидентные программы, подмена функций различных программных прерываний
- /VIDEO - Графические эффекты
- /XORCrypt - Выполнение операции XOR над двумя строками
- /autoDDK - Сложение в двоично-десятичной системе. Используется конечный автомат

--------------------------------------------------------------------------------------------

- FAT_MAP.ASM - Отображает FAT12 в удобном виде, помечая соответственно занятые, свободные, сбойные кластеры.
- WINDEF.INC - Определения для WinAPI32

--------------------------------------------------------------------------------------------

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
        WPREASM !.ASM PROCCALL.INC
        TASM /m /ml !.ASM
        TLINK32 /Tpe /ap /c /x !.OBJ
##### GUI WINDOWS file
         WPREASM !.ASM PROCCALL.INC
         TASM /m /ml !.ASM
         TLINK32 /Tpe /aa /c /x !.OBJ
##### GUI WINDOWS file + .RES file
         WPREASM !.ASM PROCCALL.INC
         TASM /x /m /ml !.ASM
         TLINK32 /Tpe /aa /c /x !.OBJ,,,,,!.RES]

WPREASM source may found [here](../Pascal/WPREASM.PAS) and windef.inc [here](windef.inc)

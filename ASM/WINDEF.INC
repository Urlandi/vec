;<--------------------Library for windows procedures------------------------->

        includelib      c:\langs\tasm\lib\import32.lib

;<----------------Standart windows constants and structures------------------>

UCHAR   EQU <db>
USHORT  EQU <dw>
UINT    EQU <dd>
ULONG   EQU <dd>

RECT    struc
        Left          UINT ?
        Top           UINT ?
        Right         UINT ?
        Bottom        UINT ?
RECT    ends

WNDCLASSEX struc
        cbSize         UINT     ?
        Style          UINT     ?
        lpfnWndProc    ULONG    ?
        cbClsExtra     UINT     ?
        cbWndExtra     UINT     ?
        hInstance      UINT     ?
        hIcon          UINT     ?
        hCursor        UINT     ?
        hbrBackground  UINT     ?
        lpszMenuName   ULONG    ?
        lpszClassName  ULONG    ?
        hIconSm        UINT     ?
WNDCLASSEX ends

PAINTSTRUCT STRUC
    hdc         UINT             ?
    fErase      UINT             ?
    rcPaint     UCHAR            size RECT dup(?)
    fRestore    UINT             ?
    fIncUpdate  UINT             ?
    rgbReserved UCHAR            16 dup(?)
PAINTSTRUCT ENDS

MSG struc
    hwnd          UINT    ?
    message       UINT    ?
    wParam        UINT    ?
    lParam        ULONG   ?
    time          ULONG   ?
    pt            ULONG   ?
MSG ends

MINMAXINFO struc
  res_x               dd ?
  res_y               dd ?
  maxsize_x           dd ?
  maxsize_y           dd ?
  maxposition_x       dd ?
  maxposition_y       dd ?
  mintrackposition_x  dd ?
  mintrackposition_y  dd ?
  maxtrackposition_x  dd ?
  maxtrackposition_y  dd ?
MINMAXINFO ends

OPENFILENAME    struc
                lStructSize          dd ?
                hwndOwner            dd ?
                _hInstance           dd ?
                lpstrFilter          dd ?
                lpstrCustomFilter    dd ?
                nMaxCustFilter       dd ?
                nFilterIndex         dd ?
                lpstrFile            dd ?
                nMaxFile             dd ?
                lpstrFileTitle       dd ?
                nMaxFileTitle        dd ?
                lpstrInitialDir      dd ?
                lpstrTitle           dd ?
                Flags                dd ?
                nFileOffset          dw ?
                nFileExtension       dw ?
                lpstrDefExt          dd ?
                lCustData            dd ?
                lpfnHook             dd ?
                lpTemplateName       dd ?
OPENFILENAME    ends

WHITE_BRUSH         equ  0
LTGRAY_BRUSH        equ  1
GRAY_BRUSH          equ  2
DKGRAY_BRUSH        equ  3
BLACK_BRUSH         equ  4
NULL_BRUSH          equ  5
HOLLOW_BRUSH        equ  5
WHITE_PEN           equ  6
BLACK_PEN           equ  7
NULL_PEN            equ  8
DOT_MARKER          equ  9
OEM_FIXED_FONT      equ 10
ANSI_FIXED_FONT     equ 11
ANSI_VAR_FONT       equ 12
SYSTEM_FONT         equ 13
DEVICE_DEFAULT_FONT equ 14
DEFAULT_PALETTE     equ 15
SYSTEM_FIXED_FONT   equ 16

BS_SOLID        equ   0
BS_NULL         equ   1
BS_HOLLOW       equ   BS_NULL
BS_HATCHED      equ   2
BS_PATTERN      equ   3
BS_INDEXED      equ   4
BS_DIBPATTERN   equ   5

HS_HORIZONTAL   equ   0       ; -----
HS_VERTICAL     equ   1       ; |||||
HS_FDIAGONAL    equ   2       ; \\\\\
HS_BDIAGONAL    equ   3       ; /////
HS_CROSS        equ   4       ; +++++
HS_DIAGCROSS    equ   5       ; xxxxx

PS_SOLID        equ   0
PS_DASH         equ   1       ; -------
PS_DOT          equ   2       ; .......
PS_DASHDOT      equ   3       ; _._._._
PS_DASHDOTDOT   equ   4       ; _.._.._
PS_NULL         equ   5
PS_INSIDEFRAME  equ   6


WM_STATE            equ 0000H

WM_NULL             equ 0000h
WM_CREATE           equ 0001h
WM_DESTROY          equ 0002h
WM_MOVE             equ 0003h
WM_SIZE             equ 0005h
WM_ACTIVATE         equ 0006h
WM_SETFOCUS         equ 0007h
WM_KILLFOCUS        equ 0008h
WM_ENABLE           equ 000Ah
WM_SETREDRAW        equ 000Bh
WM_SETTEXT          equ 000Ch
WM_GETTEXT          equ 000Dh
WM_GETTEXTLENGTH    equ 000Eh
WM_PAINT            equ 000Fh
WM_CLOSE            equ 0010h
WM_QUERYENDSESSION  equ 0011h
WM_QUIT             equ 0012h
WM_QUERYOPEN        equ 0013h
WM_ERASEBKGND       equ 0014h
WM_SYSCOLORCHANGE   equ 0015h
WM_ENDSESSION       equ 0016h
WM_SYSTEMERROR      equ 0017h
WM_SHOWWINDOW       equ 0018h
WM_CTLCOLOR         equ 0019h
WM_WININICHANGE     equ 001Ah
WM_DEVMODECHANGE    equ 001Bh
WM_ACTIVATEAPP      equ 001Ch
WM_FONTCHANGE       equ 001Dh
WM_TIMECHANGE       equ 001Eh
WM_CANCELMODE       equ 001Fh
WM_SETCURSOR        equ 0020h
WM_MOUSEACTIVATE    equ 0021h
WM_CHILDACTIVATE    equ 0022h
WM_QUEUESYNC        equ 0023h
WM_GETMINMAXINFO    equ 0024h
WM_PAINTICON        equ 0026h
WM_ICONERASEBKGND   equ 0027h
WM_NEXTDLGCTL       equ 0028h
WM_SPOOLERSTATUS    equ 002Ah
WM_DRAWITEM         equ 002Bh
WM_MEASUREITEM      equ 002Ch
WM_DELETEITEM       equ 002Dh
WM_VKEYTOITEM       equ 002Eh
WM_CHARTOITEM       equ 002Fh
WM_SETFONT          equ 0030h
WM_GETFONT          equ 0031h
WM_QUERYDRAGICON    equ 0037h
WM_COMPAREITEM      equ 0039h
WM_COMPACTING       equ 0041h
WM_COMMNOTIFY       equ 0044h
WM_WINDOWPOSCHANGING equ 0046h
WM_WINDOWPOSCHANGED equ 0047h
WM_POWER            equ 0048h

WM_NCCREATE         equ 0081h
WM_NCDESTROY        equ 0082h
WM_NCCALCSIZE       equ 0083h
WM_NCHITTEST        equ 0084h
WM_NCPAINT          equ 0085h
WM_NCACTIVATE       equ 0086h
WM_GETDLGCODE       equ 0087h
WM_NCMOUSEMOVE      equ 00A0h
WM_NCLBUTTONDOWN    equ 00A1h
WM_NCLBUTTONUP      equ 00A2h
WM_NCLBUTTONDBLCLK  equ 00A3h
WM_NCRBUTTONDOWN    equ 00A4h
WM_NCRBUTTONUP      equ 00A5h
WM_NCRBUTTONDBLCLK  equ 00A6h
WM_NCMBUTTONDOWN    equ 00A7h
WM_NCMBUTTONUP      equ 00A8h
WM_NCMBUTTONDBLCLK  equ 00A9h

WM_KEYFIRST         equ 0100h
WM_KEYDOWN          equ 0100h
WM_KEYUP            equ 0101h
WM_CHAR             equ 0102h
WM_DEADCHAR         equ 0103h
WM_SYSKEYDOWN       equ 0104h
WM_SYSKEYUP         equ 0105h
WM_SYSCHAR          equ 0106h
WM_SYSDEADCHAR      equ 0107h
WM_KEYLAST          equ 0108h

WM_INITDIALOG       equ 0110h
WM_COMMAND          equ 0111h
WM_SYSCOMMAND       equ 0112h
WM_TIMER            equ 0113h
WM_HSCROLL          equ 0114h
WM_VSCROLL          equ 0115h
WM_INITMENU         equ 0116h
WM_INITMENUPOPUP    equ 0117h
WM_MENUSELECT       equ 011Fh
WM_MENUCHAR         equ 0120h
WM_ENTERIDLE        equ 0121h


WM_MOUSEFIRST       equ 0200h
WM_MOUSEMOVE        equ 0200h
WM_LBUTTONDOWN      equ 0201h
WM_LBUTTONUP        equ 0202h
WM_LBUTTONDBLCLK    equ 0203h
WM_RBUTTONDOWN      equ 0204h
WM_RBUTTONUP        equ 0205h
WM_RBUTTONDBLCLK    equ 0206h
WM_MBUTTONDOWN      equ 0207h
WM_MBUTTONUP        equ 0208h
WM_MBUTTONDBLCLK    equ 0209h
WM_MOUSELAST        equ 0209h

WM_PARENTNOTIFY     equ 0210h
WM_MDICREATE        equ 0220h
WM_MDIDESTROY       equ 0221h
WM_MDIACTIVATE      equ 0222h
WM_MDIRESTORE       equ 0223h
WM_MDINEXT          equ 0224h
WM_MDIMAXIMIZE      equ 0225h
WM_MDITILE          equ 0226h
WM_MDICASCADE       equ 0227h
WM_MDIICONARRANGE   equ 0228h
WM_MDIGETACTIVE     equ 0229h
WM_MDISETMENU       equ 0230h
WM_DROPFILES        equ 0233h


WM_CUT              equ 0300h
WM_COPY             equ 0301h
WM_PASTE            equ 0302h
WM_CLEAR            equ 0303h
WM_UNDO             equ 0304h
WM_RENDERFORMAT     equ 0305h
WM_RENDERALLFORMATS equ 0306h
WM_DESTROYCLIPBOARD equ 0307h
WM_DRAWCLIPBOARD    equ 0308h
WM_PAINTCLIPBOARD   equ 0309h
WM_VSCROLLCLIPBOARD equ 030Ah
WM_SIZECLIPBOARD    equ 030Bh
WM_ASKCBFORMATNAME  equ 030Ch
WM_CHANGECBCHAIN    equ 030Dh
WM_HSCROLLCLIPBOARD equ 030Eh
WM_QUERYNEWPALETTE  equ 030Fh
WM_PALETTEISCHANGING equ 0310h
WM_PALETTECHANGED   equ 0311h

WM_PENWINFIRST      equ 0380h
WM_PENWINLAST       equ 038Fh

WM_COALESCE_FIRST  equ 0390h
WM_COALESCE_LAST   equ 039Fh


WM_USER             equ 0400H


MA_ACTIVATE       equ  1
MA_ACTIVATEANDEAT equ  2
MA_NOACTIVATE     equ  3


SIZENORMAL       equ 0
SIZEICONIC       equ 1
SIZEFULLSCREEN   equ 2
SIZEZOOMSHOW     equ 3
SIZEZOOMHIDE     equ 4


SW_HIDE            equ 0
SW_SHOWNORMAL      equ 1
SW_NORMAL          equ 1
SW_SHOWMINIMIZED   equ 2
SW_SHOWMAXIMIZED   equ 3
SW_MAXIMIZE        equ 3
SW_SHOWNOACTIVATE  equ 4
SW_SHOW            equ 5
SW_MINIMIZE        equ 6
SW_SHOWMINNOACTIVE equ 7
SW_SHOWNA          equ 8
SW_RESTORE         equ 9


HIDE_WINDOW         equ 0
SHOW_OPENWINDOW     equ 1
SHOW_ICONWINDOW     equ 2
SHOW_FULLSCREEN     equ 3
SHOW_OPENNOACTIVATE equ 4


SW_PARENTCLOSING equ  1
SW_OTHERZOOM     equ  2
SW_PARENTOPENING equ  3
SW_OTHERUNZOOM   equ  4

MK_LBUTTON       equ 0001h
MK_RBUTTON       equ 0002h
MK_SHIFT         equ 0004h
MK_CONTROL       equ 0008h
MK_MBUTTON       equ 0010h

CS_VREDRAW         equ 0001h
CS_HREDRAW         equ 0002h
CS_KEYCVTWINDOW    equ 0004H
CS_DBLCLKS         equ 0008h
;                  0010h reserved
CS_OWNDC           equ 0020h
CS_CLASSDC         equ 0040h
CS_PARENTDC        equ 0080h
CS_NOKEYCVT        equ 0100h
CS_SAVEBITS        equ 0800h
CS_NOCLOSE         equ 0200h
CS_BYTEALIGNCLIENT equ 1000h
CS_BYTEALIGNWINDOW equ 2000h
CS_GLOBALCLASS     equ 4000


CW_USEDEFAULT   EQU    8000h


WS_OVERLAPPED   equ 000000000h
WS_ICONICPOPUP  equ 0C0000000h
WS_POPUP        equ 080000000h
WS_CHILD        equ 040000000h
WS_MINIMIZE     equ 020000000h
WS_VISIBLE      equ 010000000h
WS_DISABLED     equ 008000000h
WS_CLIPSIBLINGS equ 004000000h
WS_CLIPCHILDREN equ 002000000h
WS_MAXIMIZE     equ 001000000h
WS_CAPTION      equ 000C00000h     ; WS_BORDER | WS_DLGFRAME
WS_BORDER       equ 000800000h
WS_DLGFRAME     equ 000400000h
WS_VSCROLL      equ 000200000h
WS_HSCROLL      equ 000100000h
WS_SYSMENU      equ 000080000h
WS_THICKFRAME   equ 000040000h
WS_HREDRAW      equ 000020000h
WS_VREDRAW      equ 000010000h
WS_GROUP        equ 000020000h
WS_TABSTOP      equ 000010000h
WS_MINIMIZEBOX  equ 000020000h
WS_MAXIMIZEBOX  equ 000010000h



WS_OVERLAPPEDWINDOW equ WS_OVERLAPPED OR WS_CAPTION OR WS_SYSMENU OR WS_THICKFRAME OR WS_MINIMIZEBOX OR WS_MAXIMIZEBOX
WS_POPUPWINDOW  equ WS_POPUP OR WS_BORDER OR WS_SYSMENU
WS_CHILDWINDOW  equ WS_CHILD
WS_TILEDWINDOW  equ WS_OVERLAPPEDWINDOW

WS_TILED        equ WS_OVERLAPPED
WS_ICONIC       equ WS_MINIMIZE
WS_SIZEBOX      equ WS_THICKFRAME


WS_EX_DLGMODALFRAME  equ 0001
WS_EX_DRAGOBJECT     equ 0002
WS_EX_NOPARENTNOTIFY equ 0004
WS_EX_TOPMOST        equ 0008
WS_EX_CLIENTEDGE     equ 200h



PM_NOREMOVE    equ 0000h
PM_REMOVE      equ 0001h
PM_NOYIELD     equ 0002h


SWP_NOSIZE       equ  0001h
SWP_NOMOVE       equ  0002h
SWP_NOZORDER     equ  0004h
SWP_NOREDRAW     equ  0008h
SWP_NOACTIVATE   equ  0010h
SWP_DRAWFRAME    equ  0020h
SWP_SHOWWINDOW   equ  0040h
SWP_HIDEWINDOW   equ  0080h
SWP_NOCOPYBITS   equ  0100h
SWP_NOREPOSITION equ  0200h

IDC_ARROW       equ 32512
IDC_IBEAM       equ 32513
IDC_WAIT        equ 32514
IDC_CROSS       equ 32515
IDC_UPARROW     equ 32516
IDC_SIZE        equ 32640
IDC_ICON        equ 32641
IDC_SIZENWSE    equ 32642
IDC_SIZENESW    equ 32643
IDC_SIZEWE      equ 32644
IDC_SIZENS      equ 32645

IDI_APPLICATION equ 32512
IDI_HAND        equ 32513
IDI_QUESTION    equ 32514
IDI_EXCLAMATION equ 32515
IDI_ASTERISK    equ 32516

COLOR_SCROLLBAR           equ 0
COLOR_BACKGROUND          equ 1
COLOR_ACTIVECAPTION       equ 2
COLOR_INACTIVECAPTION     equ 3
COLOR_MENU                equ 4
COLOR_WINDOW              equ 5
COLOR_WINDOWFRAME         equ 6
COLOR_MENUTEXT            equ 7
COLOR_WINDOWTEXT          equ 8
COLOR_CAPTIONTEXT         equ 9
COLOR_ACTIVEBORDER        equ 10
COLOR_INACTIVEBORDER      equ 11
COLOR_APPWORKSPACE        equ 12
COLOR_HIGHLIGHT           equ 13
COLOR_HIGHLIGHTTEXT       equ 14
COLOR_BTNFACE             equ 15
COLOR_BTNSHADOW           equ 16
COLOR_GRAYTEXT            equ 17
COLOR_BTNTEXT             equ 18


MB_OK                   equ 0000H
MB_OKCANCEL             equ 0001H
MB_ABORTRETRYIGNORE     equ 0002H
MB_YESNOCANCEL          equ 0003H
MB_YESNO                equ 0004H
MB_RETRYCANCEL          equ 0005H

MB_ICONHAND             equ 0010H
MB_ICONQUESTION         equ 0020H
MB_ICONEXCLAMATION      equ 0030H
MB_ICONWARNING          equ 0030H
MB_ICONASTERISK         equ 0040H

MB_DEFBUTTON1           equ 0000H
MB_DEFBUTTON2           equ 0100H
MB_DEFBUTTON3           equ 0200H

MB_APPLMODAL            equ 0000H
MB_SYSTEMMODAL          equ 1000H
MB_TASKMODAL            equ 2000H

MB_NOFOCUS              equ 8000H
MB_SETFOREGROUND        equ 10000H

ES_LEFT                 equ 0000H
ES_CENTER               equ 0001H
ES_RIGHT                equ 0002H
ES_MULTILINE            equ 0004H
ES_UPPERCASE            equ 0008H
ES_LOWERCASE            equ 0010H
ES_PASSWORD             equ 0020H
ES_AUTOVSCROLL          equ 0040H
ES_AUTOHSCROLL          equ 0080H
ES_NOHIDESEL            equ 0100H
ES_OEMCONVERT           equ 0400H
ES_READONLY             equ 0800H
ES_WANTRETURN           equ 1000H

FILE_ATTRIBUTE_READONLY      equ 00000001H
FILE_ATTRIBUTE_HIDDEN        equ 00000002H
FILE_ATTRIBUTE_SYSTEM        equ 00000004H
FILE_ATTRIBUTE_DIRECTORY     equ 00000010H
FILE_ATTRIBUTE_ARCHIVE       equ 00000020H
FILE_ATTRIBUTE_NORMAL        equ 00000080H
FILE_ATTRIBUTE_TEMPORARY     equ 00000100H
FILE_FLAG_WRITE_THROUGH      equ 80000000H
FILE_FLAG_RANDOM_ACCESS      equ 10000000H

GENERIC_READ            equ 80000000H
GENERIC_WRITE           equ 40000000H
FILE_SHARE_READ         equ 00000001H
FILE_SHARE_WRITE        equ 00000002H

CREATE_NEW          equ 1
CREATE_ALWAYS       equ 2
OPEN_EXISTING       equ 3
OPEN_ALWAYS         equ 4
TRUNCATE_EXISTING   equ 5

INVALID_HANDLE_VALUE    equ -1

GMEM_FIXED       equ 0000H
GMEM_MOVEABLE    equ 0002H
GMEM_NOCOMPACT   equ 0010H
GMEM_NODISCARD   equ 0020H
GMEM_ZEROINIT    equ 0040H
GMEM_MODIFY      equ 0080H
GMEM_DISCARDABLE equ 0100H
GMEM_NOT_BANKED  equ 1000H
GMEM_DDESHARE    equ 2000H
GMEM_SHARE       equ 2000H
GMEM_NOTIFY      equ 4000H

IDOK     equ   1
IDABORT  equ   3
IDRETRY  equ   4
IDIGNORE equ   5
IDYES    equ   6
IDNO     equ   7

CB_GETEDITSEL    equ WM_USER+0
CB_LIMITTEXT     equ WM_USER+1
CB_SETEDITSEL    equ WM_USER+2
CB_ADDSTRING     equ WM_USER+3
CB_DELETESTRING  equ WM_USER+4
CB_DIR           equ WM_USER+5
CB_GETCOUNT      equ WM_USER+6
CB_GETCURSEL     equ WM_USER+7
CB_GETLBTEXT     equ WM_USER+8
CB_GETLBTEXTLEN  equ WM_USER+9
CB_INSERTSTRING  equ WM_USER+10
CB_RESETCONTENT  equ WM_USER+11
CB_FINDSTRING    equ WM_USER+12
CB_SELECTSTRING  equ WM_USER+13
CB_SETCURSEL     equ WM_USER+14
CB_SHOWDROPDOWN  equ WM_USER+15
CB_GETITEMDATA   equ WM_USER+16
CB_SETITEMDATA   equ WM_USER+17
CB_GETDROPPEDCONTROLRECT  equ WM_USER+18
CB_SETITEMHEIGHT equ WM_USER+19
CB_GETITEMHEIGHT equ WM_USER+20
CB_SETEXTENDEDUI equ WM_USER+21
CB_GETEXTENDEDUI equ WM_USER+22
CB_GETDROPPEDSTATE  equ WM_USER+23
CB_FINDSTRINGEXACT  equ WM_USER+24

EM_GETHANDLE    equ 0BDH
EM_GETMODIFY    equ 0B8H
EM_SETMODIFY    equ 0B9H
EM_UNDO         equ 0C7H
EM_SETSEL       equ 0B1H

OFN_PATHMUSTEXIST       equ 800h
OFN_FILEMUSTEXIST       equ 1000h
OFN_EXPLORER            equ 80000h
OFN_OVERWRITEPROMPT     equ 2


;<----------------------Definition used procedures--------------------------->

        include         proccall.inc
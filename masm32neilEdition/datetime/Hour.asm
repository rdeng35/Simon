.586
.MODEL FLAT,STDCALL
OPTION CASEMAP:NONE

INCLUDE \masm32\include\windows.inc
INCLUDE \masm32\include\kernel32.inc
INCLUDE DateTime.inc

.CODE
;---------------------------------------
Hour PROC pdt:PTR DATETIME

    LOCAL _st:SYSTEMTIME
    
    INVOKE FileTimeToSystemTime, pdt, ADDR _st
    .IF eax == 0
        mov eax, -1
    .ELSE    
        movzx eax, _st.wHour
    .ENDIF    
    ret
Hour ENDP
;---------------------------------------
END
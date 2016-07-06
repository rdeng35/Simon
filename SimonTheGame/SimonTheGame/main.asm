TITLE Simon The Game 
COMMENT @ 
Authors: Neil Hanlon, Zach Zeigler, Michael Welch, Raymond Deng
Goal: Game that lights up four regions in a randomized order 
and requires the user to copy the order. Game stops after level 15.
@

INCLUDE \masm32neilEdition\include\masm32rt.inc
INCLUDE \masm32neilEdition\include\winmm.inc
INCLUDELIB \masm32neilEdition\lib\winmm.lib
INCLUDE Irvine32_NOWIN.inc
.stack 8192h

REGION STRUCT
		start COORD <>
		_length DWORD 0
REGION ENDS

FlashRegion PROTO, REGION_NUM:BYTE
DoFlash PROTO, COLOR:WORD, LIGHT_COLOR:WORD, FLASH_REGION:PTR REGION, REGION_LENGTH:DWORD

.data
	rHnd HANDLE ?
	wHnd HANDLE ?

	numEventsRead DWORD ?
	numEventsOccurred DWORD ?
	eventBuffer INPUT_RECORD 128 DUP(<>)

	scorepos COORD <0,37>
	wind_size SMALL_RECT {0,0,68,37}
	splash_wind_size SMALL_RECT {0,0,77,37}

	lol DWORD 0
	levels BYTE 1000 dup(?)
	arraypos DWORD ?
	score DWORD 0
	scoreText BYTE "Score :",0

    LevelUp BYTE "C:\Irvine\LevelUp.wav",0
	WinSound BYTE "C:\Irvine\WinSound.wav",0
	GameOverSound BYTE "C:\Irvine\GameOver.wav",0

	stringbuffer BYTE 21 DUP(0)
	stringSize DWORD ?

	Dialogue BYTE 0ah,0dh,"		  Welcome to the Mighty Game of Simon!"
	           BYTE 0ah,0dh, "		  Enter H if you want to read the rules", 0dh,0ah, "	     Enter any other character to begin your journey!",0

	Instructions BYTE 0ah,0dh,"				 How to Play",0ah,0dh,0ah,0dh,"   Follow the pattern of lights until you think you can't go any further." , 0dh ,0ah
	           BYTE "	A random color will light up after every successful level",0dh,0ah, "	  Try to replicate the order that the lights are pressed.", 0dh , 0ah
	           BYTE 0dh,0ah,"     Press ANY KEY to begin your journey to be the Ultimate Copy Cat!", 0dh , 0ah ,0
	endGameScore BYTE 0dh,0ah,"Your Final Score: ",0

	GameOverTitle  BYTE"     #####                          #######                      ",0dh,0ah
            	BYTE"    #     #   ##   #    # ######    #     # #    # ###### #####  ",0dh,0ah
            	BYTE"    #        #  #  ##  ## #         #     # #    # #      #    # ",0dh,0ah
            	BYTE"    #  #### #    # # ## # #####     #     # #    # #####  #    # ",0dh,0ah
            	BYTE"    #     # ###### #    # #         #     # #    # #      #####  ",0dh,0ah
            	BYTE"    #     # #    # #    # #         #     #  #  #  #      #   #  ",0dh,0ah
            	BYTE"     #####  #    # #    # ######    #######   ##   ###### #    # ",0dh,0ah,0
	go_size word ($-GameOverTitle) - 1

	splashScreen    BYTE "                    ii                                                        ",0dh,0ah
                	BYTE "                   i::i                                                       ",0dh,0ah
                	BYTE "    sssssssss       ii    mmmmmmmm  mmmmmmm     oooooooooooo    nnnnnnnnnnnn  ",0dh,0ah
                	BYTE "  ss::::::::ss            m::::::m  m:::::m    oo::::::::::oo   n::::::::::n  ",0dh,0ah
                	BYTE "ss:::::::::::ss    iii   m::::::::m::::::::m  o:::::::::::::o  nn::::::::::nn ",0dh,0ah
                	BYTE "s:::::ssss:::::s   i:i   m:::::::::::::::::m  o::::ooooo::::o  n::::::::::::n ",0dh,0ah
                	BYTE "ss::::s  sssssss   i:i   m:::mmm:::::mmm:::m  o:::o     o:::o  n:::nnnnnn:::n ",0dh,0ah
                	BYTE "   s::::::s        i:i   m::m   m:::m   m::m  o:::o     o:::o  n:::n    n:::n ",0dh,0ah
                	BYTE "      s::::::s     i:i   m::m   m:::m   m::m  o:::o     o:::o  n:::n    n:::n ",0dh,0ah
                	BYTE "ssssss   s::::s    i:i   m::m   m:::m   m::m  o:::o     o:::o  n:::n    n:::n ",0dh,0ah
                	BYTE "s:::::ssss::::s   i:::i  m::m   m:::m   m::m  o::::ooooo::::o  n:::n    n:::n ",0dh,0ah
                	BYTE "s::::::::::::s    i:::i  m::m   m:::m   m::m  o:::::::::::::o  n:::n    n:::n ",0dh,0ah
                	BYTE " s::::::::::s     i:::i  m::m   m:::m   m::m   oo:::::::::oo   n:::n    n:::n ",0dh,0ah
                	BYTE "  ssssssssss      iiiii  mmmm   mmmmm   mmmm     oooooooooo    nnnnn    nnnnn ",0dh,0ah,0
	splash_size word ($-splashScreen) - 1

	winScreen    byte "        __     __             _    _                    ",0dh,0ah
				 byte "        \ \   / /            | |  | |                   ",0dh,0ah
				 byte "         \ \_/ /___   _   _  | |__| |  __ _ __   __ ___ ",0dh,0ah
				 byte "          \   // _ \ | | | | |  __  | / _` |\ \ / // _ \",0dh,0ah
				 byte "           | || (_) || |_| | | |  | || (_| | \ V /|  __/",0dh,0ah
				 byte "           |_| \___/  \__,_| |_|  |_| \__,_|  \_/  \___|        ",0dh,0ah
				 byte "   ____                _      _____  _                          ",0dh,0ah
				 byte "  |  _ \              | |    / ____|(_)                         ",0dh,0ah
				 byte "  | |_) |  ___   __ _ | |_  | (___   _  _ __ ___    ___   _ __  ",0dh,0ah
				 byte "  |  _ <  / _ \ / _` || __|  \___ \ | || '_ ` _ \  / _ \ | '_ \ ",0dh,0ah
				 byte "  | |_) ||  __/| (_| || |_   ____) || || | | | | || (_) || | | |",0dh,0ah
				 byte "  |____/  \___| \__,_| \__| |_____/ |_||_| |_| |_| \___/ |_| |_|",0dh,0ah,0

				 win_size word ($-winScreen) -1

	simonascii  byte  "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
            byte"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@@@@@@@@@,,,,,,,@@"
            byte"@@,,,,,,,@@@@@@@@@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@@@@,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,@@@@@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@",0dh,0ah
            byte "@@@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@",0dh,0ah
            byte "@@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@",0dh,0ah
            byte "@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@",0dh,0ah
            byte "@@@@,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@"
            byte"@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,@@@@",0dh,0ah
            byte "@@@,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@"
            byte"@@@@@@@@,,,,,,,,,,,,,,,,,,,,,,,@@@",0dh,0ah
            byte "@@,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@"
            byte"@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,,@@@",0dh,0ah
            byte "@@,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@"
            byte"@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,@@",0dh,0ah
            byte "@,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@"
            byte"@@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,@@",0dh,0ah
            byte "@,,,,,,,,,,,,,,,,,,@@@@_____ _ @@@"
            byte"@@@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@@@@@@|   __|_|___"
            byte"__ ___ ___ @@@@@@@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@@@@@@|__   | |   "
            byte"  | . |   |@@@@@@@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@,,,,,,,,,,,,,,,,,,@@@|_____|_|_|_"
            byte"|_|___|_|_|@@@,,,,,,,,,,,,,,,,,,,@",0dh,0ah
            byte "@,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@"
            byte"@@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,@",0dh,0ah
            byte "@,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@"
            byte"@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,@@",0dh,0ah
            byte "@,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@"
            byte"@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,,@@",0dh,0ah
            byte "@@,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@"
            byte"@@@@@@@@@,,,,,,,,,,,,,,,,,,,,,,,@@",0dh,0ah
            byte "@@@,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@"
            byte"@@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,@@@",0dh,0ah
            byte "@@@,,,,,,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@",0dh,0ah
            byte "@@@@,,,,,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@",0dh,0ah
            byte "@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@",0dh,0ah
            byte "@@@@@@,,,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@",0dh,0ah
            byte "@@@@@@@@,,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@,,,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@,,,,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@,,,,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,,,,@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@@@,,,,,,,,,,,,,@@"
            byte"@@,,,,,,,,,,,,,@@@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@@@@@@@,,,,,,,,,@@"
            byte"@@,,,,,,,,,@@@@@@@@@@@@@@@@@@@@@@@",0dh,0ah
            byte "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
            byte"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@",0dh,0ah,0
	msg_size word ($-simonascii) - 1

.code
main PROC

	;Setup Handles
	invoke GetStdHandle, STD_INPUT_HANDLE
    mov rHnd, eax
    invoke GetStdHandle, STD_OUTPUT_HANDLE
    mov wHnd, eax
	;Set screen size
    invoke SetConsoleWindowInfo, wHnd, 1, offset splash_wind_size
	;Set mode for execution with console mouse input
    invoke SetConsoleMode, rHnd, ENABLE_LINE_INPUT OR ENABLE_MOUSE_INPUT    OR ENABLE_EXTENDED_FLAGS

	call Randomize ;Seeds

	call drawSplash ;creates the title screen

    prompt:
        mov edx, OFFSET Dialogue ;Prepares for printing start screen message.
        call WriteString ;Prints start screen message.
        call Crlf
        call ReadChar ;waits for user to enter an h regardless of case or hit any other key.
        cmp al,'H' 
        je helpMenu ;if user does enter h then they are shown the help menu

        cmp al,'h'
        je helpMenu 
        jmp checkPlay ; if any other key the game begins

    helpMenu:
            call drawHelp ;creates help screen

    checkPlay:
		invoke SetConsoleWindowInfo, wHnd, 1, offset wind_size ;the window is resized for the game play.
        call beginGame ;calls start of making game screen 
    eom:
        invoke ExitProcess, 0
        ret
main ENDP

beginGame PROC USES EAX
    call Clrscr ;window is resized but still must be cleared
    push eax ;preserves value of eax
    mov eax, 15 + (0*16) 
    call SetTextColor ;text color is set to white
    pop eax ;eax is restored to value before textcolor was set. 
    call DrawSimon ;creates the simon game board
    call SiNum
    ret
beginGame endp

drawHelp PROC USES EAX ESI ECX
    call Clrscr
    call drawSplash ; Draws the Splash Logo

    mov eax, 15 + (0*16)		;Changes the text color to white
    call SetTextColor		
    call Crlf
    call Crlf
    mov edx, OFFSET Instructions
    call WriteString
    call Crlf
    call ReadChar		;Reads the next character to begin the game.

    ret
drawHelp ENDP

drawGameOver PROC USES ESI ECX EAX EDX ;Displays gamemover screen
	mov edx, 000B0000h			
    call GoToPos			;Moves the position of the cursor to Y = 11
	mov eax, 12 + (0*16) ;Sets text to red
	call SetTextColor

    mov esi, OFFSET GameOverTitle
    movzx ecx, go_size

    Jim:
        mov al, byte ptr [esi]
        call WriteChar
        inc esi
    loop Jim

	mov edx, OFFSET endGameScore 
	call WriteString
	mov eax, score
	call WriteDec
	call Crlf

    ret
drawGameOver endp

drawWin PROC USES ESI ECX EAX ;created winning screen and displays final score
mov eax, 10
INVOKE SetTextColor
mov edx, 000B0000h
call GoToPos
mov esi,OFFSET winScreen
movzx ecx, win_size

Jim:
	mov al, byte ptr [esi]
	call WriteChar
	inc esi
loop Jim

mov edx, OFFSET endGameScore
call WriteString
mov eax, score
call WriteDec
call Crlf

ret
drawWin endp

drawSplash PROC USES ESI ECX EAX EDX EBX
	mov edx, 000B0000h
    call GoToPos
	mov esi, OFFSET splashScreen
	movzx ecx, splash_size

	Jim: ;checks characters for creating different colored ascii art leters
	mov al, byte ptr [esi]
		cmp al, 's'
		je colorS
		jmp checkI

		colorS:
			call setGreen
			mov bl,1
			jmp write_it

		checkI:
			cmp al,'i'
			je colorI
			jmp checkM

		colorI:
			call setRed
			mov bl,2
			jmp write_it

		checkM:
			cmp al,'m'
			je colorM
			jmp checkO

		colorM:
			call setYellow
			mov bl,3
			jmp write_it


		checkO:
			cmp al,'o'
			je colorO
			jmp checkN

		colorO:
			call setBlue
			mov bl,4
			jmp write_it

		checkN:
			cmp al,'n'
			je colorN
			jmp checkSemi

		colorN:
			call setWhite
			mov bl,5
			jmp write_it

		checkSemi:
			cmp al, ':'
			je checkLetter
			jmp write_it

		checkLetter:
			call paintSemi

		write_it:
			call WriteChar
			inc esi

	loop Jim

ret
drawSplash endp

setGreen PROC USES EAX
    mov eax, 2+(0*16)   ;Sets Text to Green
    call SetTextColor
ret
setGreen endp

setRed PROC USES EAX
    mov eax, 4+(0*16)   ;Sets Text to Red
    call SetTextColor
ret
setRed endp

setYellow PROC USES EAX
    mov eax, 14+(0*16)  ;Sets Text to Yellow
    call SetTextColor
ret
setYellow endp

setBlue PROC USES EAX
    mov eax, 9+(0*16)   ;Sets Text to Blue
    call SetTextColor
ret
setBlue endp

setWhite PROC USES EAX
    mov eax, 15+(0*16)  ;Sets Text to White
    call SetTextColor
ret
setWhite endp

paintSemi PROC USES EAX
    .IF bl == 1
        mov eax, 2+(2*16)   ;Sets Background and Text to Green
        call SetTextColor
    .ELSEIF bl == 2
        mov eax, 4+(4*16)   ;Sets Background and Text to Red
        call SetTextColor
    .ELSEIF bl == 3
        mov eax, 14+(14*16) ;Sets Background and Text to Yellow
        call SetTextColor
    .ELSEIF bl == 4
        mov eax, 9+(9*16)   ;Sets Background and Text to Blue
        call SetTextColor
    .ELSEIF bl == 5
        mov eax, 15+(15*16) ;Sets Background and Text to White
        call SetTextColor
    .ENDIF

ret
paintSemi endp

SiNum PROC

    mov esi, OFFSET levels
    mov ecx, 1

    forever: ;this first part will create an random value from 1 - 4 and add it to the array levels
        mov eax, 0
        mov eax, 4
        call RandomRange
        add al, 1
        mov [esi], al
        add esi, TYPE levels
        add lol, 1 ;lol stands for length of levels
        add ecx, 1

        ;Begins second phase(Display array by associating each number to a color)
        call Display

        ;Array has now been displayed
        ;Now get and compare user input to array succession
        push ecx ;preserves value of ecx
        push esi ;preserver value of esi

        mov ecx, lol
        mov esi, OFFSET levels

        UtoA:
         	mov eax, 0
         	call checkMouseClick
         	cmp dl, [esi]
         	jne GameOver ;write what to do if user input and current index value don't match
         	add esi, 1
        Loop UtoA

        call playLevelUp
        mov esi, 0
        mov ecx, 0
        pop esi
        pop ecx
        add score,10
		cmp lol, 15 ;if the player achieves a score of 15 they win. 
		je GameWin
    Loop forever 

	GameWin:
		pop esi
		pop ecx
		call Clrscr
		call drawWin
		call playWin
		jmp eop

    GameOver:
        pop esi
        pop ecx
		call Clrscr
		call drawGameOver
        call playGameOver

eop:
	ret
SiNum ENDP ;Basic_Game_Logic_Marker

checkMouseClick PROC USES eax ecx esi ebx

    appContinue:
    invoke GetNumberOfConsoleInputEvents, rHnd, OFFSET numEventsOccurred
    cmp numEventsOccurred, 0
    je appContinue
    invoke ReadConsoleInput, rHnd, OFFSET eventBuffer, numEventsOccurred,   OFFSET numEventsRead
    mov ecx, numEventsRead
    mov esi, OFFSET eventBuffer

    loopOverEvents:

      cmp (INPUT_RECORD PTR [esi]).EventType, MOUSE_EVENT
      jne notMouse

      test (INPUT_RECORD PTR [esi]).MouseEvent.dwButtonState, FROM_LEFT_1ST_BUTTON_PRESSED
      jz notMouse
      mouseClickedLeft:
      	mov arraypos, 0
      	movzx eax, (INPUT_RECORD PTR [esi]).MouseEvent.dwMousePosition.x
      	movzx ebx, (INPUT_RECORD PTR [esi]).MouseEvent.dwMousePosition.y
      	call calcArrayPos                               ; Calculates the cell that the mouse click was made on

        mov esi, OFFSET simonascii
        add esi, arraypos
        mov edx, [esi]                                  ;Puts the char at cell arraypos into edx
        cmp dl, ','                                             ;compares if the char was in the zone or an @
        je validZone
        jmp eol

        validZone:
        call checkWhichZone                             ;Prints which zone the click was made in

        jmp done

        notMouse:
      	add esi, TYPE INPUT_RECORD

        eol:                    ;end of loop
	;loop loopOverEvents

    jmp appContinue

    done:

ret
checkMouseClick endp

DrawSimon PROC USES esi ecx
.data
	GREEN = 2 + (2*16)
	LIGHT_GREEN = 10 + (10*16)
	YELLOW = 6 + (6*16)
	LIGHT_YELLOW = 14 + (14*16)
	RED = 4 + (4*16)
	LIGHT_RED = 12 + (12*16)
	BLUE = 1 + (1*16)
	LIGHT_BLUE = 3 + (3*16)

	xy COORD <>

	cursorInfo CONSOLE_SCREEN_BUFFER_INFO <>

.code
	mov esi, offset simonascii ;Prepairs do draw simon board from array
	movzx ecx, msg_size 
	mov edx, 0

	print_simon:
		mov al, byte ptr [esi]
		.IF (eax == 0Dh)
			mov edx, 0
		.ENDIF
		mov bl, ','
		cmp al, bl
		jne write_it

		; Here we set the colors for each quadrant
		push eax
		pushad
		INVOKE GetConsoleScreenBufferInfo, wHnd, ADDR cursorInfo
		.IF (cursorInfo.dwCursorPosition.x < 34)
			.IF (cursorInfo.dwCursorPosition.y < 18)
				mov eax, GREEN
			.ELSE
				mov eax, YELLOW
			.ENDIF
		.ELSE
			.IF (cursorInfo.dwCursorPosition.y < 18)
				mov eax, RED
			.ELSE
				mov eax, BLUE
			.ENDIF
		.ENDIF
		INVOKE SetTextColor
		popad

		pop eax

		write_it:
		call WriteChar
		mov eax, 15
		INVOKE SetTextColor
		inc esi
		inc edx
	loop print_simon

	ret
DrawSimon ENDP

FlashRegion PROC, REGION_NUM:BYTE
;
; Takes the quadrant in eax, and flashes the respective
; quadrant on and off, with a speed in miliseconds set in edx (default 1000ms)
; @PARAMS REGION_NUM the quadrant (1-4) (1=TL, 2=TR, 3=BL, 4=BR)
; @PARAMS SLEEP_TIME the speed in miliseconds of sleep between flash on/off.
;
.data
	;these are the (x, y) coordinates of each , character
	green_region REGION <<25,1>, 7>, <<20,2>, 12>, <<17,3>, 15>, <<14,4>, 18>, <<12,5>, 20>, <<10,6>, 22>, <<8,7>, 24>, <<7,8>, 25>, <<6,9>, 26>, <<5,10>, 27>, <<4,11>, 24>, <<3,12>, 22>, <<2,13>, 21>, <<2,14>, 19>, <<1,15>, 19>, <<1,16>, 18>
	red_region REGION <<36,1>,7>, <<36,2>,11>, <<36,3>,15>, <<36,4>,18>, <<36,5>,20>, <<36,6>,22>, <<36,7>,23>, <<36,8>,25>, <<36,9>,26>, <<36,10>,27>, <<39,11>,25>, <<42,12>,23>, <<44,13>,21>, <<46,14>,20>, <<47,15>,19>, <<48,16>,19>
	yellow_region REGION <<1,19>, 18>, <<1,20>, 19>, <<1,21>, 20>, <<1,22>, 21>, <<2,23>, 22>, <<3,24>, 25>, <<3,25>, 29>, <<4,26>, 28>, <<5,27>, 27>, <<6,28>, 26>, <<8,29>, 24>, <<9,30>, 23>, <<11,31>, 21>, <<13,32>, 19>, <<16,33>, 16>, <<19,34>, 13>, <<23,35>,9>
	blue_region REGION <<48,19>, 19>, <<47,20>, 20>, <<46,21>, 20>, <<45,22>, 21>, <<43,23>, 23>, <<40,24>, 25>, <<36,25>, 28>, <<36,26>, 27>, <<36,27>, 26>, <<36,28>, 25>, <<36,29>, 24>, <<36,30>, 22>, <<36,31>, 20>, <<36,32>, 18>, <<36,33>, 16>, <<36,34>, 13>, <<36,35>, 9>

	attrs_written DWORD ?

.code

	.IF REGION_NUM == 1
		INVOKE DoFlash, GREEN, LIGHT_GREEN, offset green_region, (lengthof green_region)
	.ELSEIF REGION_NUM == 2
		INVOKE DoFlash, RED, LIGHT_RED, offset red_region, (lengthof red_region)
	.ELSEIF REGION_NUM == 3
		INVOKE DoFlash, YELLOW, LIGHT_YELLOW, offset yellow_region, (lengthof yellow_region)
	.ELSEIF REGION_NUM == 4
		INVOKE DoFlash, BLUE, LIGHT_BLUE, offset blue_region, (lengthof blue_region)
	.ENDIF


	ret
FlashRegion ENDP

DoFlash PROC uses esi ecx eax ebx ecx edx edi, COLOR:WORD, LIGHT_COLOR:WORD, FLASH_REGION:PTR REGION, REGION_LENGTH:DWORD
;
; Flashes a specified REGION struct to a specified color. This is called with INVOKE
; @PARAMS COLOR the color the quadrant should be
; @PARAMS LIGHT_COLOR the color the quadrant should flash to
; @PARAMS FLASH_REGION a pointer to the beginning of the region definition
; @PARAMS REGION_LENGTH the length of the region (lengthof)
;
	mov esi, FLASH_REGION
	mov ecx, REGION_LENGTH
	push esi
	push ecx

	flashtolight:
		mov eax, (COORD PTR (REGION PTR [esi]).start)
		mov ebx, (REGION PTR [esi])._length
		pushad
		INVOKE FillConsoleOutputAttribute, wHnd, LIGHT_COLOR, ebx, eax, offset attrs_written
		popad
		add esi, TYPE REGION
	loop flashtolight
	INVOKE Sleep, 250
	pop ecx
	pop esi
	flashback:
		mov eax, (COORD PTR (REGION PTR [esi]).start)
		mov ebx, (REGION PTR [esi])._length
		pushad
		INVOKE FillConsoleOutputAttribute, wHnd, COLOR, ebx, eax, offset attrs_written
		popad
		add esi, TYPE REGION
	loop flashback
	INVOKE Sleep, 250
	ret
DoFlash ENDP

COMMENT @
Takes a COORD pointer in edx, and moves the console to that position
@
GoToPos PROC USES esi ecx
	INVOKE SetConsoleCursorPosition, wHnd, edx

	ret
GoToPos ENDP

COMMENT @
Uses the value in the EBX(Y Value) and the EAX register(X Value) to 
find the corresponding character that the mouseclick was placed on.

PARAMS Returns the value arraypos of the character that was clicked.
@
calcArrayPos proc USES ecx

	mov ecx, ebx
	Jimmy:

	add arraypos,70
	loop Jimmy

	add arraypos, eax

	ret
calcArrayPos endp

;Checks which the zone the mouse click was made in and then gets a value of 1 - 4 based on the zone or quadrant
checkWhichZone PROC

	;Compares X component to see if its greater or less then 33
	cmp eax, 33
	jle zone13 ;the zone was in the left half of the window
	jmp zone24 ;the zone was in the right half of the window

	zone13:
	cmp ebx, 18 ;checks y component to see if it is in the top or bottom quarter of the window
	jle zone1 
	jmp zone3

	zone24: 
	cmp ebx, 18 ;checks y component to see if it is in the top or bottom quarter of the window
	jle zone2
	jmp zone4

	zone1:
		mov edx, 1
		invoke FlashRegion, 1
		jmp eop
	zone2:
		mov edx, 2
		invoke FlashRegion, 2
		jmp eop
	zone3:
		mov edx, 3
		invoke FlashRegion, 3
		jmp eop
	zone4:
		mov edx, 4
		invoke FlashRegion, 4

eop:

ret
checkWhichZone endp

writeScore PROC uses EAX EDX ;displays and updates score
	mov edx, scorepos
	call GoToPos
	mov eax, score
	mov edx, OFFSET scoreText
	call WriteString
	call WriteDec

ret
writeScore endp

Display PROC USES eax ecx esi ;Iterats throught array of numbers and uses each one to flash as quadrant
	mov ecx, lol
	mov esi, OFFSET levels
	call writeScore
	showArray:
		mov al, [esi]
		INVOKE FlashRegion, al ;al is holding a value 1 - 4 that is used to specify the quadrant
		add esi, TYPE levels
    Loop showArray
ret
Display ENDP ;Basic_Game_Logic_Marker

writeSpace PROC uses EAX
	mov al, ' '
	call WriteChar
	ret
writeSpace endp

playLevelUp PROC
	INVOKE PlaySound,OFFSET LevelUp,NULL,SND_FILENAME
ret
playLevelUp endp

playWin PROC
	INVOKE PlaySound,OFFSET WinSound,NULL,SND_FILENAME
ret
playWin endp

playGameOver PROC
	INVOKE PlaySound, OFFSET GameOverSound, NULL, SND_FILENAME
ret
playGameOver endp

END main
IDEAL
MODEL small
	BMP_WIDTH = 320
	BMP_HEIGHT = 200
STACK 100h
DATASEG
	RndCurrentPos dw start
	
	IP dw ?
	
	BombType db ?
	
	IsFree db ?
	
	Opening db "Opening.bmp" ,0
	BackG db "BackG.bmp" ,0
	YouDied db "YouDied.bmp" ,0
	YouWon db "YouWon.bmp" ,0
	TieScreen db "Tie.bmp" ,0
	Rules1 db "Rules1.bmp" ,0
	Rules2 db "Rules2.bmp" ,0
	Rules3 db "Rules3.bmp" ,0
	Rules4 db "Rules4.bmp" ,0
    FileHandle dw ?
    Header db 54 dup(0)
    ErrorFile db 0
    BmpLeft dw ?
    BmpTop dw ?
    BmpColSize dw ?
    BmpRowSize dw ?
	Palette db 400h dup (0)
	ScrLine db 320 dup (0)  ; One Color line read buffer
	
	
	;Table Variables
	ColorSquare db ? ;square color
	SquareSize dw ? ;Square Size (Square sides Size)
	XposSquare dw ? ;Ypos of the square
	YposSquare dw ? ;Xpos of the square
	
	NumberRows dw ? ;The number of rows of the table
	NumberColumns dw ? ;The number of columns of the table
	
	
	;חיים של השחקן
	HeartsLeft dw ?
	XposHeartLeft dw ?
	YposHeartLeft dw ?
	
	HeartsRight dw ?
	XposHeartRight dw ?
	YposHeartRight dw ?
	
	LocationHeart dw ?
	DrawHeart db White,White,White,White,White,White,White,White,White,White,White,White,White,White,White
			  db White,White,White,Red,Red,Red,White,White,White,Red,Red,Red,White,White,White
			  db White,White,Red,Red,Red,Red,Red,White,Red,Red,White,Red,Red,White,White
			  db White,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,White,Red,Red,White
			  db White,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,White,Red,White
			  db White,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,White
			  db White,White,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,Red,White,White
			  db White,White,White,Red,Red,Red,Red,Red,Red,Red,Red,Red,White,White,White
			  db White,White,White,White,Red,Red,Red,Red,Red,Red,Red,White,White,White,White
			  db White,White,White,White,White,Red,Red,Red,Red,Red,White,White,White,White,White
			  db White,White,White,White,White,White,Red,Red,Red,White,White,White,White,White,White
			  db White,White,White,White,White,White,White,Red,White,White,White,White,White,White,White
			  db White,White,White,White,White,White,White,White,White,White,White,White,White,White,White
	
	LocationHeartDied dw ?
	DrawHeartDied db White,White,White,White,White,White,White,White,White,White,White,White,White,White,White
			  db White,White,White,Black,Black,Black,White,White,White,Black,Black,Black,White,White,White
			  db White,White,Black,Black,Black,Black,Black,White,Black,Black,White,Black,Black,White,White
			  db White,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,White,Black,Black,White
			  db White,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,White,Black,White
			  db White,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,White
			  db White,White,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,Black,White,White
			  db White,White,White,Black,Black,Black,Black,Black,Black,Black,Black,Black,White,White,White
			  db White,White,White,White,Black,Black,Black,Black,Black,Black,Black,White,White,White,White
			  db White,White,White,White,White,Black,Black,Black,Black,Black,White,White,White,White,White
			  db White,White,White,White,White,White,Black,Black,Black,White,White,White,White,White,White
			  db White,White,White,White,White,White,White,Black,White,White,White,White,White,White,White
			  db White,White,White,White,White,White,White,White,White,White,White,White,White,White,White
	
	LocationMatrix dw ?
	matrix dw ?
	DrawBlackBombs db White,White,White,Red,White,White,Brown,Brown,White,White,White,White,White
				   db White,White,Red,Orange,Red,Brown,White,White,Brown,White,White,White,White
				   db White,Red,Orange,Brown,Brown,White,White,Brown,White,White,White,White,White
				   db White,White,Red,Orange,Red,White,Black,Black,Black,White,White,White,White
				   db White,White,White,Red,White,White,Black,Black,Black,White,White,White,White
				   db White,White,White,White,White,Black,Black,Black,Black,Black,White,White,White
				   db White,White,White,White,Black,Black,Black,Black,Black,Black,Black,White,White
				   db White,White,White,Black,Black,Black,Black,Black,Black,White,Black,Black,White
				   db White,White,White,Black,White,Black,Black,Black,Black,White,White,Black,White
				   db White,White,White,Black,White,Black,Black,Black,Black,Black,White,Black,White
				   db White,White,White,Black,Black,White,Black,Black,Black,Black,Black,Black,White
				   db White,White,White,White,Black,Black,White,Black,Black,Black,Black,White,White
				   db White,White,White,White,White,Black,Black,Black,Black,Black,White,White,White
	
	; מטריצה למיקום שיש בו פצצה
	DrawBlackExplosion db Red,Red,Red,Yellow,Red,Orange,Red,Red,Red,Red,Red,Orange,Red
					   db Red,Red,Red,Red,Red,Red,Red,Yellow,Red,Red,Red,Red,Red
					   db Red,Red,Orange,Red,Orange,Red,Orange,Red,Orange,Red,Orange,Red,Red
					   db Red,Red,Red,Yellow,Orange,Orange,Yellow,Orange,Orange,Orange,Red,Orange,Red
					   db Yellow,Red,Orange,Orange,Red,Orange,Orange,Orange,Red,Orange,Orange,Red,Red
					   db Red,Red,Red,Orange,Orange,Yellow,Orange,Yellow,Orange,Orange,Red,Red,Red
					   db Red,Red,Orange,Yellow,Orange,Orange,Yellow,Orange,Orange,Yellow,Orange,Red,Red
					   db Orange,Red,Red,Orange,Orange,Yellow,Orange,Yellow,Orange,Orange,Red,Yellow,Red
					   db Red,Red,Orange,Orange,Orange,Orange,Yellow,Orange,Orange,Orange,Orange,Red,Red
					   db Red,Red,Red,Orange,Orange,Red,Orange,Orange,Red,Orange,Red,Red,Red
					   db Red,Red,Orange,Yellow,Orange,Orange,Orange,Orange,Orange,Orange,Orange,Red,Orange
					   db Red,Red,Red,Orange,Red,Orange,Red,Orange,Red,Orange,Red,Red,Red
					   db Red,Yellow,Red,Red,Red,Red,Red,Red,Red,Red,Red,Yellow,Red
	
	; מטריצה למיקום שיש בו פצצה
	DrawPurpleExplosion db Purple,Purple,Purple,White,Purple,LightPurple,Purple,Purple,Purple,Purple,Purple,LightPurple,Purple
                        db Purple,Purple,Purple,Purple,Purple,Purple,Purple,White,Purple,Purple,Purple,Purple,Purple
                        db Purple,Purple,LightPurple,Purple,LightPurple,Purple,LightPurple,Purple,LightPurple,Purple,LightPurple,Purple,Purple
                        db Purple,Purple,Purple,White,LightPurple,LightPurple,White,LightPurple,LightPurple,LightPurple,Purple,LightPurple,Purple
                        db White,Purple,LightPurple,LightPurple,Purple,LightPurple,LightPurple,LightPurple,Purple,LightPurple,LightPurple,Purple,Purple
                        db Purple,Purple,Purple,LightPurple,LightPurple,White,LightPurple,White,LightPurple,LightPurple,Purple,Purple,Purple
                        db Purple,Purple,LightPurple,White,LightPurple,LightPurple,White,LightPurple,LightPurple,White,LightPurple,Purple,Purple
                        db LightPurple,Purple,Purple,LightPurple,LightPurple,White,LightPurple,White,LightPurple,LightPurple,Purple,White,Purple
                        db Purple,Purple,LightPurple,LightPurple,LightPurple,LightPurple,White,LightPurple,LightPurple,LightPurple,LightPurple,Purple,Purple
                        db Purple,Purple,Purple,LightPurple,LightPurple,Purple,LightPurple,LightPurple,Purple,LightPurple,Purple,Purple,Purple
                        db Purple,Purple,LightPurple,White,LightPurple,LightPurple,LightPurple,LightPurple,LightPurple,LightPurple,LightPurple,Purple,LightPurple
                        db Purple,Purple,Purple,LightPurple,Purple,LightPurple,Purple,LightPurple,Purple,LightPurple,Purple,Purple,Purple
                        db Purple,White,Purple,Purple,Purple,Purple,Purple,Purple,Purple,Purple,Purple,White,Purple


	; מטריצה למיקום שיש בו פצצה
	DrawGreenExplosion db Green,Green,Green,White,Green,LightGreen,Green,Green,Green,Green,Green,LightGreen,Green
					   db Green,Green,Green,Green,Green,Green,Green,White,Green,Green,Green,Green,Green
					   db Green,Green,LightGreen,Green,LightGreen,Green,LightGreen,Green,LightGreen,Green,LightGreen,Green,Green
					   db Green,Green,Green,White,LightGreen,LightGreen,White,LightGreen,LightGreen,LightGreen,Green,LightGreen,Green
					   db White,Green,LightGreen,LightGreen,Green,LightGreen,LightGreen,LightGreen,Green,LightGreen,LightGreen,Green,Green
					   db Green,Green,Green,LightGreen,LightGreen,White,LightGreen,White,LightGreen,LightGreen,Green,Green,Green
					   db Green,Green,LightGreen,White,LightGreen,LightGreen,White,LightGreen,LightGreen,White,LightGreen,Green,Green
					   db LightGreen,Green,Green,LightGreen,LightGreen,White,LightGreen,White,LightGreen,LightGreen,Green,White,Green
					   db Green,Green,LightGreen,LightGreen,LightGreen,LightGreen,White,LightGreen,LightGreen,LightGreen,LightGreen,Green,Green
					   db Green,Green,Green,LightGreen,LightGreen,Green,LightGreen,LightGreen,Green,LightGreen,Green,Green,Green
					   db Green,Green,LightGreen,White,LightGreen,LightGreen,LightGreen,LightGreen,LightGreen,LightGreen,LightGreen,Green,LightGreen
					   db Green,Green,Green,LightGreen,Green,LightGreen,Green,LightGreen,Green,LightGreen,Green,Green,Green
					   db Green,White,Green,Green,Green,Green,Green,Green,Green,Green,Green,White,Green
	
	
	; מטריצה למיקום שאין בו פצצה		  
	DrawAvailability db Green,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green
				     db Green,Green,Brown,White,White,White,White,White,White,White,White,Green,Green
 	                 db Green,Green,Brown,White,White,White,White,White,White,White,White,Green,Green
 	                 db Green,Green,Brown,White,White,White,White,White,White,White,White,Green,Green
 	                 db Green,Green,Brown,White,White,White,White,White,White,White,White,Green,Green
 	                 db Green,Green,Brown,White,White,White,White,White,White,White,White,Green,Green
                     db Green,Green,Brown,White,White,White,White,White,White,White,White,Green,Green
			         db Green,Green,Brown,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green
 	                 db Green,Green,Brown,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green
 	                 db Green,Green,Brown,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green
 	                 db Green,Green,Brown,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green
 	                 db Green,Green,Brown,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green
                     db Green,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green,Green
	
	
	; מטריצה למיקום שאין בו פצצה
	DrawBlueExplosion db Blue,Blue,Blue,White,Blue,LightBlue,Blue,Blue,Blue,Blue,Blue,LightBlue,Blue
                      db Blue,Blue,Blue,Blue,Blue,Blue,Blue,White,Blue,Blue,Blue,Blue,Blue
                      db Blue,Blue,LightBlue,Blue,LightBlue,Blue,LightBlue,Blue,LightBlue,Blue,LightBlue,Blue,Blue
                      db Blue,Blue,Blue,White,LightBlue,LightBlue,White,LightBlue,LightBlue,LightBlue,Blue,LightBlue,Blue
                      db White,Blue,LightBlue,LightBlue,Blue,LightBlue,LightBlue,LightBlue,Blue,LightBlue,LightBlue,Blue,Blue
                      db Blue,Blue,Blue,LightBlue,LightBlue,White,LightBlue,White,LightBlue,LightBlue,Blue,Blue,Blue
                      db Blue,Blue,LightBlue,White,LightBlue,LightBlue,White,LightBlue,LightBlue,White,LightBlue,Blue,Blue
                      db LightBlue,Blue,Blue,LightBlue,LightBlue,White,LightBlue,White,LightBlue,LightBlue,Blue,White,Blue
                      db Blue,Blue,LightBlue,LightBlue,LightBlue,LightBlue,White,LightBlue,LightBlue,LightBlue,LightBlue,Blue,Blue
                      db Blue,Blue,Blue,LightBlue,LightBlue,Blue,LightBlue,LightBlue,Blue,LightBlue,Blue,Blue,Blue
                      db Blue,Blue,LightBlue,White,LightBlue,LightBlue,LightBlue,LightBlue,LightBlue,LightBlue,LightBlue,Blue,LightBlue
                      db Blue,Blue,Blue,LightBlue,Blue,LightBlue,Blue,LightBlue,Blue,LightBlue,Blue,Blue,Blue
                      db Blue,White,Blue,Blue,Blue,Blue,Blue,Blue,Blue,Blue,Blue,White,Blue
	
	
	; מטריצה למיקום שאין בו פצצה
	DrawGrayExplosion db Black,Black,Black,White,Black,Gray,Black,Black,Black,Black,Black,Gray,Black
					   db Black,Black,Black,Black,Black,Black,Black,White,Black,Black,Black,Black,Black
					   db Black,Black,Gray,Black,Gray,Black,Gray,Black,Gray,Black,Gray,Black,Black
					   db Black,Black,Black,White,Gray,Gray,White,Gray,Gray,Gray,Black,Gray,Black
					   db White,Black,Gray,Gray,Black,Gray,Gray,Gray,Black,Gray,Gray,Black,Black
					   db Black,Black,Black,Gray,Gray,White,Gray,White,Gray,Gray,Black,Black,Black
					   db Black,Black,Gray,White,Gray,Gray,White,Gray,Gray,White,Gray,Black,Black
					   db Gray,Black,Black,Gray,Gray,White,Gray,White,Gray,Gray,Black,White,Black
					   db Black,Black,Gray,Gray,Gray,Gray,White,Gray,Gray,Gray,Gray,Black,Black
					   db Black,Black,Black,Gray,Gray,Black,Gray,Gray,Black,Gray,Black,Black,Black
					   db Black,Black,Gray,White,Gray,Gray,Gray,Gray,Gray,Gray,Gray,Black,Gray
					   db Black,Black,Black,Gray,Black,Gray,Black,Gray,Black,Gray,Black,Black,Black
					   db Black,White,Black,Black,Black,Black,Black,Black,Black,Black,Black,White,Black
	
	
	Xpos db ?
	Ypos db ?
	
	LocationComputerBombs  db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
						   db 0,0,0,0,0,0,0,0,0
	
	
	LocationComputerGuess db 0,0,0,0,0,0,0,0,0
						  db 0,0,0,0,0,0,0,0,0
					      db 0,0,0,0,0,0,0,0,0
						  db 0,0,0,0,0,0,0,0,0
						  db 0,0,0,0,0,0,0,0,0
						  db 0,0,0,0,0,0,0,0,0
						  db 0,0,0,0,0,0,0,0,0
						  db 0,0,0,0,0,0,0,0,0
						  db 0,0,0,0,0,0,0,0,0

	
	LocationPlayerBombs db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
	
	
	LocationPlayerGuess db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
					    db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
						db 0,0,0,0,0,0,0,0,0
	
;=========================
CODESEG
	
	Black equ 0
	Gray equ 17
	White equ 246
	Red equ 14
	Orange equ 31
	Yellow equ 251
	Brown equ 10
	Green equ 32
	LightGreen equ 45
	Blue equ 128
	LightBlue equ 9
	Purple equ 139
	LightPurple equ 159
	
start:
	mov ax, @data
	mov ds, ax
	
	mov ax, 13h ;Entered GraphicsMode
	int 10h
;-------------------------
	
	Game:
	mov si, 0
	mov cx, 81
	Reset:
		mov [LocationPlayerBombs+si], 0
		mov [LocationComputerBombs+si], 0
		mov [LocationPlayerGuess+si], 0
		mov [LocationComputerGuess+si], 0
		inc si
	loop Reset
	
	
	mov [BmpLeft],0
    mov [BmpTop],0
    mov [BmpColSize], BMP_WIDTH
    mov [BmpRowSize] ,BMP_HEIGHT
    mov dx, offset Opening
    call OpenShowBmp
	
	
	NotPress:
	mov ah, 1
	int 16h
	jz NotPress
	mov ah, 0
	int 16h
	;בדיקה האם נלחץ 1
	cmp ah, 2h
	JE Level1
	;בדיקה האם נלחץ 2
	cmp ah, 3h
	JE Level2
	;בדיקה האם נלחץ 3
	cmp ah, 4h
	JE JumpLevel3
	;H בדיקה האם נלחץ
	cmp ah, 23h
	JE JumpInstructions
	;E בדיקה האם נלחץ
	cmp ah, 12h
	JE JumpExit
	jmp NotPress
	
	
	Level1:
		call PrintGame
		
		mov ax, 0 ;אתחול עכבר
		int 33h
		mov ax, 1 ;הצגת עכבר
		int 33h
		mov cx, 10
		PlayerBombs1:
		push cx
		call PlayerBombLottery
		pop cx
		loop PlayerBombs1
		
		
		mov [BombType], 1
		mov cx, 6
		ComputerBlackBombs1:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerBlackBombs1
		
		mov [BombType], 2
		mov cx, 5
		ComputerPurpleBombs1:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerPurpleBombs1
		
		
		Play1:
		call PlayerGuess
		mov ah, 0ch
		mov al, 0
		int 21h
		call _200MiliSecDelay
		call ComputerGuess
	cmp [HeartsRight], 0
	JE JumpYouDie
	cmp [HeartsLeft], 0
	JE JumpYouWin
	jmp Play1
	
	
	JumpLevel3:
	jmp Level3
	
	JumpInstructions:
	jmp Instructions
	
	JumpExit:
	jmp Exit
	
	
	Level2:
		call PrintGame
		
		mov ax, 0 ;אתחול עכבר
		int 33h
		mov ax, 1 ;הצגת עכבר
		int 33h
		mov cx, 10
		PlayerBombs2:
		push cx
		call PlayerBombLottery
		pop cx
		loop PlayerBombs2
		
		
		mov [BombType], 1
		mov cx, 6
		ComputerBlackBombs2:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerBlackBombs2
		
		mov [BombType], 2
		mov cx, 5
		ComputerPurpleBombs2:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerPurpleBombs2
		
		mov [BombType], 3
		mov cx, 2
		ComputerGreenBombs2:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerGreenBombs2
		
		
		Play2:
		call PlayerGuess
		mov ah, 0ch
		mov al, 0
		int 21h
		call _200MiliSecDelay
		call ComputerGuess
	cmp [HeartsRight], 0
	JE JumpYouDie
	cmp [HeartsLeft], 0
	JE YouWin
	jmp Play2
	
	
	JumpYouWin:
	jmp YouWin
	
	JumpYouDie:
	jmp YouDie
	
	
	Level3:
		call PrintGame
		
		mov ax, 0 ;אתחול עכבר
		int 33h
		mov ax, 1 ;הצגת עכבר
		int 33h
		mov cx, 10
		PlayerBombs3:
		push cx
		call PlayerBombLottery
		pop cx
		loop PlayerBombs3
		
		
		mov [BombType], 1
		mov cx, 6
		ComputerBlackBombs3:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerBlackBombs3
		
		mov [BombType], 2
		mov cx, 5
		ComputerPurpleBombs3:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerPurpleBombs3
		
		mov [BombType], 3
		mov cx, 2
		ComputerGreenBombs3:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerGreenBombs3
		
		mov [BombType], 4
		mov cx, 2
		ComputerBlueBombs3:
		push cx
		call ComputerBombLottery
		pop cx
		loop ComputerBlueBombs3
		
		
		Play3:
		call PlayerGuess
		mov ah, 0ch
		mov al, 0
		int 21h
		call _200MiliSecDelay
		call ComputerGuess
	cmp [HeartsRight], 0
	JE YouDie
	cmp [HeartsLeft], 0
	JE YouWin
	jmp Play3
	
	
	YouWin:
		call _200MiliSecDelay
		mov ax, 2
		int 33h
		cmp [HeartsRight], 0
		JE Tie
		mov [BmpLeft],0
		mov [BmpTop],0
		mov [BmpColSize], BMP_WIDTH
		mov [BmpRowSize] ,BMP_HEIGHT
		mov dx, offset YouWon
		call OpenShowBmp
		call Delay2Sec
	jmp Game
	
	YouDie:
		call _200MiliSecDelay
		mov ax, 2
		int 33h
		cmp [HeartsLeft], 0
		JE Tie
		mov [BmpLeft],0
		mov [BmpTop],0
		mov [BmpColSize], BMP_WIDTH
		mov [BmpRowSize] ,BMP_HEIGHT
		mov dx, offset YouDied
		call OpenShowBmp
		call Delay2Sec
	jmp Game
	
	Tie:
		call _200MiliSecDelay
		mov ax, 2
		int 33h
		mov [BmpLeft],0
		mov [BmpTop],0
		mov [BmpColSize], BMP_WIDTH
		mov [BmpRowSize] ,BMP_HEIGHT
		mov dx, offset TieScreen
		call OpenShowBmp
		call Delay2Sec
	jmp Game
	
	
	Instructions:
		mov [BmpLeft],0
		mov [BmpTop],0
		mov [BmpColSize], BMP_WIDTH
		mov [BmpRowSize] ,BMP_HEIGHT
		mov dx, offset Rules1
		call OpenShowBmp
		mov ah, 7 ;silent input
		int 21h
		mov [BmpLeft],0
		mov [BmpTop],0
		mov [BmpColSize], BMP_WIDTH
		mov [BmpRowSize] ,BMP_HEIGHT
		mov dx, offset Rules2
		call OpenShowBmp
		mov ah, 7 ;silent input
		int 21h
		mov [BmpLeft],0
		mov [BmpTop],0
		mov [BmpColSize], BMP_WIDTH
		mov [BmpRowSize] ,BMP_HEIGHT
		mov dx, offset Rules3
		call OpenShowBmp
		mov ah, 7 ;silent input
		int 21h
		mov [BmpLeft],0
		mov [BmpTop],0
		mov [BmpColSize], BMP_WIDTH
		mov [BmpRowSize] ,BMP_HEIGHT
		mov dx, offset Rules4
		call OpenShowBmp
		mov ah, 7 ;silent input
		int 21h
	jmp Game

;-------------------------
Exit:
	mov ax, 2
	int 33h
	
	mov cx, 0
	mov dx, 0
	mov al, 0
	mov si, 200
	mov di, 320
	call Rect
	call _200MiliSecDelay
	
	mov ah, 7 ;silent input
	int 21h
	
	mov ax,2 ;Entered TextMode
	int 10h
	
	mov ax, 4c00h
	int 21h
	
;=========================

; Description  : get RND between any bl and bh includs (max 0-255)
; Input        : 1. Bl = min (from 0), BH = Max (till 255)
; 			     2. RndCurrentPos a word variable, help to get good rnd number
; 				 	Declre it at DATASEG: RndCurrentPos dw ,0
;				 3. EndOfCsLbl: is label at the end of the program one line above END start		
; Output:        Al - rnd num from bl to bh (example 50-150)
; More Info:
; 	Bl must be less than Bh 
; 	in order to get good random value again and agin the Code segment size should be 
; 	at least the number of times the procedure called at the same second ... 
; 	for example - if you call to this proc 50 times at the same second - Make sure the cs size is 50 bytes or more 
; 	(if not, make it to be more) 
proc RandomByCs
    push es
	push si
	push di
	mov ax, 40h
	mov	es, ax
	sub bh,bl  ; we will make rnd number between 0 to the delta between bl and bh
			   ; Now bh holds only the delta
	cmp bh,0
	jz @@ExitP
	mov di, [word RndCurrentPos]
	call MakeMask ; will put in si the right mask according the delta (bh) (example for 28 will put 31)
RandLoop: ;  generate random number 
	mov ax, [es:06ch] ; read timer counter
	mov ah, [byte cs:di] ; read one byte from memory (from semi random byte at cs)
	xor al, ah ; xor memory and counter
	; Now inc di in order to get a different number next time
	inc di
	cmp di,(EndOfCsLbl - start - 1)
	jb @@Continue
	mov di, offset start
@@Continue:
	mov [word RndCurrentPos], di
	and ax, si ; filter result between 0 and si (the nask)
	cmp al,bh    ;do again if  above the delta
	ja RandLoop
	add al,bl  ; add the lower limit to the rnd num
@@ExitP:	
	pop di
	pop si
	pop es
	ret
endp RandomByCs


Proc MakeMask    
    push bx

	mov si,1
    
@@again:
	shr bh,1
	cmp bh,0
	jz @@EndProc
	
	shl si,1 ; add 1 to si at right
	inc si
	
	jmp @@again
	
@@EndProc:
    pop bx
	ret
endp  MakeMask

; --------------------------

proc OpenShowBmp near 
	call OpenBmpFile
	cmp [ErrorFile],1
	je @@ExitProc
	call ReadBmpHeader
	call ReadBmpPalette
	call CopyBmpPalette
	call  ShowBmp
	call CloseBmpFile
@@ExitProc:
	ret
endp OpenShowBmp


; input dx filename to open
proc OpenBmpFile	near						 
	mov ah, 3Dh
	xor al, al
	int 21h
	jc @@ErrorAtOpen
	mov [FileHandle], ax
	jmp @@ExitProc
@@ErrorAtOpen:
	mov [ErrorFile],1
@@ExitProc:	
	ret
endp OpenBmpFile


proc CloseBmpFile near
	mov ah,3Eh
	mov bx, [FileHandle]
	int 21h
	ret
endp CloseBmpFile


; Read 54 bytes the Header
proc ReadBmpHeader	near					
	push cx
	push dx
	mov ah,3fh
	mov bx, [FileHandle]
	mov cx,54
	mov dx,offset Header
	int 21h
	pop dx
	pop cx
	ret
endp ReadBmpHeader

proc ReadBmpPalette near ; Read BMP file color palette, 256 colors * 4 bytes (400h)
						 ; 4 bytes for each color BGR + null)			
	push cx
	push dx
	mov ah,3fh
	mov cx,400h
	mov dx,offset Palette
	int 21h
	pop dx
	pop cx
	ret
endp ReadBmpPalette


; Will move out to screen memory the colors
; video ports are 3C8h for number of first color
; and 3C9h for all rest
proc CopyBmpPalette		near
	push cx
	push dx
	mov si,offset Palette
	mov cx,256
	mov dx,3C8h
	mov al,0  ; black first							
	out dx,al ;3C8h
	inc dx	  ;3C9h
	CopyNextColor:
		mov al,[si+2] 		; Red				
		shr al,2 			; divide by 4 Max (cos max is 63 and we have here max 255 ) (loosing color resolution).				
		out dx,al 						
		mov al,[si+1] 		; Green.				
		shr al,2            
		out dx,al 							
		mov al,[si] 		; Blue.				
		shr al,2            
		out dx,al 							
		add si,4 			; Point to next color.  (4 bytes for each color BGR + null)					
	loop CopyNextColor
	pop dx
	pop cx
	ret
endp CopyBmpPalette


; BMP graphics are saved upside-down.
; Read the graphic line by line (BmpRowSize lines in VGA format),
; displaying the lines from bottom to top.
proc ShowBMP 
	push cx
	mov ax, 0A000h
	mov es, ax
	mov cx,[BmpRowSize]
	mov ax,[BmpColSize] ; row size must dived by 4 so if it less we must calculate the extra padding bytes
	xor dx,dx
	mov si,4
	div si
	cmp dx,0
	mov bp,0
	jz @@row_ok
	mov bp,4
	sub bp,dx
	@@row_ok:	
	mov dx,[BmpLeft]	
	@@NextLine:
		push cx
		push dx	
		mov di,cx  ; Current Row at the small bmp (each time -1)
		add di,[BmpTop] ; add the Y on entire screen
		; next 5 lines  di will be  = cx*320 + dx , point to the correct screen line
		mov cx,di
		shl cx,6
		shl di,8
		add di,cx
		add di,dx
		; small Read one line
		mov ah,3fh
		mov cx,[BmpColSize]  
		add cx,bp  ; extra  bytes to each row must be divided by 4
		mov dx,offset ScrLine
		int 21h
		; Copy one line into video memory
		cld ; Clear direction flag, for movsb
		mov cx,[BmpColSize]  
		mov si,offset ScrLine
		rep movsb ; Copy line to the screen
		pop dx
		pop cx
	loop @@NextLine
	pop cx
	ret
endp ShowBMP 

   
proc DrawPallete
    mov di, 256
    mov al, 0
    mov cx, 5
    mov dx, 3
    @@DrawColor:
		mov bh, 0
		mov ah, 0Ch
		int 10h
		inc al
		cmp cx, 21
		je @@ResetCX
		inc cx
		jmp @@Loop
    @@ResetCX:
		inc dx
		mov cx, 5
    @@Loop:
		dec di
		cmp di, 0
		ja @@DrawColor
    ret
endp DrawPallete

;-------------------------

proc putMatrixInScreen
	push es
	push ax
	push si
	mov ax, 0A000h
	mov es, ax
	cld
	push dx
	mov ax,cx
	mul dx
	mov bp,ax
	pop dx
	mov si,[matrix]
	NextRow:	
		push cx
		mov cx, dx
		rep movsb
		sub di,dx
		add di, 320
		pop cx
	loop NextRow
	endProc:
	pop si
	pop ax
	pop es
    ret
endp putMatrixInScreen

;הדפסת מטריצה במשבצות הטבלאות
Proc PrintCapacity
	
	pop [IP]
	mov ah, 0
	mov al, [Ypos]
	mov bl, 15 ;15 = אורך המטריצה
	mul bl
	add ax, 51 ;51 = הגובה ממנה מתחילת פינת הטבלה
	mov bx, 320
	mul bx
	mov [LocationMatrix], ax
	
	mov ah, 0
	mov al, [Xpos]
	mov bl, 15 ;15 = אורך המטריצה
	mul bl
	pop cx
	add ax, cx
	add [LocationMatrix], ax
	
	pop ax
	mov [matrix], ax
	mov di, [LocationMatrix] ;Location
	mov dx, 13 ;cols
	mov cx, 13 ;rows
	call putMatrixInScreen
	
	push [IP]
	ret
endp  PrintCapacity

;-------------------------

proc DrawHorizontalLine	near ;Draw Horizontal Line
	push si
	push cx
	DrawLine:
		cmp si,0
		jz ExitDrawLine	
		mov ah,0ch	
		int 10h
		inc cx
		dec si
		jmp DrawLine
	ExitDrawLine:
	pop cx
    pop si
	ret
endp DrawHorizontalLine

proc DrawVerticalLine	near ;Draw Vertical Line
	push si
	push dx
	DrawVertical:
		cmp si,0
		jz @@ExitDrawLine	
		mov ah,0ch	
		int 10h
		inc dx
		dec si
		jmp DrawVertical
	@@ExitDrawLine:
	pop dx
    pop si
	ret
endp DrawVerticalLine

proc DrawSquare ;Draw Square
	push si
	push ax
	push cx
	push dx
	mov al,[ColorSquare]
	mov si,[SquareSize]
 	mov cx,[XposSquare]
	mov dx,[YposSquare]
	call DrawHorizontalLine
	call DrawVerticalLine
	add dx ,si
	dec dx
	call DrawHorizontalLine
	sub dx ,si
	inc dx
	add cx,si
	dec cx
	call DrawVerticalLine
	pop dx
	pop cx
	pop ax
	pop si 
	ret
endp DrawSquare

;פעולה המדפיסה טבלה
proc DrawTable
	push si
	push ax
	push bx
	push cx
	push dx
	mov dx, [XposSquare]
	mov cx, [SquareSize]
	mov bx, [NumberRows]
	RowsTable:
		mov [XposSquare], dx
		mov ax, [NumberColumns]
		ColumnsTable:
			call DrawSquare
			add [XposSquare], cx
		dec	ax
		cmp	ax, 0
		jne	ColumnsTable
		add [YposSquare], cx
	dec	bx
	cmp	bx, 0
	jne	RowsTable
	pop dx
	pop cx
	pop bx
	pop ax
	pop si 
	ret
endp DrawTable

; cx = col dx= row al = color si = height di = width 
proc Rect
	push cx
	push di
NextVerticalLine:	
	cmp di,0
	jz @@EndRect
	cmp si,0
	jz @@EndRect
	call DrawVerticalLine
	inc cx
	dec di
	jmp NextVerticalLine
@@EndRect:
	pop di
	pop cx
	ret
endp Rect

;-------------------------

; - - - - - - - - - - - - - - -

;פעולה הקובעת את מיקום פצצות המחשב על פי תנאי סודקו
Proc ComputerBombLottery
	
	@@Lottery: ;הגרלה של הנקודה הראשונה
		mov bl, 0
		mov bh, 80
		call RandomByCs
		mov bl, al
		mov bh, 0
	cmp [LocationComputerBombs + bx], 0 ;בדיקה של האם הנקודה פנויה
	JNE @@Lottery ;אם היא לא פנויה תתבצע קפיצה להתחלה להגרלה חוזרת
	
	cmp [BombType], 1
	JE @@BlackBomb
	cmp [BombType], 2
	JE @@PurpleBomb
	cmp [BombType], 3
	JE @@GreenBomb
	cmp [BombType], 4
	JE @@BlueBomb
	cmp [BombType], 5
	JE @@GrayBomb
	
	@@BlackBomb:
		mov [IsFree], 0
		call LineFree ;בדיקה האם השורה פנויה
		cmp [IsFree], 0
		JNE @@Lottery		
	jmp @@PlaceBomb
	
	@@GrayBomb:
	jmp @@PlaceBomb
	
	@@PurpleBomb:
		mov [IsFree], 0
		call ColumnFree ;בדיקה האם הטור פנוי
		cmp [IsFree], 0
		JNE @@Lottery
	jmp @@PlaceBomb
	
	@@GreenBomb:
		mov [IsFree], 0
		call RightDiagonalFree ;בדיקה האם האלכסון הימני פנוי
		cmp [IsFree], 0
		JNE @@Lottery
	jmp @@PlaceBomb
	
	@@BlueBomb:
		mov [IsFree], 0
		call LeftDiagonalFree ;בדיקה האם האלכסון השמאלי פנוי
		cmp [IsFree], 0
		JNE @@Lottery
	jmp @@PlaceBomb
	
	@@PlaceBomb:
	mov al, [BombType]
	mov [LocationComputerBombs + bx], al ;מיקום ניחוש המחשב במערך
	
	ret
endp  ComputerBombLottery


;פעולת עזר הבודקת האם השורה פנויה מאותו הסוג של הפצצה
Proc LineFree
	push ax
	push bx
	push cx
	push dx
	
;חילוק המיקום שהוגרל ב-9
	mov ah, 0
	mov dl, 9
	div dl
;הכפלת מספר השורה ב-9: לשם בדיקת תחילת השורה 
	mov ah, 0
	mul dl
	mov bx, ax
;ללואה לבדיקה כאורך השורה
	mov cx, 9
	@@check:
		mov al, [BombType]
		cmp [LocationComputerBombs + bx], al ;בדיקה של האם הנקודה פנויה
		JNE @@NotEqual
		mov [IsFree], 1
		@@NotEqual:
		inc bx
	loop @@check
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp  LineFree

;פעולת עזר הבודקת העם הטור שבו הוגרל מיקום הפצצה פנוי מהפצצות מאותו הסוג
Proc ColumnFree
	push ax
	push bx
	push cx
	push dx
	
;חילוק המיקום שהוגרל ב-9
	mov ah, 0
	mov dl, 9
	div dl
;חישוב תחילת הטור	
	mov al, ah
	mov ah, 0
	mov bx, ax
	mov cx, 9
	@@check:
		mov al, [BombType]
		cmp [LocationComputerBombs + bx], al ;בדיקה של האם הנקודה פנויה
		JNE @@NotEqual
		mov [IsFree], 1
		@@NotEqual:
		add bx, 9
	loop @@check
	
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp  ColumnFree

;פעולת עזר הבודקת האם האלכסון הימני פנוי מאותו סוג פצצות 
Proc RightDiagonalFree
	push ax
	push bx
	push cx
	push dx
	
;חילוק המיקום שהוגרל ב-9
	mov ah, 0
	mov dl, 9
	div dl
;מספר השורה - al
;מספר הטור - ah
	cmp ah, al
	JB @@check
	sub ah, al
	mov bl, ah
	mov bh, 0
	mov al, ah
	mov ah,0
	jmp @@checkRightDiagonal
	
	@@check:
	sub al, ah
	mov bl, 9
	mul bl
	mov ah, 0
	mov bl, al
	mov bh, 0
	
	@@checkRightDiagonal:
		mov al, [BombType]
		cmp [LocationComputerBombs + bx], al ;בדיקה של האם הנקודה פנויה
		JNE @@NotEqual
		mov [IsFree], 1
		@@NotEqual:
		add bx, 10
		mov ax, bx
	mov dl, 9
	div dl
	cmp al, 9
	JE @@Exit
	cmp ah, 9
	JE @@Exit
	jmp @@checkRightDiagonal
	
	@@Exit:
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp  RightDiagonalFree

;פעולת עזר הבודקת האם האלכסון השמאלי פנוי מאותו סוג של פצצות
Proc LeftDiagonalFree
	push ax
	push bx
	push cx
	
;חילוק המיקום שהוגרל ב-9
	mov ah, 0
	mov dl, 9
	div dl
;מספר השורה - al
;מספר הטור - ah
	mov dl, 8
	sub dl, ah
	cmp dl, al
	JB @@check
	
	add ah, al
	mov bl, ah
	mov bh, 0
	mov al, ah
	mov ah,0
	jmp @@checkRightDiagonal
	
	@@check:
	sub al, dl
	mov bl, 9
	mul bl
	mov ah, 0
	mov bl, al
	mov bh, 0
	
	@@checkRightDiagonal:
		mov al, [BombType]
		cmp [LocationComputerBombs + bx], al ;בדיקה של האם הנקודה פנויה
		JNE @@NotEqual
		mov [IsFree], 1
		@@NotEqual:
		add bx, 8
		mov ax, bx
	mov dl, 9
	div dl
	cmp al, 8
	JE @@Exit
	cmp ah, 0
	JE @@Exit
	jmp @@checkRightDiagonal
	
	@@Exit:
	pop cx
	pop bx
	pop ax
	ret
endp  LeftDiagonalFree

; - - - - - - - - - - - - - - -

;פעולה הקובעת ניחושים של המחשב למיקומים בטבלת השחקן
Proc ComputerGuess
    @@Lottery: ;הגרלה של הנקודה הראשונה
		mov bl, 0
		mov bh, 80
		call RandomByCs
		mov bl, al
		mov bh, 0
		dec bx
	cmp [LocationComputerGuess + bx], 0 ;בדיקה של האם הנקודה פנויה
	JNE @@Lottery ;אם היא לא פנויה תתבצע קפיצה להתחלה להגרלה חוזרת
	mov [LocationComputerGuess + bx], 1 ;מיקום ניחוש המחשב במערך
	
	push bx
	;XposComputerGuess-ו YposComputerGuess-חישוב ה
	mov ah, 0
	;al = הגרלת המיקום
	mov bl, 9
	div bl
	mov [Ypos], al
	mov [Xpos], ah
	pop bx
	
	cmp [LocationPlayerBombs + bx], 0
	JE @@Equal ;אם כן - ימשיך בבדיקה
	; אם לא - יצר פיצוץ ויסמן
	mov ax, 2 ;הסתרת עכבר
	int 33h
	push offset DrawBlackExplosion
	push 171
	call PrintCapacity
	push [HeartsLeft]
	push [XposHeartLeft]
	push [YposHeartLeft]
	call DecreaseHeart
	dec [HeartsLeft]
	mov ax, 1 ;הצגת עכבר
	int 33h
	jmp @@EndProc
	
	@@Equal:
	mov ax, 2 ;הסתרת עכבר
	int 33h
	push offset DrawAvailability
	push 171
	call PrintCapacity
	mov ax, 1 ;הצגת עכבר
	int 33h
	
	@@EndProc:
	ret
endp  ComputerGuess

;-------------------------

;פעולה הקובעת את מיקום פצצות השחקן
Proc PlayerBombLottery
	
	@@MouseInput:
		mov ax, 3h
		int 33h ;קלט מיקום עכבר
		
		cmp bx, 1 ;בדיקת המקש שנלחץ (האם נלחץ המקש השמאלי?)
		JNE @@MouseInput

		shr cx, 1
		cmp cx, 171 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JB @@MouseInput
		cmp dx, 51 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JB @@MouseInput
		cmp cx, 304 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JA @@MouseInput
		cmp dx, 184 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JA @@MouseInput
		
		sub cx, 170
		mov ax, cx
		mov bl, 15
		div bl
		mov [Xpos], al
		
		sub dx, 50
		mov ax, dx
		mov bl, 15
		div bl
		mov [Ypos], al 
	
	mov	ah, 0
	mov al, [Ypos]
	mov bl, 9
	mul bl
	add al, [Xpos]
	mov bh, 0
	mov bl, al
	dec bx
	cmp [LocationPlayerBombs + bx], 0
	JNE @@MouseInput ;אם היא לא פנויה תתבצע קפיצה להתחלה להגרלה חוזרת
	mov [LocationPlayerBombs + bx], 1
	
	mov ax, 2
	int 33h
	push offset DrawBlackBombs
	push 171
	call PrintCapacity
	mov ax, 1
	int 33h
	
	ret
endp  PlayerBombLottery


;פעולה הקובעת את מיקום הניחושים של השחקן בטבלת המחשב
Proc PlayerGuess 
	
	@@MouseInput:
		mov ax, 3h
		int 33h ;קלט מיקום עכבר
		
		cmp bx, 1 ;בדיקת המקש שנלחץ (האם נלחץ המקש השמאלי?)
		JNE @@MouseInput

		shr cx, 1
		cmp cx, 16 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JB @@MouseInput
		cmp dx, 51 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JB @@MouseInput
		cmp cx, 149 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JA @@MouseInput
		cmp dx, 184 ;בדיקה האם הלחיצה בכלל בטווח הטבלה
		JA @@MouseInput
		
		sub cx, 15
		mov ax, cx
		mov bl, 15
		div bl
		mov [Xpos], al
		
		sub dx, 50
		mov ax, dx
		mov bl, 15
		div bl
		mov [Ypos], al 
	
	mov	ah, 0
	mov al, [Ypos]
	mov bl, 9
	mul bl
	add al, [Xpos]
	
	mov bh, 0
	mov bl, al
	cmp [LocationPlayerGuess + bx], 0
	JNE @@MouseInput ;אם היא לא פנויה תתבצע קפיצה להתחלה להגרלה חוזרת
	mov [LocationPlayerGuess + bx], 1
	
	cmp [LocationComputerBombs + bx], 0
	JE @@JumpEmpty ;אם כן - ימשיך בבדיקה
	; אם לא - יבדוק איזו סוג פצצה זאת
	cmp [LocationComputerBombs + bx], 1
	JE @@BlackBomb
	cmp [LocationComputerBombs + bx], 2
	JE @@JumpPurpleBomb
	cmp [LocationComputerBombs + bx], 3
	JE @@JumpGreenBomb
	cmp [LocationComputerBombs + bx], 4
	JE @@JumpBlueBomb
	cmp [LocationComputerBombs + bx], 5
	JE @@GrayBomb
	
	@@BlackBomb:
		mov ax, 2
		int 33h
		push offset DrawBlackExplosion
		push 16
		call PrintCapacity
		push [HeartsRight]
		push [XposHeartRight]
		push [YposHeartRight]
		call DecreaseHeart
		dec [HeartsRight]
		mov ax, 1
		int 33h
	jmp @@EndProc
	
	@@JumpGreenBomb:
	jmp @@GreenBomb
	
	@@JumpBlueBomb:
	jmp @@BlueBomb
	
	@@JumpPurpleBomb:
	jmp @@PurpleBomb
	
	@@JumpEmpty:
	jmp @@Empty
	
	@@GrayBomb:
		mov ax, 2
		int 33h
		push offset DrawGrayExplosion
		push 16
		call PrintCapacity
		push [HeartsRight]
		push [XposHeartRight]
		push [YposHeartRight]
		call DecreaseHeart
		dec [HeartsRight]
		mov ax, 1
		int 33h
	jmp @@EndProc
	
	@@PurpleBomb:
		mov ax, 2
		int 33h
		push offset DrawPurpleExplosion
		push 16
		call PrintCapacity
		push [HeartsRight]
		push [XposHeartRight]
		push [YposHeartRight]
		call DecreaseHeart
		dec [HeartsRight]
		cmp [HeartsRight], 0
		JE @@Exit
			push [HeartsRight]
			push [XposHeartRight]
			push [YposHeartRight]
			call DecreaseHeart
			dec [HeartsRight]
		@@Exit:
		mov ax, 1
		int 33h
	jmp @@EndProc
	
	@@GreenBomb:
		mov ax, 2
		int 33h
	;להכין מטריצות מתאימות
		push offset DrawGreenExplosion
		push 16
		call PrintCapacity
		mov [BombType], 5
		call ComputerBombLottery
		mov ax, 1
		int 33h
	jmp @@EndProc
	
	@@BlueBomb:
		mov ax, 2
		int 33h
		push offset DrawBlueExplosion
		push 16
		call PrintCapacity
	;הכנסת מיקום וכמות הלבבות של המחשב
		mov [XposHeartLeft], 15
		mov [YposHeartLeft], 35
		mov [HeartsLeft], 5
	;הדפסת לבבות המחשב
		push [HeartsLeft]
		push [XposHeartLeft]
		push [YposHeartLeft]
		call PrintHeart
		mov ax, 1
		int 33h
	jmp @@EndProc
	
	@@Empty:
	mov ax, 2
	int 33h
	push offset DrawAvailability
	push 16
	call PrintCapacity
	mov ax, 1
	int 33h
	
	@@EndProc:
	ret
endp  PlayerGuess

;-------------------------

;מצייר לבבות את לבבות השחקן/לבבות המחשב
Proc PrintHeart
	
	pop [IP]
	pop ax ;YposHeartLeft/YposHeartRight
	mov bx, 320
	mul bx
	pop bx ;XposHeartLeft/XposHeartRight
	add ax, bx
	mov [LocationHeart], ax
	
	pop cx ;HeartsLeft/HeartsRight
	@@Print:
		push cx
		mov ax, offset DrawHeart
		mov [matrix], ax
		mov di, [LocationHeart] ;Location
		mov dx, 15 ;cols
		mov cx, 13 ;rows
		call putMatrixInScreen
		add [LocationHeart], 15
		pop cx
	loop @@Print
	
	push [IP]
	ret
endp  PrintHeart

;מצייר החסרת לב מהחיים של השחקן/של המחשב
Proc DecreaseHeart
	
	pop [IP]
	pop ax ;YposHeartLeft/YposHeartRight
	mov bx, 320
	mul bx
	pop bx ;XposHeartLeft/XposHeartRight
	add ax, bx
	mov [LocationHeartDied], ax
	
	pop ax ;HeartsLeft/HeartsRight
	dec ax
	mov bx, 15
	mul bx
	add [LocationHeartDied], ax
	mov ax, offset DrawHeartDied
	mov [matrix], ax
	mov di, [LocationHeartDied] ;Location
	mov dx, 15 ;cols
	mov cx, 13 ;rows
	call putMatrixInScreen
	
	push [IP]
	ret
endp  DecreaseHeart

;-------------------------

;מצייר את בסיס המשחק
;הרקע, טבלת המחשב וטבלת השחקן, חייו של המחשב וחייו של השחקן
proc PrintGame
	;הדפסת רקע המשחק
	mov [BmpLeft],0
    mov [BmpTop],0
    mov [BmpColSize], BMP_WIDTH
    mov [BmpRowSize] ,BMP_HEIGHT
    mov dx, offset BackG
    call OpenShowBmp
	
	;הדפסת טבלת המחשב - עליה הוא ממקם את הפצצות
	mov [ColorSquare], 246
	mov [SquareSize], 15
	mov [XposSquare], 15
	mov [YposSquare], 50
	mov [NumberRows], 9
	mov [NumberColumns], 9
	call DrawTable
	
	;הדפסת טבלת המחשב - עליה הוא ממקם את הפצצות
	mov [ColorSquare], 246
	mov [SquareSize], 15
	mov [XposSquare], 170
	mov [YposSquare], 50
	mov [NumberRows], 9
	mov [NumberColumns], 9
	call DrawTable
	
	;הכנסת מיקום וכמות הלבבות של המחשב
	mov [XposHeartLeft], 15
	mov [YposHeartLeft], 35
	mov [HeartsLeft], 5
	;הדפסת לבבות המחשב
	push [HeartsLeft]
	push [XposHeartLeft]
	push [YposHeartLeft]
	call PrintHeart
	
	;הכנסת מיקום וכמות הלבבות של השחקן
	mov [XposHeartRight], 230
	mov [YposHeartRight], 35
	mov [HeartsRight], 5
	;הדפסת לבבות השחקן
	push [HeartsRight]
	push [XposHeartRight]
	push [YposHeartRight]
	call PrintHeart
	
	ret
endp PrintGame

;-------------------------

;השהייה של 200 מילישניות
proc _200MiliSecDelay
	push cx
	mov cx ,1000 
@@Self1:
	push cx
	mov cx,600 
@@Self2:	
	loop @@Self2
	pop cx
	loop @@Self1
	pop cx
	ret
endp _200MiliSecDelay


;השהייה של שנייה
proc Delay1Sec
	push cx
	mov cx ,1000 
@@Self1:
	push cx
	mov cx,3000 
@@Self2:	
	loop @@Self2
	pop cx
	loop @@Self1
	pop cx
	ret
endp Delay1Sec


;השהייה של 2 שניות
proc Delay2Sec
	call Delay1Sec
	call Delay1Sec
	ret
endp Delay2Sec

;=========================
EndOfCsLbl:
END start
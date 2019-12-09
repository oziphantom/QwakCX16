

;@name macro Call Function Table
;@param table
;@param index
;@desc does a stack return, BDD safe
;@parent MISC		
; yes 65c02 has the wonderful jmp (place,x)		
; however my code uses y a lot and wants to preserve x		
; which makes this a lot harder to just change, I would 		
; need to change how my code works in order to allow for 		
; this optimisation to be used.		
mCallFunctionTable .macro
	lda \1.hi,\2
	pha
	lda \1.lo,\2
	pha
	rts  
.endm
;@end
;@name macro Make Function Table
;@param addresses
;@desc makes a lo hi table for use with mCallFunctionTable
;@parent MISC
mMakeFunctionTable .macro	
lo .byte <(\@)-1	
hi .byte >(\@)-1	
.endm	
;@end
;@name macro Make Table
;@param addresses
;@desc makes a lo hi table, of the address, not -1 
;@parent MISC
mMakeTable .macro
lo .byte <(\@)
hi .byte >(\@)
.endm		
;@end
;@name HiLo Word
;@desc makes union with a word and a lo, hi struct
;@parent MISC
HLWord .union
 .word ?
 .struct
 	lo .byte ?
 	hi .byte ?
 .ends
.endu
;@end

;----------------------------
; FONT encoding
;----------------------------
; {{{
.enc "qwak" ;define an ascii->petscii encoding
.cdef "@@", 128
.cdef "AZ", 129
.cdef "[[", 155
.cdef "££", 156
.cdef "]]", 157
.cdef "^^", 158
.cdef "||", 159;->
.cdef "  ", 160
.cdef "!!", 161
.cdef "``", 162;"
.cdef "##", 163
.cdef "~~", 164 ;heart
.cdef "%%", 165
.cdef "&&", 166
.cdef "''", 167
.cdef "((", 168
.cdef "))", 169
.cdef "**", 170
.cdef "++", 171
.cdef ",,", 172
.cdef "--", 173
.cdef "..", 174
.cdef "//", 175
.cdef "09", 176
.cdef "::", 186
.cdef ";;", 187
.cdef "<<", 188
.cdef "==", 189
.cdef ">>", 190
.cdef "??", 191
; }}}
;----------------------------
; Constants Region
;----------------------------
kTileXCount = 16
kTileYCount = 12
kLevelSizeMax = kTileXCount*kTileYCount
kSprBase = 128
kBulletSpriteOffset = 1
kEntsSpriteOffset = 2
kBulletCollisionbox = 1
kSprites .block
	fish = kSprBase+80
	spiderLeft = kSprBase+72
	spiderRight = kSprBase+74
	springNormal = kSprBase+40
	springCompress = kSprBase+41
	springExpand = kSprBase+42
	springFull = kSprBase+43
	springFall = kSprBase+44
	bubbles = kSprBase+124
	bulletSprite = kSprBase+120
	Q = kSprBase+116
	W = kSprBase+117
	A = kSprBase+118
	K = kSprBase+119
	splat = kSprBase+123
.bend
kSpiderValues .block
	yFallDelta = 2
	rightStartWiggle = 255-32-14 ; 32 pixels but compenstating for the sprite width
	rightStartFall = 255-16-14 ; 16 pixels
	leftStartWiggle = 32+14
	leftStartFall = 16+14
	pauseEndFallFrames = 32
	riseDelayTime = 3
.bend
kBounds .block
	screenMinX = 0
	;screenMinY = 0
	;screenMaxX = ( kTileXCount * 16 )
	screenMaxY = ( kTileYCount * 16 )
.bend
kTimers .block
	dissBlocksValue = $8
;	jumpUpValue = $38 ; 3.5 tile
;	jumpUpSpringValue = $48 ; 4.5 tiles
	floatTimer = $50 
	DoorAnimeRate = 10
	spawnBubble = 30
.bend
kEntity .block
	heli = $00
	spring = $01
	worm = $02
	bat = $03
	ghost = $04
	spider = $05
	fish = $06
	circler = $07
	bear = $08
	octopuss = $09
	bearBody = $0A	
	octopussBody = $0B
	bubble = $0C
	bossDummy = $0D
	maxEntities = 25
	maxBubbleMakers = 8
	maxNumBubblesPerMaker = 2
.bend
kBoss .block
	hitPoints = 7
	hitPointsOctopuss = 9
	deathAnimTime = 25
	normal = 0
	dead = 1
.bend
kFishLimits .block
	startTwo = 250-21-(8*6) ; 165
	maxY = 255-8-50
.bend
kPlayerParams .block
	jumpStartDelta = 255-1
	jumpDeltaAccum = 19
	jumpDeltaAccumFloat = 4
	maxFallSpeed = 4
.bend
kJumpIndexs .block
	normal = 0
	floaty = 1
.bend
kPlayerAnimsIndex .block
	standRight = 0
	standLeft = 1
	standWalkRight = 2
	standWalkLeft = 3
	jumpRight = 4
	jumpLeft = 5
	flapRight = 6
	flapLeft = 7
	dead = 8
	exit = 9 
.bend		
kSBC .block ; kStatusBorderChars
	M	= 205
	TL	= 203+3
	T	= 204+3
	TR	= 206+3
	L	= 205+3
	R	= 207+3
	BL	= 250
	B	= 251
	BR	= 252
	QWAKT = 208+3
	QWAKB = 214+3
	Score = 220+3
	High = 226+3
	QwakP = 232
	X = 204
	Flower = 236
.bend
mplex .block 
	kMaxSpr = $1f
.bend
kPlayerState .block
	appear = 0
	normal = 1
	flap = 2
	jump = 3
	exit = 4
	dead = 5
.bend
kPlayerStateExit .block
	waitForAnimation = 0
.bend
kPlayerStateDeath .block
	animate = 0
.bend
kIntermission .block
	firstExit = kTileXCount*5
	secondExit = (kTileXCount*6)-1
.bend
kHideScreen .block
	hide = %11101111
	show = %11111111
.bend
VIC .block
	Colours .block
			black = 0
			white = 1
			red = 2
			cyan = 3
			purple = 4
			green = 5
			blue = 6
			yellow = 7
			orange = 8
			brown = 9
			pink = 10
			dark_grey = 11
			med_grey = 12
			light_green = 13
			light_blue = 14
			light_grey = 15
	.bend
.bend
kVERA .block
	ADDR_Lo = $9f20
	ADDR_Mid = $9f21
	ADDR_Hi = $9f22
	DATA_0 = $9f23
	DATA_1 = $9f24
	CTRL = $9f25
	IEN = $9f26
	ISR = $9f27
	inc_1 = $100000
	inc_2 = $200000
	inc_4 = $300000
	inc_8 = $400000
	DisplayComposer .block
		video = $f0000
		hScale = $f0001
		vScale = $f0002
		borderColour = $f0003
		hStart = $f0004
		hStop = $f0005
		vStart = $f0006
		vStop = $f0007
		vStartStop = $f0008
		IRQLineL = $f0009
		IRQLineH = $f000a
	.bend
	Layer0 .block
		ctrl0 = $f2000
		ctrl1 = $f2001
	.bend
	Layer1 .block
		ctrl0 = $f3000
		ctrl1 = $f3001
	.bend
	SpriteRegisters = $f4000
	SpriteAttributes = $f5000
.bend
getVeraSpriteAddress32x32 .function number
.endf (number*512)>>5
getTitleScreenCharPos .function xpos,ypos
.endf kVRAM.titleScreen+(ypos*128)+(xpos*2)
getGameScreenCharPos .function xpos,ypos
.endf kVRAM.gameScreen+(ypos*128)+(xpos*2)

VeraDESTAddressLUT := [] 
VeraDESTAddressLUTLookup := {}

appendVeraAddress .segment addr 
.if int(\addr) in VeraDESTAddressLUTLookup
	ldx #VeraDESTAddressLUTLookup[int(\addr)]
.else
	ldx #len(VeraDESTAddressLUT)
	VeraDESTAddressLUTLookup := {*VeraDESTAddressLUTLookup, int(\addr):len(VeraDESTAddressLUT)}
	VeraDESTAddressLUT ..=[\addr]	
.endif 
jsr setVERAAddressPort0_X 
 
.endm 

GETJOY = $ff06
JOY1 = $02BC

.include "qwak_structs.asm"

;----------------------------
; ZP Regeion
;----------------------------
*= $00 
.dsection ZP
.section ZP
ZP_START
EntityDataPointer	.word ?
CurrentEntity		.byte ?
CollidedEntity		.byte ?
EntNum				.byte ?
CollisionResult	.byte ?
Pointer1				.dunion HLWord
Pointer2				.dunion HLWord
Pointer3				.dunion HLWord
Pointer4				.dunion HLWord
playerTempCol		.byte ?
ZPTemp				.byte ?
ZPTemp2				.byte ?
ZPTemp3				.byte ?
ZPTemp4				.byte ?
ZPTemp5				.byte ?
TempX					.byte ?
ActiveTileIndex	.byte ?
ActiveTile			.byte ?
TestingSprX1		.byte ?
TestingSprX2		.byte ?
TestingSprY1		.byte ?
TestingSprY2		.byte ?
GameStatePointer	.word ?

CollideSpriteToCheck 	.byte ?
CollideSpriteBoxIndex 	.byte ?
CollideCharTLI .byte ?
CollideCharTLC .byte ?
CollideCharTRI .byte ?
CollideCharTRC .byte ?
CollideCharBLI .byte ?
CollideCharBLC .byte ?
CollideCharBRI .byte ?
CollideCharBRC .byte ?
CollideInternalSprTLX 	.byte ?  ; these 4 MUST be in the same order as below
CollideInternalSprBRX 	.byte ?
CollideInternalSprTLY 	.byte ?
CollideInternalSprBRY 	.byte ?
CollideInternalTTLX 		.byte ?
CollideInternalTBRX 		.byte ?
CollideInternalTTLY 		.byte ?
CollideInternalTBRY 		.byte ?
DidClipX						.byte ?  ; this is if the add X with MSB function did clip the Y
HideScreen					.byte ?
ZP_END 
.send ZP
.cerror * > $7F, "Too many ZP variables"



;----------------------------
; Variables
;----------------------------

* = $A000
.dsection VARIABLES
.section VARIABLES
variables = *
joyLeft	 		.byte ?
joyRight 		.byte ?
joyUp	 			.byte ?
joyDown	 		.byte ?
joyFire	 		.byte ?
oldJoyLeft		.byte ?
oldJoyRight 	.byte ?
oldJoyUp			.byte ?
oldJoyDown		.byte ?
oldJoyFire		.byte ?
joyUpStart  	.byte ?
joyUpStop		.byte ?
joyFireEvent 	.byte ?
GameData 		.dstruct sGameData
LevelData 		.dstruct sLevelData
PlayerData 		.dstruct sPlayerData
TICK_DOWN_START = *
TickDowns 		.dstruct sTimerTickDowns
TICK_DOWN_END = *
EntityData 		.dstruct sEntityData
PasswordTemp .block 
	lives .byte ?
	flowers .byte ?
	score .byte ?,?,?,?,?,?
	high .byte ?,?,?,?,?,?
	currLevel .byte ?
.bend ;PasswordTemp 
ActivePassword 			.fill 12
PasswordEntryIndex 		.byte ?
ValidPassword 				.byte ?
PasswordInfiLives 		.byte ?
PasswordRedBullets 		.byte ?
PasswordHaveSpring 		.byte ?
PasswordLevelSkip 		.byte ?
checkSpriteToCharData 	.dstruct sCSTCCParams
mplexZP 						.dstruct sMplexZP
VARIABLES_END 
.send VARIABLES
.cerror * > $A200, "Too many variables"


; ----- @Map Temp Store@ -----
* = $A200
tileMapTemp .fill 240 

MAP_TEMP_STORE_END
mplexBuffer     .dstruct sMplexBuffer


;---------------------------
; MACROS
;---------------------------

mConvertXToEntSpriteX .macro
	inx
	inx
.endm

mRestoreEntSpriteX .macro
	dex
	dex
.endm
;}}}

; VRAM MAP
; $0:0000 64x32 4K TitleScreen 
; $0:1000 64x32 4K Game Screen
; $0:2000 128 empty chars to keep font aligned
; $0:2400 64 1 bit chars "font" 512Bytes 
; $0:2600 256 4bit chars "game" 8K 
; $0:4600 END
kVRAM .block
	titleScreen 	= $00000
	gameScreen 		= $01000
	font				= $02000
	fontDest			= $02400
	gameChars		= $02600
.bend

copyDataFields.values := [
									[fileFont,kVRAM.fontDest,2],
									[LowerFixedChars,kVRAM.gameChars+52*4*8,5], ; this is over but oh well
									[UpperFixedChars,kVRAM.gameChars+192*4*8,8], ; 2K worth
									[font4bpp, kVRAM.gameChars+128*4*8,8]
								 ]

.enc "screen"
*= $0801 
CODE_START
	.word (+), 2005 ;pointer, line number
	.null $9e, format("%d",start)
+	.word 0	 ;basic line end
	
	
.enc "qwak"	
	
*= $080D
.dsection STARTUP
.section STARTUP
start
	; we need to VLOAD the sprites
	stz $9F60 ; enable the KERNAL
	lda #2
	ldx #1
	ldy #0 ; custom address
	jsr $ffba ; setlfs
	lda #size(spriteFileName)
	ldx #<spriteFileName
	ldy #>spriteFileName 
	jsr $ffbd ; setname
	lda #3 ; VLOAD bank1
	ldx #0
	ldy #0 ; $0000 VRAM
	jsr $ffd5 ; load 
	sei
	stz kVERA.IEN ; disable VERA IRQs 
	lda #$ff
	sta kVERA.ISR ; ack any pending IRQS
	jsr copyStuff ; install the lower bank of VRAMs data
	
	; init the screen modes
	#appendVeraAddress kVERA.DisplayComposer.hScale|kVERA.inc_1
	lda #64
	sta kVERA.DATA_0
	sta kVERA.DATA_0 ; I want 320x200 mode	
		
	ldx #0
-	stz variables,x		; clear all the variables
	stz variables+$100,x
	stz tileMapTemp,x	; clear the tile map and after it so collisions is 00
	inx
	bne -

	; since the title screen lives on its own screen, we can just plot it one
	jsr emptyTitleScreen
	; draw all the strings on the screen
	ldx #16
	;ldx #0
	stx ZPTemp
-	ldx ZPTemp	
	jsr plotStringAAtIndexX
	dec ZPTemp
	bpl -	
		
	; init the sprite values, all sprites are 32x32 no flip, pallete 0	
	#appendVeraAddress kVERA.SpriteAttributes+6|kVERA.inc_8
	ldx #127 ; for all 128 sprites	
	lda #%00001100	; set all sprites on top of all no flip
-	sta kVERA.DATA_0	
	dex	
	bpl -	
	#appendVeraAddress kVERA.SpriteAttributes+7|kVERA.inc_8
	ldx #127 ; for all 128 sprites	
	lda #%10100000 ; set all sprites to 32x32 pall 0
-	sta kVERA.DATA_0	
	dex	
	bpl -	
	; make all sprites invisible so we don't get random ones just left arround from other things
	#appendVeraAddress kVERA.SpriteAttributes+3|kVERA.inc_8
	ldx #127 ; for all 128 sprites	
	lda #2 ; set xmsb off the side of the screen 
-	sta kVERA.DATA_0	
	dex	
	bpl -			
	; enable them
	#appendVeraAddress kVERA.SpriteRegisters|kVERA.inc_1	
	lda #1 ; enable sprites 
	sta kVERA.DATA_0

	; safe to enable IRQ here
	; all future VERA modifications need to be IRQ guarded
		
	jsr setirq ; clear all interupts and put out own in
	lda #kHideScreen.hide
	sta HideScreen
		
	lda #<titleScreenLoop
	sta GameStatePointer
	lda #>titleScreenLoop
	sta GameStatePointer+1
		
	lda #1
	sta GameData.high		
	sta mplexZP.lsbtod
	lda #$C0
	sta GameData.musicMode

		; main loop
MAINLOOP
-		lda mplexZP.lsbtod	
		beq -	
		dec mplexZP.lsbtod	
		jmp (GameStatePointer)	
.send STARTUP
	
;----------------------------			
; GAME LOOP			
;----------------------------			
; {{{				
.dsection GAME_LOOP			
.section GAME_LOOP		
GAMELOOP	
		jsr updateTickdowns
		ldx PlayerData.state
		#mCallFunctionTable PlayerCodeLUT,x
PlayerCodeLUT #mMakeFunctionTable PlayerAppear,PlayerNormal,PlayerNormal,PlayerNormal,PlayerExit,PlayerDead

PlayerAppear
		jsr convertLevelToTileMap
		jsr addShadowsToMap
		ldx # <tileMapTemp
		ldy # >tileMapTemp
		jsr plotTileMap
		jsr resetPlayerData 
		jsr setPlayerToSpawnPoint
		jsr unpackEntityBytes
		jsr setEntitySprites
		; jsr pltLevel
		lda #1
		sta mplexZP.lsbtod
	;	lda #kPlayerState.normal ; == 1
	.cerror kPlayerState.normal != 1, "need to add lda back"
		sta PlayerData.state
		jsr changePlayerAnimForCurrentDir
		stz GameData.exitOpen
		lda #kHideScreen.show
		sta HideScreen
		gra MAINLOOP
		
PlayerNormal
		jsr BuildEntCollisionTable
		jsr collidePlayerAgainstRest
		stx CollidedEntity
		lda PlayerData.hitBubbleNum
		sta ZPTemp2
		lda #0
		sta PlayerData.hitBubbleNum
		rol a ; pull is carry set
		sta ZPTemp
		beq _noSpriteCollision
			ldx CollidedEntity
			lda EntityData.type,x
			jsr isTypeBossBounceDetect
			bcs _bossBounce
				jsr isTypeBoss
				bcs _checkBossDeath
					cpx EntityData.pipeBubbleStart
					bcc _normalEnt
						; so it was a bubble
						lda PlayerData.onGround
						ora PlayerData.isFalling ; don't collide if I'm jumping up
						beq _skipDeath	
							ldx CollidedEntity	
							lda mplexBuffer.ypos+kEntsSpriteOffset,x	
							cmp mplexBuffer.ypos	
							bcc _skipDeath	
								stx PlayerData.hitBubbleNum
								cmp ZPTemp2
								beq _skipDeath
									jsr enterOnGround	
						_skipDeath	
								lda #0
								bra _noSpriteCollision
	_bossBounce
		lda PlayerData.hasShield
		beq _normalEnt
			ldx CollidedEntity
			jsr hurtBoss
			inc PlayerData.forceJump
			gra _skipDeathCheck
	_checkBossDeath
		lda EntityData.entState,x
		cmp #kBoss.dead
		beq _skipDeathCheck
_normalEnt
		lda ZPTemp
_noSpriteCollision
		ora PlayerData.dead
		beq _skipDeathCheck
			lda PlayerData.hasShield
			bne _skipDeathCheck
				lda PasswordInfiLives
				bne +
					dec GameData.lives		
					jsr pltLives		
		+		lda #kPlayerState.dead		
				sta PlayerData.state		
				sta PlayerData.minorState	
				jmp MAINLOOP		
_skipDeathCheck		
		stz PlayerData.dead
		jsr joyToPlayerDelta
		jsr checkSpriteToCharCollision
		; level skip
		lda PasswordLevelSkip
		beq _noKey
			jsr $FF9F ; SCAN KEY
			jsr $ffe4
			cmp #90 ; Z key, we can't detect C=/CX key with gettin
			bne _noKey
			lda #kPlayerState.exit
			sta PlayerData.state
			sta PlayerData.minorState
			jmp MAINLOOP
_noKey	
		lda checkSpriteToCharData.xDeltaCheck
		beq _addY
		;make sure x reg is 0, and call addXWithMSBAndClip
		ldx #0
		jsr addXWithMSBAndClip
_addY		
		lda mplexBuffer.ypos
		clc
		adc checkSpriteToCharData.yDeltaCheck
		sta mplexBuffer.ypos
		jsr updatePlayerAnim
		lda PlayerData.hasShield
		beq _noShield
			lda TickDowns.shieldFlashTimer
			bne _noShield
				;lda mplexBuffer.sprc ; this would flash the colour, but too much effort for this example
				;eor #7^14
				;sta mplexBuffer.sprc
				lda TickDowns.shieldFlashTimerSpeedUp
				bne +
					lda #35
					sta TickDowns.shieldFlashTimerSpeedUp
					dec PlayerData.baseFlashTimeDelta
			+	lda PlayerData.baseFlashTimeDelta
				sta TickDowns.shieldFlashTimer
_noShield
		gra EndOfGameLoop

PlayerExit		
		lda PlayerData.minorState
		cmp #kPlayerState.exit
		bne _waitForAnimation
			; we have to set up the exit animation
			lda #kPlayerAnimsIndex.exit
			jsr setPlayerAnimeTo
			;lda #kPlayerStateExit.waitForAnimation
			.cerror kPlayerStateExit.waitForAnimation != 0, "need to change stz"
			stz PlayerData.minorState
			lda PlayerData.exitAtIndex
			jsr setPlayerToIndexA
			jsr clearSheildState
_exit	gra EndOfGameLoop		
_waitForAnimation			
		jsr updatePlayerAnim			
		bcc _exit
			lda #<INTERLOOP			; move on to the interlude
			sta GameStatePointer
			lda #>INTERLOOP
			sta GameStatePointer+1
			stz PlayerData.state
			jsr disableAllEntSprites
			jmp MAINLOOP
		
incLevelGraphicSet		
		lda LevelData.levelGraphicsSet
		clc
		adc #1
		and #3
		sta LevelData.levelGraphicsSet
		rts
		
PlayerDead
		lda PlayerData.minorState
		cmp #kPlayerState.dead
		bne _waitForAnimation
			ldx #kSFX.hurt
			jsr playSFX
			; we have to set up the exit animation
			lda #kPlayerAnimsIndex.dead
			jsr setPlayerAnimeTo
			;lda #kPlayerStateDeath.animate
			.cerror kPlayerStateDeath.animate  != 0, "need to change stz"
			stz PlayerData.minorState
			jsr removePickups
_exit	gra EndOfGameLoop		
_waitForAnimation			
		dec mplexBuffer.ypos
		jsr updatePlayerAnim			
		bcc _exit
			lda GameData.lives
			beq _gameOver
				.cerror kPlayerState.appear != 0, "remove stz"
				;lda #kPlayerState.appear
				stz PlayerData.state
				;lda #0 ; appear = 0
				stz PlayerData.dead
				bra EndOfGameLoop
_gameOver
		stz PlayerData.state
		lda #<gameOverLoop
		sta GameStatePointer
		lda #>gameOverLoop
		sta GameStatePointer+1
		jmp MAINLOOP
		
EndOfGameLoop
		lda joyFireEvent              ; if    1 1 0 0
		eor PlayerData.bulletActive   ; and   0 1 0 1
		and joyFireEvent			  		; still 1 0 0 0
		beq _noBulletStart
			jsr startBullet
_noBulletStart
		jsr updateBullet
		jsr updateEntities
		jsr updateBubbles
		jsr animateDoor
		jmp MAINLOOP
.send GAME_LOOP	
; }}}	
;----------------------------			
; Intermission LOOP			
;----------------------------		
; {{{	
.dsection INTERMISSION	
.section INTERMISSION	
INTERLOOP
	jsr updateTickdowns
	ldx PlayerData.state
	mCallFunctionTable InterFuncLUT,x
InterFuncLUT mMakeFunctionTable interSetUp,interMovePlayer,interEnterDoor,interNextLevel
	
interSetUp	
	jsr PlotTransitionScreenAndMakeNextChars ; also set player index,exit index
	jsr setPlayerToSpawnPoint
	inc PlayerData.state
	lda #1
	sta PlayerData.movingLR
	sta PlayerData.onGround
	sta checkSpriteToCharData.xDeltaCheck
	sta GameData.exitOpen
	lda #$FF
	sta LevelData.exitIndex+1
	inc a
	jsr changePlayerDir
	jsr setAnimateDoorToClose
	lda GameData.currLevel
	clc
	adc #1
	cmp #31
	bne +
	lda #0
+ 	sta GameData.currLevel
	jsr deactivateAllEntities
	jsr removePickups
	jsr loadPasswordTemp
	jsr makePassword
	sei
		#appendVeraAddress getGameScreenCharPos(10,4) | kVERA.inc_1
		ldx #11
	-	lda ActivePassword,x
		jsr convertToPasswordLetter
		sta kVERA.DATA_0
		stz kVERA.DATA_0 ; CRAM is 0
		dex
		bpl -
	cli
	jmp MAINLOOP

interMovePlayer	
	ldx #0
	jsr addXWithMSBAndClip	
	jsr updatePlayerAnim
	jsr animateDoor
	lda mplexBuffer.xpos
	cmp #256-18
	bcc +
		inc PlayerData.state	
		lda #kPlayerAnimsIndex.exit
		jsr setPlayerAnimeTo
		jmp MAINLOOP
+	cmp #(11*16)	
	bne +	
		jsr setAnimateDoorToOpen		
		lda #kIntermission.secondExit
		sta LevelData.exitIndex
		lda #kSFX.door
		jsr playSFX
+	jmp MAINLOOP
		
interEnterDoor	
	jsr updatePlayerAnim
	bcc _exit
	lda GameData.currLevel
	ldx #size(BossLevels)-1
-	cmp BossLevels,x
	beq _bossLevel
	dex
	bpl -
	and #1
	clc
	adc #1
	.byte $2c ; BIT XXXXX
_bossLevel
	lda #3
	jsr playMusic
	lda #kPlayerState.appear
	sta PlayerData.state
	lda #<GAMELOOP
	sta GameStatePointer
	lda #>GAMELOOP
	sta GameStatePointer+1
_exit
	jmp MAINLOOP
	
interNextLevel
	jmp MAINLOOP
.send INTERMISSION	
;}}}
;----------------------------			
; GAME OVER LOOP		
;----------------------------	
; {{{	
.dsection GAME_OVER	
.section GAME_OVER	
gameOverLoop
	ldx PlayerData.state
	mCallFunctionTable GameOverFuncLUT,x
GameOverFuncLUT mMakeFunctionTable GOSetup,GOWaitForFire

GoSetup
	; print string
	ldx #17
	jsr plotStringAAtIndexXGameScreen
	inc PlayerData.state
	; remove sprites
	jsr disableAllEntSprites
	lda #4
	jsr playMusic
	; check to see if this is the new high score
	ldx #0
_l	lda GameData.score,x
	cmp GameData.high,x
	beq _next
	bcs _higher
	bra _clearScore
_next
	inx
	cpx #size(sGameData.score)
	bne _l
	; go to GOSetup
_clearScore
	ldx #size(sGameData.score) -1
	lda #0 
_l3	sta GameData.score,x
	dex
	bpl _l3
	jmp MAINLOOP
_higher
	ldx #size(sGameData.score) -1
_l2	lda GameData.score,x
	sta GameData.high,x
	dex
	bpl _l2
	jsr pltHighScore
	gra _clearScore
	
GOWaitForFire
	;wait for fire
	jsr scanJoystick
	lda joyFire
	beq _exit
		; got to Title Screen State
		lda #kPlayerState.appear
		sta PlayerData.state
		lda #<titleScreenLoop
		sta GameStatePointer
		lda #>titleScreenLoop
		sta GameStatePointer+1
		jsr clearAllEntities
_exit	
	jmp MAINLOOP
.send GAME_OVER
; }}}
;----------------------------			
; Title Screen Loop		
;----------------------------		
; {{{		
titleScreenLoop
	ldx PlayerData.state
	mCallFunctionTable TitleScreenLoopFuncLUT,x
TitleScreenLoopFuncLUT mMakeFunctionTable TSSetup,TSWaitForFire,TSStartGame	
	
TSSetup
	jsr clearAllSprites
	stz PasswordEntryIndex
	stz LevelData.levelGraphicsSet
	
; set up tilescreen mode
	sei
		#appendVeraAddress kVERA.Layer0.ctrl0|kVERA.inc_1
		lda #%00000001 ; mode 0 enabled
		sta kVERA.DATA_0
		;lda #%00000001 ; 8x8 64x32
		sta kVERA.DATA_0
		lda #<(kVRAM.titleScreen>>2)
		sta kVERA.DATA_0
		lda #>(kVRAM.titleScreen>>2) ; set map to tilescreen
		sta kVERA.DATA_0
		lda #<(kVRAM.font>>2) ; set charset to font
		sta kVERA.DATA_0
		lda #>(kVRAM.font>>2)
		sta kVERA.DATA_0
		stz kVERA.DATA_0 ; make sure H and V scroll are 0 while we are here
		stz kVERA.DATA_0
		stz kVERA.DATA_0
		stz kVERA.DATA_0
		#appendVeraAddress kVERA.Layer1.ctrl0|kVERA.inc_1
		stz kVERA.DATA_0 ; disable layer 1
	cli
	
	ldx #len(TitleScreenData.SpriteStruct.sprites)-1
-	lda TitleScreenData.SpriteStruct.ptr.lo,x
	sta mplexBuffer.sprp,x
	lda TitleScreenData.SpriteStruct.ptr.hi,x
	sta mplexBuffer.sprph,x
	lda TitleScreenData.SpriteStruct.x.lo,x
	sta mplexBuffer.xpos,x
	lda TitleScreenData.SpriteStruct.x.hi,x
	sta mplexBuffer.xmsb,x
	lda TitleScreenData.SpriteStruct.y,x
	sta mplexBuffer.ypos,x
	dex
	bpl -

	; set up the defaults here, in case a password modifies them
	jsr clearPlayerStuct
	lda #5
	sta GameData.lives
	stz GameData.currLevel	
	stz GameData.flowers	

	inc PlayerData.state
	lda #0
	sta ZPTemp2
	jsr playMusic
	lda #kHideScreen.show
	sta HideScreen
	jmp MAINLOOP
	
TSWaitForFire		
	jsr scanJoystick	
	sei
	jsr updateTickdowns	
	lda TickDowns.playerAnim	
	bne _checkJoy	
		ldx ZPTemp2	
		lda GameData.musicMode
		clc
		rol a
		rol a
		rol a ; get upper 2 bits wrapped arround to the lower 2 bits
		tay
		lda TitleScreenData.menuOffsetsEnd,y
		sta ZPTemp	
		stz kVERA.CTRL
		lda #`kVRAM.titleScreen|kVERA.inc_2 ; skip char data
		sta kVERA.ADDR_Hi
CRAMLinePos = getTitleScreenCharPos(0,22)+1 ; get the 11 line	
		lda TitleScreenData.menuOffsetsStart,y
		tay
		clc
		adc #<CRAMLinePos
		sta kVERA.ADDR_Lo
		lda #>CRAMLinePos
		adc #0
		sta kVERA.ADDR_Mid
	-	lda TitleScreenData.spriteCol,x	
		sta kVERA.DATA_0
;	pha
;	lda PasswordInfiLives ; if cheats are enabled the text QWAK sprites flashed
;	beq +
;	pla
;	sta mplexBuffer.sprc  ; to much effor for this demo
;	pha
;+	lda PasswordRedBullets 
;	beq +
;	pla
;	sta mplexBuffer.sprc+1
;	pha
;+ 	lda PasswordHaveSpring 
;	beq +
;	pla
;	sta mplexBuffer.sprc+2
;	pha
;+	lda PasswordLevelSkip
;	beq +
;	pla
;	sta mplexBuffer.sprc+3
;	pha
;+	pla 
		txa	
		clc	
		adc #1	
		and #3	
		tax	
		iny
		iny
		cpy ZPTemp	
		bne -	
		stx ZPTemp2
		lda #4
		sta TickDowns.playerAnim
_checkJoy
	lda TickDowns.doorAnim
	bne _noScroll
		lda #8
		sta TickDowns.doorAnim
		lda joyRight
		beq _notLeft
			lda GameData.musicMode
			sec
			sbc #64
		_saveNoMode
			and #128+64
			sta GameData.musicMode
			lda #<CRAMLinePos
			sta kVERA.ADDR_Lo
			lda #>CRAMLinePos
			sta kVERA.ADDR_Mid
			lda #`kVRAM.titleScreen|kVERA.inc_2 ; skip char data
			sta kVERA.ADDR_Hi
			lda #1
			ldy #38
		-	sta kVERA.DATA_0
			dey
			bpl -
			bit GameData.musicMode
			bpl _startMusic
				lda #0
				.byte $2c
		_startMusic
			lda #5
		;	jsr SID
			bra _noScroll
	_notLeft	
		lda joyLeft	
		beq _noScroll	
			lda GameData.musicMode
			clc
			adc #64	
			gra _saveNoMode
_noScroll	
	lda joyFire
	beq _exit	
		lda oldJoyFire
		bne _exit
			inc PlayerData.state	
			lda #kHideScreen.hide
			sta HideScreen
_exit	
	cli
	jsr $FF9F ; SCAN KEY
	jsr $FFE4 ; GETIN
	beq _noKey	
		cmp #32
		beq _clear
			jsr convertASCIIToQwakChar	
			ldy PasswordEntryIndex
			sta PasswordRAMCache,y
			tax	
			cpy #12
			beq _noKey
		PasswordBaseScreenPos = getTitleScreenCharPos(TitleScreenData.PasswordBlank[1],TitleScreenData.PasswordBlank[2])
		tya
		asl a ; convert to 2 wide for screen
		clc 
		adc #<PasswordBaseScreenPos
		sei
			stz kVERA.CTRL
			sta kVERA.ADDR_Lo
			lda #>PasswordBaseScreenPos
			adc #0
			sta kVERA.ADDR_Mid
			lda #`PasswordBaseScreenPos
			sta kVERA.ADDR_Hi
			stx kVERA.DATA_0
		cli 
		inc PasswordEntryIndex	
		lda PasswordEntryIndex
		cmp #12
		beq _checkPassword
_noKey	
	cli
	jmp MAINLOOP	
_clear	
	ldx #16	
	jsr plotStringAAtIndexX
	stz PasswordEntryIndex
	stz ValidPassword
	gra _noKey
_checkPassword
	lda PasswordRAMCache,x
	pha
		jsr convertLetterToNumber
		sta ActivePassword,x
	pla
	jsr isValidLetter
	bcc _fail
		dex
		bpl _checkPassword
			; pass
			jsr extractPassword
			jsr validateExtractedPassword
			bcs _fail
				jsr unloadPasswordTemp
				lda #VIC.Colours.light_green
				_plotColourExit
				sei
					stz kVERA.CTRL
					ldx #<PasswordBaseScreenPos+1
					stx kVERA.ADDR_Lo
					ldx #>PasswordBaseScreenPos
					stx kVERA.ADDR_Mid
					ldx #`PasswordBaseScreenPos | kVERA.inc_2
					stx kVERA.ADDR_Hi
					ldx #11
				-		
					sta kVERA.DATA_0
					dex
					bpl  -
				cli
				bra _noKey
_fail
	ldy #0
	jsr checkPasswordForCheat
	bcs _lives
		ldy #12
		jsr checkPasswordForCheat
		bcs _red
			ldy #24
			jsr checkPasswordForCheat
			bcs _spring
				ldy #36
				jsr checkPasswordForCheat
				bcs _levelSkip
_setTextRed
	lda #VIC.Colours.red
	bra _plotColourExit
_lives
	lda #1
	sta PasswordInfiLives
	bra _setTextRed
_red
	lda #1
	sta PasswordRedBullets
	bra _setTextRed
_spring
	lda #1
	sta PasswordHaveSpring
	bra _setTextRed
_levelSkip
	lda #1
	sta PasswordLevelSkip
	bra _setTextRed
checkPasswordForCheat	
	ldx #0
-	lda PasswordRAMCache,x
	cmp PASSWORD_LIVES,y
	bne _fail
		inx
		iny
		cpx #12
		bne -
		;sec cmp above will set this already
		rts
_fail	
	clc	
	rts		

PasswordRAMCache .fill 12
		
TSStartGame
	jsr setupBackDisolveFruitChars
	lda #<GAMELOOP
	sta GameStatePointer
	lda #>GAMELOOP
	sta GameStatePointer+1
	; fall through
RESET	
	jsr clearAllSprites
	jsr plotStatusArea
	; flip the screen
	sei
		#appendVeraAddress kVERA.Layer0.ctrl0|kVERA.inc_1
		lda #%01100001 ; mode 3 enabled
		sta kVERA.DATA_0
		lda #%00000001 ; 8x8 64x32
		sta kVERA.DATA_0
		lda #<(kVRAM.gameScreen>>2)
		sta kVERA.DATA_0
		lda #>(kVRAM.gameScreen>>2) ; set map to tilescreen
		sta kVERA.DATA_0
		lda #<(kVRAM.gameChars>>2) ; set charset to font
		sta kVERA.DATA_0
		lda #>(kVRAM.gameChars>>2)
		sta kVERA.DATA_0
		stz kVERA.DATA_0 ; make sure H and V scroll are 0 while we are here
		stz kVERA.DATA_0
		stz kVERA.DATA_0
		stz kVERA.DATA_0
		#appendVeraAddress kVRAM.gameScreen|kVERA.inc_1
		ldy #0
	-	ldx #15
		lda #$00
		-	sty kVERA.DATA_0
			sta kVERA.DATA_0
			iny
			dex
			bpl -
		lda kVERA.ADDR_Lo
		clc
		adc #128-32
		sta kVERA.ADDR_Lo
		bcc +
			inc kVERA.ADDR_Mid
	+	cpy #0
	bne --
	; plot bottom row of screen
	#appendVeraAddress kVRAM.gameScreen+(24*128)|kVERA.inc_1
	lda #5
	sta ZPTemp
	ldy #kSBC.M ; clear char
-	ldx #39
	lda #$00
	-	sty kVERA.DATA_0
		sta kVERA.DATA_0
		dex
		bpl -
	lda kVERA.ADDR_Lo
	clc
	adc #128-80
	sta kVERA.ADDR_Lo
	bcc +
		inc kVERA.ADDR_Mid
+	dec ZPTemp
	bpl --

	jsr pltLives
	cli
	lda #<GAMELOOP
	sta GameStatePointer
	lda #>GAMELOOP
	sta GameStatePointer+1
	lda #kPlayerState.appear 
	sta PlayerData.state
	lda #1
	jsr playMusic
	jmp MAINLOOP	
		
; }}}		
; }}}	
	
.dsection sSUBS 
.section sSUBS 	
;----------------------------			
; SUBS	
;----------------------------		
; {{{
addXWithMSBAndClip		
	stz DidClipX	
	lda mplexBuffer.xpos,x
	cmp #200
	bcs _veryRight
	cmp #64
	bcs _justAddAndGo
	;_veryLeft
		;clc 
		adc checkSpriteToCharData.xDeltaCheck
		cmp #200
		bcc _justStore			
			inc DidCLipX
			lda #0
			bra _justStore
	_veryRight	
		clc
		adc checkSpriteToCharData.xDeltaCheck
		cmp #256-16
		bcc _justStore
			inc DidClipX
			lda #256-16
			bra _justStore
	_justAddAndGo	
		clc
		adc checkSpriteToCharData.xDeltaCheck
	_justStore
		sta mplexBuffer.xpos,x
		
	rts		
			
		
joyToPlayerDelta 
		jsr scanJoystick
		stz checkSpriteToCharData.xDeltaCheck
		stz checkSpriteToCharData.yDeltaCheck
		stz PlayerData.movingLR
		lda joyLeft
		ora joyRight
		beq _noLR
		lda joyLeft
		bne _left
		lda PlayerData.slowMove
		beq +
		lda #1
		.byte $2c ; bit
+		lda #2
		sta checkSpriteToCharData.xDeltaCheck
		lda joyRight
		and oldJoyLeft
		beq _fullSpeedRight ; we were already going left
		lda PlayerData.onGround
		bne _clearSpeedRight
		lda #1
		.byte $2c
_clearSpeedRight
		stz PlayerData.slowMove
_fullSpeedRight
		lda #1
		sta PlayerData.movingLR
		dec a ; a = 0
		jsr changePlayerDir
		gra _endLR
_left	lda PlayerData.slowMove
		beq +
		lda #255
		.byte $2c ; bit
+		lda #254
		sta checkSpriteToCharData.xDeltaCheck
		lda joyLeft
		and oldJoyRight
		beq _fullSpeedLeft ; we were already going left
		lda PlayerData.onGround
		bne _clearSpeedLeft
		lda #1
		.byte $2c
_clearSpeedLeft
		stz PlayerData.slowMove
_fullSpeedLeft
		lda #1
		sta PlayerData.movingLR
		;lda #1
		jsr changePlayerDir
		bra _endLR
		
_noLR	lda #$80	
		sta PlayerData.startedJumpLR
		stz PlayerData.slowMove
_endLR
		lda PlayerData.movingLR
		bne +
		lda PlayerData.facingRight
		jsr changePlayerDir
+		lda PlayerData.onGround
		and joyUpStart
		ora PlayerData.forceJump
		bne StartJump
		lda PlayerData.onGround
		bne OnGround
		lda PlayerData.yDeltaAccum + 1
		bpl falling
		stz PlayerData.isFalling
		lda PlayerData.hasJumped ; if this is 1
		eor PlayerData.isFalling   ; and so is this, it will make it 0, other wise still 1
		and joyUpStop 			 ; and the player has let go
		bne AbortJump
;		lda PlayerData.onGround
;		bne OnGround
		; we are in air then
normalJumpUpdate
		ldx # kJumpIndexs.normal
customJumpUpdate
		jsr incPlayerYDeltaAndReturn
		lda PlayerData.yDeltaAccum + 1
		sta checkSpriteToCharData.yDeltaCheck
		rts
falling
		lda #1
		sta PlayerData.isFalling
		lda PlayerData.canFloat
		ora PasswordHaveSpring
		beq normalJumpUpdate
		bra handleFall
OnGround
		lda #kPlayerState.normal
		sta PlayerData.state
		lda PlayerData.hitBubbleNum
		beq _skip
		lda #255
		.byte $2c
_skip
		lda #1
		sta checkSpriteToCharData.yDeltaCheck
		jmp changePlayerAnimForCurrentDir
;		rts

AbortJump		
		lda #$80	
		sta PlayerData.yDeltaAccum	
		lda #$FF
		sta PlayerData.yDeltaAccum+1		
		rts		
StartJump
		lda #1
		sta PlayerData.hasJumped	; we are jumping
		lda #kPlayerState.jump
		sta PlayerData.state
		stz PlayerData.isFalling	; not falling
		stz PlayerData.onGround		; not on the ground
		stz PlayerData.yDeltaAccum	; set the Y jump accleration
		stz PlayerData.forceJump
		lda # kTimers.floatTimer	; reset the float timer
		sta PlayerData.floatTimer
		lda # kPlayerParams.jumpStartDelta	; set the other half of jump accleration
		sta PlayerData.yDeltaAccum + 1
		sta checkSpriteToCharData.yDeltaCheck
		jsr changePlayerAnimForCurrentDir
		ldx #kSFX.jump
		jmp playSFX
		;rts ; above it now a jmp	
handleFall
		lda PlayerData.state
		cmp #kPlayerState.jump
		bne _didntJustStartFalling
		lda joyUp ; if we just start falling, and joy is up and we have spring float
		beq _didntJustStartFalling
		lda #kPlayerState.flap
		sta PlayerData.state
		bra _dontStopFloat
_didntJustStartFalling
		lda PlayerData.state
		cmp #kPlayerState.flap
		bne _checkUpStart
		lda joyUpStop
		beq _dontStopFloat
		lda #kPlayerState.jump
		sta PlayerData.state
		jmp normalJumpUpdate
_dontStopFloat
		lda PlayerData.floatTimer
		bpl +
		jmp normalJumpUpdate
+		dec PlayerData.floatTimer
		ldx #kJumpIndexs.floaty
		jmp customJumpUpdate
_checkUpStart		
		lda joyUpStart		
		bne +
		jmp normalJumpUpdate		
+		lda #kPlayerState.flap		
		sta PlayerData.state		
		ldx #kJumpIndexs.floaty
		jmp customJumpUpdate			
				
enterOnGround
		lda #kPlayerState.normal ; == 1
		sta PlayerData.state
		;lda #1
		.cerror kPlayerState.normal != 1, "need to add lda #1"
		sta PlayerData.onGround
		sta PlayerData.yDeltaAccum
		stz PlayerData.hasJumped
		stz PlayerData.isFalling		
		stz PlayerData.yDeltaAccum + 1
		stz PlayerData.slowMove
		lda PlayerData.facingRight		
		;jmp changePlayerDir
		;rts ; above is now jmp
changePlayerDir
		sta PlayerData.facingRight
changePlayerAnimForCurrentDir
		lda PlayerData.state
		cmp #kPlayerState.flap
		bne _notFlap
		lda #kPlayerAnimsIndex.flapRight
		bra _still
_notFlap
		lda PlayerData.onGround
		bne _onGround
		lda #kPlayerAnimsIndex.jumpRight
		bra _still
_onGround
		lda PlayerData.movingLR
		beq _notMoving
		lda #kPlayerAnimsIndex.standWalkRight
		bra _still
_notMoving
		lda #kPlayerAnimsIndex.standRight		
_still	clc
		adc PlayerData.facingRight
		gra setPlayerAnimeTo
		;rts ;above is now a jmp
	
incPlayerYDeltaAndReturn
		lda PlayerData.yDeltaAccum
		clc
		adc PlayerJumpLUT,x
		sta PlayerData.yDeltaAccum
		lda PlayerData.yDeltaAccum + 1
		adc #0
		bmi +
		cmp # kPlayerParams.maxFallSpeed
		bcc +
		lda # kPlayerParams.maxFallSpeed
+		sta PlayerData.yDeltaAccum + 1
		rts

setPlayerAnimeTo
		cmp PlayerData.currAnim
		beq _dontchange
		sta PlayerData.currAnim
		tax
		lda PlayerSprLUT,x
		sta PlayerData.baseSprite
		jsr setSpritePtrFromFrameNumber
		lda PlayerFrameCountLUT,x
		sta PlayerData.frameCount
		lda PlayerAnimTimer,x
		sta PlayerData.frameTimer
		sta TickDowns.playerAnim
		stz PlayerData.frameOffset
_dontchange		
		rts
		
setSpritePtrFromFrameNumber
	sta mplexBuffer.sprp ; this needs to be x16 | $800
	stz mplexBuffer.sprph 
	asl mplexBuffer.sprp ; x2
	rol mplexBuffer.sprph
	asl mplexBuffer.sprp ; x4
	rol mplexBuffer.sprph
	asl mplexBuffer.sprp ; x8
	rol mplexBuffer.sprph
	asl mplexBuffer.sprp ; x16
	rol mplexBuffer.sprph
	lda mplexBuffer.sprph
	ora #$08
	sta mplexBuffer.sprph
	rts	
		
; returns carry clear if anim did not loop		
; carry is set if it did		
updatePlayerAnim
	lda PlayerData.frameCount
	cmp #2
	bcc _skip
	lda TickDowns.playerAnim
	beq _itTime
	clc
_skip	
	rts
_itTime
	lda PlayerData.frameOffset
	clc
	adc #1
	cmp PlayerData.frameCount
	bcc _store
	lda #0
_store	
	sta PlayerData.frameOffset
	php ; if we overflowed c will be set, else clear
	clc
	adc PlayerData.baseSprite
	jsr setSpritePtrFromFrameNumber
	;sta mplexBuffer.sprp
	lda PlayerData.frameTimer
	sta TickDowns.playerAnim
	plp ; restore carry state
	rts 

PlayerJumpLUT .byte kPlayerParams.jumpDeltaAccum, kPlayerParams.jumpDeltaAccumFloat
						; Left	Right  Walk L	Walk R
PlayerSprLUT		.byte 0,0+04,0+08,0+12,0+16,0+18,0+20,0+22,0+24,0+28
PlayerFrameCountLUT .byte 1	   	  ,1		  ,4		  ,4		  ,2		  ,2		  ,2		  ,2		  ,4		  ,4
PlayerAnimTimer		.byte 255     ,255		  ,8		  ,8		  ,8		  ,8		  ,8		  ,8		  ,8		  ,8

clearPlayerStuct
	ldx #size(sPlayerData)-1
-	stz PlayerData,x
	dex
	bpl -
	rts

removePickups	
	stz PlayerData.hasShield
	stz PlayerData.canFloat
	stz PlayerData.hasSpring
	stz PlayerData.bulletActive
	stz PlayerData.bulletEgg	
	rts	


bulletFrame .byte 0

startBullet
	lda #1
	sta PlayerData.bulletActive
	ldx #kSFX.bubble
	jsr playSFX
	stz PlayerData.bulletUD
	stz PlayerData.bulletBurst
	lda PlayerData.facingRight
	sta PlayerData.bulletLR
	lda #200
	sta TickDowns.bulletLifeTimer	
	lda mplexBuffer.xpos
	sta mplexBuffer.xpos+kBulletSpriteOffset
	lda mplexBuffer.ypos
	sec
	sbc #3
	sta mplexBuffer.ypos+kBulletSpriteOffset
	lda mplexBuffer.xmsb
	sta mplexBuffer.xmsb+kBulletSpriteOffset
	lda PlayerData.bulletEgg
	ora PasswordRedBullets
	beq _normal
		lda #kSprites.bulletSprite+7
		.cerror kSprites.bulletSprite+7 == 0, "change branch"
		bra _store
_normal
	lda #kSprites.bulletSprite
_store
	gra SetBulletSpriteFromFrame
	;rts
	
updateBullet
	lda PlayerData.bulletActive
	beq bulletExit
	lda TickDowns.bulletLifeTimer
	bne bulletNotDead
removeBullet
	stz PlayerData.bulletActive
	lda PlayerData.bulletEgg
	beq +
		lda PasswordRedBullets
		bne +
			dec PlayerData.bulletEgg
+	lda #255
	sta mplexBuffer.ypos+kBulletSpriteOffset
bulletExit
	rts
	
burstBullet
	lda #kSprites.bulletSprite+3
	jsr SetBulletSpriteFromFrame
	lda #16
	sta TickDowns.bulletLifeTimer
	lda #1
	sta PlayerData.bulletBurst
	ldx #kSFX.ebubble
	jmp playSFX
	;rts ; above is now a jump
bulletNotDead	
	lda PlayerData.bulletBurst
	bne bulletExit
	lda PlayerData.bulletEgg
	ora PasswordRedBullets
	bne _bulletFull
	lda bulletFrame
	cmp #kSprites.bulletSprite+2
	beq _bulletFull
	lda TickDowns.bulletLifeTimer
	and #$07
	bne _bulletFull
	inc bulletFrame
	lda bulletFrame
	jsr SetBulletSpriteFromFrame
_bulletFull	
	lda #kBulletCollisionbox
	sta CollideSpriteBoxIndex
	; lda #kBulletSpriteOffset ; same as kBulletCollisionbox
	sta CollideSpriteToCheck
	lda #<UpdateBulletEndYColl
	sta Pointer1
	lda #>UpdateBulletEndYColl
	sta Pointer1+1
	lda #0
	sta CollisionResult
	tay ; ldy #0
	lda PlayerData.bulletUD
	beq +
	jmp entDown
+	jmp entUp

SetBulletSpriteFromFrame
	sta bulletFrame 
	sta mplexBuffer.sprp+kBulletSpriteOffset ; this needs to be x16 | $800
	stz mplexBuffer.sprph+kBulletSpriteOffset 
	asl mplexBuffer.sprp+kBulletSpriteOffset ; x2
	rol mplexBuffer.sprph+kBulletSpriteOffset
	asl mplexBuffer.sprp+kBulletSpriteOffset ; x4
	rol mplexBuffer.sprph+kBulletSpriteOffset
	asl mplexBuffer.sprp+kBulletSpriteOffset ; x8
	rol mplexBuffer.sprph+kBulletSpriteOffset
	asl mplexBuffer.sprp+kBulletSpriteOffset ; x16
	rol mplexBuffer.sprph+kBulletSpriteOffset
	lda mplexBuffer.sprph+kBulletSpriteOffset
	ora #$08
	sta mplexBuffer.sprph+kBulletSpriteOffset
	rts
	
UpdateBulletEndYColl
	lda CollisionResult	
	beq _updateY
	lda PlayerData.bulletUD
	eor #1
	sta PlayerData.bulletUD
	bpl _checkX
_updateY
	lda mplexBuffer.ypos+kBulletSpriteOffset	
	clc	
	adc checkSpriteToCharData.yDeltaCheck
	sta mplexBuffer.ypos+kBulletSpriteOffset	
_checkX	
	lda #<UpdateBulletEndXColl
	sta Pointer1
	lda #>UpdateBulletEndXColl
	sta Pointer1+1
	lda #$00
	sta CollisionResult
	tay ;ldy #0
	lda PlayerData.bulletLR
	bne +
	jmp entRight
+	jmp entLeft

	; do some more collision checking here
UpdateBulletEndXColl	
	lda CollisionResult	
	beq _updateX
	lda PlayerData.bulletLR
	eor #1
	sta PlayerData.bulletLR
	bpl _checkEnts
_updateX
	ldx #kBulletSpriteOffset	
	jsr addXWithMSBAndClip	
	lda DidClipX	
	beq _checkEnts	
	lda PlayerData.bulletLR
	eor #1
	sta PlayerData.bulletLR	
_checkEnts	
	jsr collideBulletAgainstRest	
	bcc _exit2 ; didn't hit one	
	lda EntityData.type,x
	jsr isTypeBoss
	bcs _boss
		lda #255
		sta mplexBuffer.ypos+kEntsSpriteOffset,x
		sta EntityData.entState,x
		sta EntityData.movTimer,x
		inc a ; 0
		sta EntityData.active,x
		inc a ;1 
		sta EntityData.speed,x 
		jmp burstBullet
	_exit2
		rts
_boss
	lda PlayerData.bulletEgg
	ora PasswordRedBullets
	beq _exit2 ; only accept eggs for the boss
	lda EntityData.type,x
	jsr isTypeBossBounceDetect
	bcs _found
		dex ; doesn't affect C
		bra _boss
_found
	jsr hurtBoss
	jmp burstBullet

; carry clear not boss, set boss
isTypeBoss	
	cmp #kEntity.bear
	bcc _notBoss
	cmp #kEntity.octopussBody+1
	bcc _boss
	cmp #kEntity.bossDummy
	beq _boss	
_notBoss
	clc
	.byte $24
_boss
	sec
	rts

isTypeBossBounceDetect	
	cmp #kEntity.bear	
	beq _yes	
	cmp #kEntity.octopuss	
	beq _yes	
	clc	
	.byte $24	
_yes	
	sec	
	rts	
	
hurtBoss	
	lda EntityData.entState,x
	cmp #kBoss.dead
	beq _exit
	lda EntityData.movTimer+1,x
	bne _exit
	dec EntityData.active,x
	lda EntityData.active,x
	cmp #1
	beq _killedBoss
	; we need to flash them so the player knows they did something
	lda #01
	jsr setBossSpriteToColour
	lda #16
	sta EntityData.movTimer+1,x ; store the flash timer in the 2nd sprite
_exit
	rts
_killedBoss
	; well just killed the boss
	lda #kBoss.dead
	sta EntityData.entState,x
	lda #kSprites.splat
	;sta mplexBuffer.sprp+kEntsSpriteOffset,x
	;sta mplexBuffer.sprp+kEntsSpriteOffset+1,x
	;sta mplexBuffer.sprp+kEntsSpriteOffset+2,x
	;sta mplexBuffer.sprp+kEntsSpriteOffset+3,x
	jsr SetEntSpriteFromFrame
	inx
	lda #kSprites.splat
	jsr SetEntSpriteFromFrame
	inx
	lda #kSprites.splat
	jsr SetEntSpriteFromFrame
	inx 
	lda #kSprites.splat
	jsr SetEntSpriteFromFrame
	dex
	dex
	dex
	lda #kBoss.deathAnimTime
	sta EntityData.movTimer,x
	stx ZPTemp
	lda #kScoreIndex.boss
	jsr giveScore
	ldx ZPTemp
	rts

clearAllSprites
	ldx #0
	lda #255
-	sta mplexBuffer.ypos,x	; disbale all sprites
	sta mplexBuffer.xmsb,x  ; to be sure sure 
	inx			  
	cpx #mPlex.kMaxSpr+1	 ;have we reached 32 yet?
	bne -
	rts
	
disableAllEntSprites
	lda #255
	ldx #mplex.kMaxSpr
-	sta mplexBuffer.ypos,x
	dex
	bne -
	rts
	
clearAllEntities
	stz EntityData.number
	stz EntityData.numPipes
	stz EntityData.lastPipeUsed
	ldx #kEntity.maxEntities 
-	stz EntityData.type,x
	stz EntityData.active,x
	stz EntityData.entState,x
	dex
	bpl -
	rts
		
emptyTitleScreen
		#appendVeraAddress kVRAM.titleScreen | kVERA.inc_1
		ldy #$0f ; do 16 pages aka 4K
		ldx #00
-		lda #" "
		sta kVERA.DATA_0
		stz kVERA.DATA_0
		dex
		bne -
		dey
		bpl -
		rts		
			
convertLevelToTileMap
		stz LevelData.numKeys
		stz LevelData.totalKeys
		stz EntityData.numPipes
		stz EntityData.lastPipeUsed
		lda #$FF
		sta LevelData.exitIndex
		sta LevelData.exitIndex+1
		lda #<tileMapTemp
		sta Pointer1
		;sta LevelTileMapPtrLo
		lda #>tileMapTemp
		sta Pointer1+1
		;sta LevelTileMapPtrHi
		ldx GameData.currLevel
		lda LevelTableLo,x
		sta Pointer2
		lda LevelTableHi,x
		sta Pointer2+1
; read level pointers
		ldy #0
		sty ActiveTileIndex
		;lda (Pointer2),y
		;clc
		;adc Pointer2
 		;sta LevelKeyListPtrLo skip these pointers as no longer used 
		iny
		;lda (Pointer2),y
		;adc Pointer2+1
		;sta LevelKeyListPtrHi
		iny
		lda (Pointer2),y
		clc
		adc Pointer2
		sta EntityDataPointer
		iny
		lda (Pointer2),y
		adc Pointer2+1
		sta EntityDataPointer+1
		clc
		lda Pointer2
		adc #4
		sta Pointer2
		lda Pointer2+1
		adc #0
		sta Pointer2+1
		
		lda #12
		pha
_row	ldy #0
_loop	; read in 16 bytes		
		lda (Pointer2),y		
		cmp # kTiles.player
		beq _playerPos	
		cmp # kTiles.exit	
		beq _exitPos	
		cmp # kTiles.key1
		beq _key
		cmp # kTiles.key2
		beq _key
		cmp # kTiles.key3
		beq _key
		cmp # kTiles.key4
		beq _key
		cmp # kTiles.pipe
		beq _pipe
		cmp # kTiles.diss
		beq _dissBlock
		; covert and then push out		
_cont	;tax		
		;lda toolToTileLUT,x		
		sta (Pointer1),y		
		inc ActiveTileIndex	
		iny		
		cpy #16		
		bne _loop		
		clc		
		lda Pointer2	
		adc #16		
		sta Pointer2	
		lda Pointer2+1	
		adc #0		
		sta Pointer2+1	
		clc		
		lda Pointer1	
		adc #16		
		sta Pointer1	
		lda Pointer1+1	
		adc #0		
		sta Pointer1+1	
		pla 
		sec 
		sbc #1	
		cmp #0	
		pha 
		bne _row	
		pla 
		rts 
_playerPos
		lda ActiveTileIndex
		sta LevelData.playerIndex
		lda #kTiles.back ; 0
		bra _cont
_key	inc LevelData.numKeys
		inc LevelData.totalKeys
		bra _cont
_dissBlock
		lda #kTiles.diss
		bra _cont		
_exitPos
		lda ActiveTileIndex
		ldx LevelData.exitIndex
		cpx #$FF
		bne _2nd
			sta LevelData.exitIndex
			bra +
_2nd	sta LevelData.exitIndex+1		
+		lda #kTiles.exit
		bra _cont
_pipe
		ldx EntityData.numPipes
		lda ActiveTileIndex
		sec
		sbc #16
		sta EntityData.pipeIndex,x
		inx
		stx EntityData.numPipes
		lda #kTiles.pipe
		bra _cont
		

addShadowsToMap				
	stz TempX	
-	ldy TempX
	jsr tileIsSafeToChange
	bcc _next
	jsr calcBCDEforTileY
_next	
	inc TempX
	lda TempX
	cmp #kLevelSizeMax
	bne -
	rts
	
tileIsWall						
	lda tileMapTemp,y						
	beq	_no					
	cmp #kTiles.wall4+1						
	bcc _yes						
	cmp #kTiles.diss						
	bne _no												
	clc						
_yes						
	rts ; carry is clear						
_no sec						
	rts ; carry is set						
						
tileIsSafeToChange					
	lda tileMapTemp,y					
	beq _yes ; 0 is safe					
	cmp #kTiles.underHangStart					
	bcs _yes					
	rts ; carry is clear					
_yes					
	sec					
	rts					
		
; Don't try and understand this, not worth your life, it calcs the saul drop shadow, just move on.		
;  BCD
;  EA
;   H
; A is tile we are testing
;  BCDE H
;  1110   = under hang
;  1100   = under hang right end
;  0110   = under hanr left  end
;  0001 0 = left wall top end
;  1001   = left wall
;  1000   = 35
;  11X1   = top left
;  0XX1 1 = bottom left					
calcBCDEforTileY		
	sty ZPTemp				
	sty ZPTemp2				
	tya			
	and #15			
	bne _canDoLeft			
		lda #$80		; can'r do left on Negative				
		bra +			
_canDoLeft			
	lda #0			
+	sta ZPTemp4			
	lda ZPTemp			
	and #15			
	cmp #15 			
	bne _canDoRight			
		lda #$40		 ; can't do right on Overflow	
		sta ZPTemp4			
_canDoRight			
END_LEFT_RIGHT_CHECK	
	lda #1+2+4 ; first 3 are empty ( it is inverted later)				
	sta ZPTemp3
	ldy ZPTemp	 	
	cpy #kTileXCount				
	bcc _doneFirstRow ; if it is the first row than ALL of above is not solid						
		stz ZPTemp3						
		tya					
		;sec ;from bcc above					
		sbc #kTileXCount+1 ; so get -1x,-1y					
		sta ZPTemp2
		tay
		bit ZPTemp4 ; test to see if we can do right
		bmi _noB	; no then skip B					
			jsr tileIsWall					
			rol ZPTemp3					
			bra _testC				
	_noB					
		sec			; if there is no B then make it clear	
		rol ZPTemp3 				
	_testC		
		iny 					
		jsr tileIsWall				
		rol ZPTemp3				
		iny				
		bit ZPTemp4			
		bvs _noRight			
			jsr tileIsWall			
			rol ZPTemp3			
			bra _doneFirstRow			
	_noRight				
		sec ; make it as 1 so it gets 0 later		
		rol ZPTemp3		
_doneFirstRow				
	bit ZPTemp4				
	bmi _noE ; check negative flag				
		ldy ZPTemp				
		dey				
		jsr tileIsWall				
		rol ZPTemp3				
		bra DoIndexCheck			
_noE			
	sec ; make it 1 so it gets 0 later			
	rol ZPTemp3			
DoIndexCheck			
	lda ZPTemp3		
	eor #$0F ;
	tay 		
BCDEYVALUECHECK
	lda BCDELUT,y		
	bmi _checkH	
	_writeMap	
		ldy ZPTemp		
		sta tileMapTemp,y		
		rts		
_checkH				
	lda ZPTemp		
	clc		
	adc #kTileXCount		
	tay		
	jsr tileIsWall		
	bcs _HNotWall		
		lda #kTiles.back		
_HNotWall			
	lda #kTiles.sideShadow					
	bra _writeMap			
				
BCDELUT	.byte $00							; 0000
		.byte kTiles.sideShadow				; 0001	
		.byte $00								; 0010
		.byte kTiles.sideShadow				; 0011
		.byte kTiles.underHangStart		; 0100			
		.byte kTiles.topLeftCorner			; 0101
		.byte kTiles.underHangStart		; 0110		
		.byte kTiles.sideShadow				; 0111
		.byte kTiles.shadowOpenCorner		; 1000				
		.byte kTiles.middlesideShadow		; 1001		
		.byte kTiles.shadowOpenCorner		; 1010
		.byte kTiles.sideShadow				; 1011			
		.byte kTiles.underHang				; 1100				
		.byte kTiles.topLeftCorner			; 1101				
		.byte kTiles.underHang				; 1110				
		.byte kTiles.topLeftCorner			; 1111				
								
		; back
		;wall,wall1,wall2,wall3,wall4
		;spike,flower,fruit
		;key1,key2,key3,key4
		;shield,spring,potion,egg
		;exit,something,something,
		;diss + 13
toolToTileLUT 		
	.byte 0		
	.byte 1,1,1,1,1		
	.byte 2,3,4
	.byte 5,5,5,5		
	.byte 6,7,8,9		
	.byte 10,15,16
	.byte 17,18,19,20,21,22,23,24,25,26,27,28,29,30 ; diss cont	
	.byte 31,32,33,34,35,36	
			
kTiles .block
	back = 0
	
	wall = 1
	wall1 = 2
;	wall2 = 3
;	wall3 = 4	
	wall4 = 5
	
	spike = 6
	flower = 7
	fruit = 8
	
	key1 = 9	
	key2 = 10
	key3 = 11
	key4 = 12
	
	shield = 13
	spring = 14
	potion = 15
	egg = 16
	
	exit = 17
	player = 18
	
	pipe = 19
	diss = 20
	dissNoColide = 33
	
	underHangStart = 34
	underHang = 35
	shadowOpenCorner = 36
	sideShadow = 37
	middlesideShadow = 38
	topLeftCorner = 39
	intermissionOldWall = 37; 40 37 is the looked up value
.bend
kDoorClosed = 10
kDoorOpen = 14

kKeyToWallDelta = kTiles.key1 - kTiles.wall1
; }}}
; {{{
plotTileMap
		sei
		stx Pointer1.lo
		sty Pointer1.hi
		stz kVERA.CTRL
		lda #`kVRAM.gameScreen | kVERA.inc_1
		sta kVERA.ADDR_Hi
		lda #kDoorClosed
		sta LevelData.exitFrame
		lda # <kVRAM.gameScreen
		sta Pointer2
		lda # >kVRAM.gameScreen
		sta Pointer2+1
		lda #kTileYCount ; num rows
		pha
_pltY	ldy #00 ; num cols
		tya
		pha
_pltX	lda (Pointer1),y ; tile num
		tax
		lda toolToTileLUT,x ; convert map to actual tile
		jsr renderTile		
		clc
		lda Pointer2.lo
		adc #4
		sta Pointer2.lo
		bcc +
			inc Pointer2.hi
	+	pla
		clc
		adc #1
		pha
		tay
		cpy #kTileXCount
		bne _pltX
		pla
		clc
		lda Pointer1.lo
		adc #kTileXCount
		sta Pointer1.lo
		lda Pointer1.hi
		adc #00
		sta Pointer1.hi
		pla
		sec
		sbc #1
		beq _exit
		pha
		clc
		lda Pointer2.lo
		; so we are at the end of the first line so +32
		; we need to get to the start of the line 2 below
		; so we need to move to the next line, 64 wide * 2
		; so + 128, however the screen is 40 visible not 32
		; so we need to add * more chars * 2 so + 16
		; but then the screen is not 40 wide its 64 wide
		; so we need to also add the extra stride which is
		; 128-80 (64-40*2)
		adc #128+16+128-80 ;48
		sta Pointer2.lo
		bcc +
			inc Pointer2.hi
+		gra _pltY
_exit	
	cli
	rts

; a = tile num, Pointer2 = Screen, Pointer 3 = CRAM
renderTile 
		sta Pointer4
		lda Pointer2.lo
		sta kVERA.ADDR_Lo
		lda Pointer2.hi
		sta kVERA.ADDR_Mid ; set the start
		 
		stz Pointer4+1
		asl Pointer4 
		rol Pointer4+1 
		asl Pointer4	 ; tile num x 4
		rol Pointer4+1 
		; covert to tiles offset	
		clc 
		lda Pointer4
		adc # <fileTiles
		sta Pointer4
		lda Pointer4+1
		adc # >fileTiles
		sta Pointer4+1
		lda (Pointer4)
		sta kVERA.DATA_0
		stz kVERA.DATA_0 ; the CRAM value
		ldy #1
		lda (Pointer4),y
		sta kVERA.DATA_0
		stz kVERA.DATA_0 ; the CRAM value
		iny 
		lda kVERA.ADDR_Lo
		clc
		adc #128-4 ; next line - 1 char
		sta kVERA.ADDR_Lo
		bcc +
			inc kVERA.ADDR_Mid
+
		lda (Pointer4),y
		sta kVERA.DATA_0
		stz kVERA.DATA_0 ; the CRAM value
		iny
		lda (Pointer4),y
		sta kVERA.DATA_0
		stz kVERA.DATA_0 ; the CRAM value
		rts
		
scanJoystick
		ldx #4
-		lda joyLeft,x
		sta oldJoyLeft,x
		lda #0
		sta joyLeft,x
		dex
		bpl -
		ldx #1
		lda JOY1
		lsr a 
		bcc _joyRight
			lsr a
			bcc _joyLeft
_checkUD
		lsr a
		bcc _joyDown
			lsr a
			bcc _joyUp
_checkFire		
		lsr a; start
		lsr a; select
		lsr a ; B
		bcc _joyB		
_checkA	
		lsr a ; A
		bcs _joyEnd
			stx joyFire
_joyEnd 
		lda oldJoyUp
		eor joyUp
		and joyUp
		sta joyUpStart
		lda joyUp
		eor OldJoyUp
		and OldJoyUp
		sta joyUpStop
		lda oldJoyFire
		eor joyFire
		and joyFire
		sta joyFireEvent
		rts
		
_joyUp	
		stx joyUp
		gcc _checkFire
_joyB
		stx joyUp
		gcc _checkA
		
_joyDown 
		stx joyDown
		lsr a ; skip up bit
		bra _checkFire
		
_joyLeft 
		stx joyLeft
		gcc _checkUD

_joyRight
		stx joyRight
		lsr a; skip left bit
		bra _checkUD
	

CollisionBoxesX .byte 02,02,02,04,00,$e8,12,04 ; $e8 = -24
CollisionBoxesW .byte 13,13,13,16,48, 48,01,16 
CollisionBoxesY .byte 02,02,00,04,00, 12,12,01 
CollisionBoxesH .byte 12,16,20,16,12, 30,01,08 


convertXSingleByteEntX	
	lda mplexBuffer.xpos,x
; this should not be needed on cx16
; one the 64 I got arround the 24-280, by using the fact the player 
; can only be on screen on the X and must be stopped at 256 visible pixels
; thus I could slide the 9 bits down to 8 to make life easier
; the cx16 doesn't have a side border so 0 is the first visible pixel
	rts
	
newCollision
	ldx CollideSpriteToCheck
	ldy CollideSpriteBoxIndex
	; calc the final Xs
	jsr convertXSingleByteEntX
	clc
	adc CollisionBoxesX,y
	adc checkSpriteToCharData.xDeltaCheck
	sta CollideInternalSprTLX
	clc
	adc CollisionBoxesW,y
	sta CollideInternalSprBRX
	; calc the final Ys
	lda mplexBuffer.ypos,x
	clc
	adc CollisionBoxesY,y
	adc checkSpriteToCharData.yDeltaCheck
	jsr ClipY
	sta CollideInternalSprTLY
	clc
	adc CollisionBoxesH,y
	jsr ClipY
	sta CollideInternalSprBRY
	; calc the tile index
	ldx #1
-	lda CollideInternalSprTLX,x
	lsr a
	lsr a
	lsr a
	lsr a
	sta CollideInternalTTLX,x
	dex
	bpl -
	lda CollideInternalTTLX
	cmp CollideInternalTBRX ; make sure right has not wrapped and is not < left
	bcc +
		sta CollideInternalTBRX
+
	lda CollideInternalSprTLY
	and #$f0
	sta CollideInternalTTLY
	lda CollideInternalSprBRY
	and #$f0
	sta CollideInternalTBRY
	; covert the tile X,Y into a the index and pull Char
	lda CollideInternalTTLY
	ora CollideInternalTTLX
	sta CollideCharTLI
	tax
	lda tileMapTemp,x
	sta CollideCharTLC
	
	lda CollideInternalTTLY
	ora CollideInternalTBRX
	sta CollideCharTRI
	tax
	lda tileMapTemp,x
	sta CollideCharTRC
	
	lda CollideInternalTBRY
	ora CollideInternalTTLX
	sta CollideCharBLI
	tax
	lda tileMapTemp,x
	sta CollideCharBLC
	
	lda CollideInternalTBRY
	ora CollideInternalTBRX
	sta CollideCharBRI
	tax
	lda tileMapTemp,x
	sta CollideCharBRC
	rts
	
ClipY
	cmp #208
	bcs +
		rts ; 0 - 192 = safe 192-208 = shared 16 off screen
+	cmp #240
	bcc _bottomOfScreen
		; top of screen
		lda #193
		rts
_bottomOfScreen
	lda #208
	rts
	
checkSpriteToCharCollision
	lda checkSpriteToCharData.yDeltaCheck
	sta checkSpriteToCharData.yDeltaBackup
	lda checkSpriteToCharData.xDeltaCheck
	sta checkSpriteToCharData.xDeltaBackup
	stz checkSpriteToCharData.xDeltaCheck
	stz CollideSpriteToCheck
	stz CollideSpriteBoxIndex
	jsr CSTCCY
	lda CollideCharBLI
	sta ActiveTileIndex
	lda CollideCharBLC
	sta ActiveTile	
	jsr checkOnDissTile
	lda CollideCharBLI
	cmp CollideCharBRI
	beq _otherIsSame
		lda CollideCharBRI
		sta ActiveTileIndex
		lda CollideCharBRC
		sta ActiveTile	
		jsr checkOnDissTile
_otherIsSame	
	lda checkSpriteToCharData.xDeltaBackup
	sta checkSpriteToCharData.xDeltaCheck
	stz checkSpriteToCharData.yDeltaCheck
	jsr CSTCCX
	lda checkSpriteToCharData.yDeltaBackup
	sta checkSpriteToCharData.yDeltaCheck
	ldx CollideCharTLI
	lda CollideCharTLC
	jsr checkActionTile
	lda CollideCharTRI
	cmp CollideCharTLI
	beq _skipTR
		tax
		lda CollideCharTRC
		jsr checkActionTile
_skipTR	
	lda CollideCharBLI
	cmp CollideCharTLI
	beq _skipBL
		tax
		lda CollideCharBLC
		jsr checkActionTile
_skipBL	
	lda CollideCharBRI
	cmp CollideCharTRI
	beq _skipBR
		cmp CollideCharBLI
		beq _skipBR
			tax
			lda CollideCharBRC
			jsr checkActionTile
_skipBR 
	rts
	
CSTCCY
	ldx #0
	stx ZPTemp
	stx ZPTemp2
	stx ZPTemp3
	stx ZPTemp4
	ldy #0
	jsr newCollision
	lda CollideCharTLC
	jsr checkSolidTile
	rol ZPTemp
	lda CollideCharTRC
	jsr checkSolidTile
	rol ZPTemp2
	lda CollideCharBLC
	jsr checkSolidTile
	rol ZPTemp3
	lda CollideCharBRC
	jsr checkSolidTile
	rol ZPTemp4
	lda checkSpriteToCharData.yDeltaCheck
	bpl _checkDown
	; check up
	lda ZPTemp
	ora ZPTemp2
	beq _exit	
	; abort jump
	lda PlayerData.hitBubbleNum
	beq _startFall
		stz checkSpriteToCharData.yDeltaBackup
		rts
_startFall
	lda #1	
	sta PlayerData.isFalling	
	inc a ;  #2
	sta PlayerData.yDeltaAccum
	sta PlayerData.yDeltaAccum+1
	rts	
_onGround
	stz checkSpriteToCharData.yDeltaBackup
	jsr enterOnGround
	stz checkSpriteToCharData.yDeltaCheck
	bra _exit
_checkDown
	lda PlayerData.hitBubbleNum
	bne _exit
		lda ZPTemp3
		ora ZPTemp4
		bne _onGround
			ldx PlayerData.onGround
			stz PlayerData.onGround
			cpx #1
			beq _startFall
_exit 
	rts
	
CSTCCX
	ldx #0
	stx ZPTemp
	stx ZPTemp2
	stx ZPTemp3
	stx ZPTemp4
	ldy #0
	jsr newCollision
	lda CollideCharTLC
	jsr checkSolidTile
	rol ZPTemp
	lda CollideCharTRC
	jsr checkSolidTile
	rol ZPTemp2
	lda CollideCharBLC
	jsr checkSolidTile
	rol ZPTemp3
	lda CollideCharBRC
	jsr checkSolidTile
	rol ZPTemp4
	lda checkSpriteToCharData.xDeltaCheck
	beq _exit
	bpl _checkRight
		; left
		lda ZPtemp
		ora ZPtemp3
		beq _exit
_noX
	stz checkSpriteToCharData.xDeltaCheck
	bra _exit	
_checkRight
	lda ZPtemp2
	ora ZPtemp4
	bne _noX
_exit 
	rts
	

checkOnDissTile
	lda PlayerData.onGround
	bne _c
_exit	
	rts
	; get the tile below the player
_c	lda TickDowns.dissBlocks
	bne _exit
		lda ActiveTile
		cmp #kTiles.diss
		bcc _exit
			cmp #kTiles.dissNoColide
			bcs _exit
				lda #kTimers.dissBlocksValue
				sta TickDowns.dissBlocks
				ldx ActiveTileIndex
				inc tileMapTemp,x
				lda tileMapTemp,x
				cmp #kTiles.dissNoColide-1
				php
				jsr pltSingleTileNew
				plp
				bne _exit
CheckForShadowPlots
	ldx #1
	jsr _checkRemoveTile
	ldx #16
	jsr _checkRemoveTile
	ldx #17
;	jmp _checkRemoveTile	
_checkRemoveTile	
	stx ZPTemp	
	lda ActiveTileIndex
	pha
	clc
	adc ZPTemp
	cmp #kLevelSizeMax
	bcs _exit2
		sta ActiveTileIndex
		tay
		jsr tileIsSafeToChange
		bcc _exit2
			jsr clearTileNew
_exit2
	pla
	sta ActiveTileIndex
	rts
	
checkActionTile
	sta ActiveTile ; for later
	stx ActiveTileIndex ; for later
	ldy #0
-	cmp TileFuncLookup,y
	beq _found
		iny
		cpy # size(TileFuncLookup)
		bne -
		rts

_found
	lda TileFuncLUTHi,y
	pha
	lda TileFuncLUTLo,y
	pha
	rts
	
TileFuncLookup .byte kTiles.fruit,kTiles.flower,kTiles.key1,kTiles.key2,kTiles.key3,kTiles.key4,kTiles.spike,kTiles.spring,kTiles.potion,kTiles.shield,kTiles.exit,kTiles.egg	
TileFuncLUTLo .byte <fruitFunc-1 ,<flowerFunc-1,<keyFunc-1 ,<keyFunc-1 ,<keyFunc-1 ,<keyFunc-1 ,<spikeFunc-1,<springFunc-1,<potionFunc-1,<shildFunction-1,<exitFunc-1,<eggFunc-1
TileFuncLUTHi .byte >fruitFunc-1 ,>flowerFunc-1,>keyFunc-1 ,>keyFunc-1 ,>keyFunc-1 ,>keyFunc-1 ,>spikeFunc-1,>springFunc-1,>potionFunc-1,>shildFunction-1,>exitFunc-1,>eggFunc-1

fruitFunc
	jsr clearTileNew
	lda #kScoreIndex.Fruit
	jsr giveScore
	ldx #kSFX.collect
	jmp playSFX
	;rts ; above is now jmp 	
	
flowerFunc
	jsr clearTileNew
	lda #kScoreIndex.fruit
	jsr giveScore
	ldx #kSFX.flower
	jsr playSFX
	inc GameData.flowers
	lda GameData.flowers
	cmp #8
	bne _exit
		stz GameData.flowers
		jsr awardLife
_exit	
	jmp pltFlowers	

keyFunc
	jsr clearTileNew		; remove it
	lda #kScoreIndex.key
	jsr giveScore
	dec LevelData.numKeys
	lda ActiveTile				 
	jsr countTempMapTile	; do we have any more of these keys still
	bne _done				; yes
		lda ActiveTile
		sec
		sbc # kKeyToWallDelta
		jsr removeAllTilesOf
_done	
	lda LevelData.numKeys
	cmp #0
	beq _changeDoor
		ldx #kSFX.collect
		jmp playSFX
	; rts ; above is now jmp
_changeDoor
	lda #1
	sta GameData.exitOpen	
	tax ; ldx #kSFX.door ;=1
	jmp playSFX
	; rts ; above is now jmp	

spikeFunc	
	lda #1	
	sta PlayerData.dead 
	rts
	 
springFunc
	jsr clearTileNew
	ldx #kSFX.powerup
	jsr playSFX
	lda #1
	sta PlayerData.hasSpring
	sta PlayerData.canFloat
	rts
	
potionFunc
	jsr clearTileNew
	ldx #0	
	stx ActiveTileIndex	
_loop	
	lda tileMapTemp,x	
	cmp #kTiles.spike	
	bne _next	
		lda #kTiles.fruit	
		sta tileMapTemp,x
		jsr pltSingleTileNew	
_next	
	lda ActiveTileIndex	
	clc	
	adc #1	
	sta ActiveTileIndex
	tax
	cmp #kLevelSizeMax	
	bne _loop	
	ldx #kSFX.powerup
	jmp playSFX
	;rts ; above is now jmp
	
shildFunction
	jsr clearTileNew
	lda #1
	sta PlayerData.hasShield
	ldx #kSFX.powerup
	jsr playSFX
	.comment
	; to end the sheid I use a the CIA timers in tandom to get about 10 seconds
	; I could have also used the TOD, but the VIA don't have 'combine both timers' 
	; nor a TOD so this won't work.. it needs to be converted to a 16 bit frame counter 
	; in the main loop.. but its to flash the sprite so not worth it in this example
	lda # <endShieldNMI
	sta $FFFA
	lda # >endShieldNMI
	sta $FFFB
	lda #$FF	
	sta $DD04		
	;lda #$FF	
	sta $DD05		
	lda #$97 ; about 10 seconds 	
	sta $DD06		
	lda #0
	sta $DD07
	lda #$82	; make it fire an NMI on Timer B underflow
	sta $DD0D	
	lda $DD0D   ; ack any NMI
	lda #$91
	sta $DD0E	
	lda #%01011001
	sta $DD0F	
	.endc 
;	lda #14
;	sta mplexBuffer.sprc
	lda #50
	sta TickDowns.shieldFlashTimerSpeedUp
	lda #16
	sta PlayerData.baseFlashTimeDelta
	rts		
.comment
endShieldNMI	
	pha
	jsr clearSheildState
	pla
	rti ; if this is added back in somehow on an NMI, you need to change this as cx16 goes via kernal
.endc	
	
clearSheildState
	lda # <justRTI ; yeah this doesn't work on the CX16
	sta $FFFA
	lda # >justRTI
	sta $FFFB	
	lda #0
	sta PlayerData.hasShield
	sta $DD0D
;	lda #7
;	sta mplexBuffer.sprc
	lda $DD0D	
	rts
justRTI	
	rti	
	
exitFunc	
	lda GameData.exitOpen
	beq _notOpen
		stz GameData.exitOpen
		lda ActiveTileIndex
		sta PlayerData.exitAtIndex
		lda #kPlayerState.exit
		sta PlayerData.state
		sta PlayerData.minorState
_notOpen
	rts

eggFunc
	jsr clearTileNew
	inc PlayerData.bulletEgg
	ldx #kSFX.powerup
	gra playSFX
	;rts ; above is now jmp

awardLife
	lda PasswordInfiLives
	beq +
	rts
+	inc GameData.lives
	jmp pltLives
	
animateDoor
	lda GameData.exitOpen
	beq aDexit
	lda TickDowns.doorAnim
	bne aDexit
	lda #kTimers.DoorAnimeRate
	sta TickDowns.doorAnim
	lda LevelData.exitIndex
	sta ActiveTileIndex
	jsr animateInternal
	lda LevelData.exitIndex+1
	cmp #$ff
	beq aDexit
	sta ActiveTileIndex
	gne animateInternal
aDexit 
	rts	
		
animateInternal
	lda LevelData.exitFrame
animateDoorCmp 
	cmp #kDoorOpen
	beq aDexit
animateDoorCLC
	clc
	adc #1
	sta LevelData.exitFrame
	gra pltSingleTileNoLookupNew ; skips below
	
setAnimateDoorToOpen
	lda #kDoorClosed
	sta LevelData.exitFrame
	lda #kDoorOpen
	sta animateDoorCmp+1
	lda #$18 ; CLC
	sta animateDoorCLC
	lda #$69 ; ADC #
	sta animateDoorCLC+1
	rts
	
setAnimateDoorToClose
	lda #kDoorOpen
	sta LevelData.exitFrame
	lda #kDoorClosed
	sta animateDoorCmp+1
	lda #$38 ; SEC
	sta animateDoorCLC
	lda #$E9 ; SBC #
	sta animateDoorCLC+1
	rts
	
playSFX
	bit GameData.musicMode
	bvc audioExit
	lda SNDTBL.hi,x
	tay
	lda SNDTBL.lo,x
	ldx #14;7;14
	;lda #<effect        ;Start address of sound effect data
    ;ldy #>effect
    ;ldx #channel        ;0, 7 or 14 for channels 1-3
   ; jmp SID+6
audioExit
	rts
	
playMusic
	rts
	;bit GameData.musicMode
	;bpl audioExit
	;jmp SID
	
countTempMapTile
	ldx # kLevelSizeMax-1
	ldy #0
_loop
	cmp tileMapTemp,x
	bne _skip
	iny
_skip
	dex
	cpx #$ff
	bne _loop
	tya
	rts
	
clearTileNew
	ldy ActiveTileIndex
	lda # kTiles.back
	sta tileMapTemp,y
	jsr calcBCDEforTileY ; this sets it to be what it should be shadow wise
	jsr pltSingleTileNew
	ldy ActiveTileIndex
	lda tileMapTemp,y
pltSingleTileNew
	tax
	lda toolToTileLUT,x
pltSingleTileNoLookupNew
	pha
	sei
	lda ActiveTileIndex 
	jsr convertIndexToScreenAndCRAM
	lda #`kVRAM.gameScreen | kVERA.inc_1
	sta kVERA.ADDR_Hi
	pla
	jsr renderTile
	cli
	rts
	
removeAllTilesOf
	sta ZPTemp5
	ldx #0
	stx ActiveTileIndex
	stx TestingSprX1
_loop
	lda tileMapTemp,x
	cmp ZPTemp5
	bne _next
		jsr clearTileNew
		jsr CheckForShadowPlots
_next	
	inc TestingSprX1
	ldx TestingSprX1
	stx ActiveTileIndex
	cpx # kLevelSizeMax
	bne _loop
	rts	

giveScore
	asl a
	asl a
	asl a
	ora #5
	tay
	ldx #5
	clc 
_scLoop
	lda GameData.score,x	
	adc FruitScore,y	
	sta GameData.score,x	
	cmp #10
	bcc _ok
		;sec
		sbc #10
		sta GameData.score,x
		sec ; add 1 more next time
_ok 
	dey
	dex 
	bpl _scLoop 
	jmp pltScore	 
	
kScoreIndex .block	
	fruit = 0	
	flower = 1	
	key = 2 
	boss = 3
.bend	
	
FruitScore	.byte 0,0,0,1,0,0,15,15
FlowerScore .byte 0,0,0,5,0,0,15,15
KeyScore	.byte 0,0,0,2,5,0,15,15
BossScore	.byte 0,1,0,0,0,0,15,15

convertIndexToScreenAndCRAM
	; screen is 64 wide and 2 per char so we want to time y * 128 
	; 2 lines per tile so y*256
	sta TempX
	and #$F0 ; get y Part
	lsr a
	lsr a
	lsr a
	lsr a ; >> 4 to get y into the lower half
	;clc
	adc #>kVRAM.gameScreen 
	sta Pointer2.hi ; * 256
	lda TempX
	and #$0F ; x = x * 2 and 2 per char so *4
	asl a
	asl a
	;clc
	adc #<kVRAM.gameScreen 
	sta Pointer2.lo
	rts
	
; returns Y into ZPTemp
convertIndexToEntSpriteXY	
	sta ZPTemp3
	and #$f0
	sta mplexBuffer.ypos+kEntsSpriteOffset,x
	sta ZPTemp
	lda ZPTemp3
	and #$0f
	asl a
	asl a
	asl a
	asl a
	stz mplexBuffer.xmsb+kEntsSpriteOffset,x ; to be sure sure
	sta mplexBuffer.xpos+kEntsSpriteOffset,x
	rts
	
; carry set = not safe, clear = safe
checkSolidTile
	ldx GameData.exitOpen
	bne _skipDoorCheck
		cmp # kTiles.exit
		beq _notSafe
_skipDoorCheck
	cmp # kTiles.pipe
	beq _notSafe
		cmp # kTiles.dissNoColide
		beq _exitSafe
		cmp # kTiles.diss
			bcs _checkNotShadow
				cmp # kTiles.wall
				bcc _exitSafe
					cmp # kTiles.spike
					bcs _exitSafe
_notsafe
	sec
	rts
_exitSafe
	clc
	rts
_checkNotShadow
	cmp #kTiles.dissNoColide
	bcc _notsafe
	bra _exitSafe
	
plotStatusArea
	sei
	#appendVeraAddress kVRAM.gameScreen+(32*2)|kVERA.inc_1
	stz ZPTemp
_loop
	ldx ZPTemp
	lda statusLines,x
	asl a
	asl a
	asl a
	tax
	ldy #0
_lineLoop	
	lda statusLine0,x
	sta kVERA.DATA_0
	stz kVERA.DATA_0
	inx
	iny
	cpy #8
	bcc _lineLoop
	clc
	lda kVERA.ADDR_Lo
	adc #128-16
	sta kVERA.ADDR_Lo
	bcc +
		inc kVERA.ADDR_Mid
+	lda ZPTemp
	clc
	adc #1
	cmp #24
	bcs _done
		sta ZPTemp
		bra _loop
_done
	cli
	jsr pltScore
	jsr pltHighScore
	jsr pltLives
	jmp pltFlowers
	
pltScore
	sei
	#appendVeraAddress getGameScreenCharPos(33,9)|kVERA.inc_1
	ldx #0
_l	lda GameData.score,x
	ora #240
	sta kVERA.DATA_0 ;kVectors.charBase + 33 + (40*9),x
	stz kVERA.DATA_0; $d800 + 33 + (40*9),x
	inx
	cpx #6
	bne _l
	cli
	rts
	
pltHighScore
	sei
	#appendVeraAddress getGameScreenCharPos(33,13)|kVERA.inc_1
	ldx #0
_l	lda GameData.high,x
	ora #240
	sta kVERA.DATA_0 ;kVectors.charBase + 33 + (40*13),x
	stz kVERA.DATA_0 ;$d800 + 33 + (40*13),x
	inx
	cpx #6
	bne _l
	cli
	rts
	
pltLives
	sei
	#appendVeraAddress getGameScreenCharPos(37,17)|kVERA.inc_1
	lda GameData.lives
	ora #240
	cmp #250
	bcc _safe
		lda #249
_safe
	sta kVERA.DATA_0 ; kVectors.charBase + 37 + (40*17)
	stz kVERA.DATA_0 ;$d800 + 37 + (40*17)
	cli
	rts
		
pltFlowers
	sei
	#appendVeraAddress getGameScreenCharPos(37,21)|kVERA.inc_1
	lda GameData.flowers
	ora #240
	sta kVERA.DATA_0 ;kVectors.charBase + 37 + (40*21)
	stz kVERA.DATA_0 ;$d800 + 37 + (40*21)
	cli
	rts
	
setPlayerToSpawnPoint
	lda LevelData.playerIndex
setPlayerToIndexA	
	pha
		asl a
		asl a
		asl a
		asl a
		sta mplexBuffer.xpos
		stz mplexBuffer.xmsb
	pla
	and #$F0
	sta mplexBuffer.ypos
	lda #kSprites.bulletSprite
	jsr SetBulletSpriteFromFrame
	lda #255
	sta mplexBuffer.ypos+kBulletSpriteOffset
	rts

	
resetPlayerData
	stz PlayerData.dead ; probably could just inline this tbf
	rts
	
updateTickdowns
	ldx #TICK_DOWN_END - TICK_DOWN_START-1
_l	lda TickDowns,x
	beq _next
	dec TickDowns,x
_next
	dex
	bpl _l
	rts

; NumEnts followed by XXXXYYYY TTTT--DD
; X x tile
; Y y tile
; T type
; D initial direction
;}}}
.send sSUBS
; ----- @Entity Funcs@ -----
.dsection sEntity
.section sEntity
; {{{
unpackEntityBytes
	ldy #0
	tya
	ldx #kEntity.maxEntities
-	sta EntityData.animBase,x
	sta EntityData.animFrame,x
	sta EntityData.entState,x
	dex
	bpl -
	lda (EntityDataPointer),y
	sta ZPTemp2 ; number of entities
	sta EntityData.number
	beq _e
		iny			; next byte
		ldx #0
		sta EntNum
	_l  
		lda (EntityDataPointer),y
		jsr convertIndexToEntSpriteXY
		iny			; next byte	
		lda (EntityDataPointer),y
		lsr a
		lsr a
		lsr a
		lsr a
		sta EntityData.type,x
		cmp #kEntity.Bear
		bne +
			gra _BossBear
	+	cmp #kEntity.Octopuss
		bne +
			jmp _BossOctopuss	
	+	lda ZPTemp
		sta EntityData.originalY,x
		stz EntityData.entState,x
		stz EntityData.speed,x
		lda (EntityDataPointer),y
		and #3
		sta EntityData.direction,x	
		lda #1	
		sta EntityData.active,x 
	_nextEnt
		iny 		; next byte
		inx
		dec ZPTemp2
		lda ZPTemp2
		bne _l
_e	
	ldx EntityData.number ; keep number
	stx EntityData.pipeBubbleStart
	lda EntityData.numPipes
	beq _noPipes
	.cerror kEntity.maxNumBubblesPerMaker != 2, "need to change code so it handles new mul"
	asl a ; times two
	clc ; probably not needed as num pipes must be below 128
	adc EntityData.number
	sta EntityData.number ; add the bubble ents
_setupBubbleLoop
	lda #kEntity.bubble
	sta EntityData.type,x
	stz EntityData.entState,x
	stz EntityData.direction,x
	stz EntityData.active,x
	inx
	cpx EntityData.number
	bne _setupBubbleLoop
_noPipes
	rts
_BossBear	
	lda #kEntity.bear
	sta EntityData.type,x
	lda #kEntity.bearBody
	sta EntityData.type+1,x
	lda #kEntity.bossDummy
	sta EntityData.type+2,x
	sta EntityData.type+3,x
	lda #kBoss.hitPoints
	sta EntityData.active,x
_sharedBoss
	lda #kEntity.bossDummy
	sta EntityData.type+2,x
	sta EntityData.type+3,x
	lda EntityData.number
	clc
	adc #3 ; insert 3 more ents for the rest of the boss
	sta EntityData.number
	lda #1
	sta EntityData.active+1,x
	sta EntityData.active+2,x
	sta EntityData.active+3,x
	txa
	sta EntityData.entState+1,x
	sta EntityData.entState+2,x
	sta EntityData.entState+3,x
	lda mplexBuffer.xmsb+kEntsSpriteOffset,x
	sta mplexBuffer.xmsb+kEntsSpriteOffset+1,x
	sta mplexBuffer.xmsb+kEntsSpriteOffset+2,x
	sta mplexBuffer.xmsb+kEntsSpriteOffset+3,x
	lda mplexBuffer.ypos+kEntsSpriteOffset,x
	sec
	sbc #9
	sta mplexBuffer.ypos+kEntsSpriteOffset,x
	sta mplexBuffer.ypos+kEntsSpriteOffset+1,x
	clc
	adc #21
	sta mplexBuffer.ypos+kEntsSpriteOffset+2,x
	sta mplexBuffer.ypos+kEntsSpriteOffset+3,x
	lda mplexBuffer.xpos+kEntsSpriteOffset,x
	sec
	sbc #8
	sta mplexBuffer.xpos+kEntsSpriteOffset,x
	sta mplexBuffer.xpos+kEntsSpriteOffset+2,x
	clc
	adc #24
	sta mplexBuffer.xpos+kEntsSpriteOffset+1,x
	sta mplexBuffer.xpos+kEntsSpriteOffset+3,x
	stz EntityData.entState,x
	stz EntityData.speed,x
	lda (EntityDataPointer),y
	and #3
	sta EntityData.direction,x	
	lda #25
	sta EntityData.movTimer,x
	sta EntityData.movTimer+1,x
	inx
	inx
	inx
	; x is now + 3 so when nextEnt is called it will be +4	
	jmp _nextEnt
_BossOctopuss	
	lda #kEntity.octopuss
	sta EntityData.type,x
	lda #kEntity.octopussBody
	sta EntityData.type+1,x
	lda #kBoss.hitPointsOctopuss
	sta EntityData.active,x
	jmp _sharedBoss	
		
setEntitySprites
	ldx EntityData.number
	beq _exit
_active
	stx CurrentEntity
	lda EntityData.type,x
	cmp #kEntity.bear
	beq _bossBear
		cmp #kEntity.bearBody
		beq _nextEnt
			cmp #kEntity.octopuss
			beq _bossOctopuss
				cmp #kEntity.octopussBody
				beq _nextEnt
	tay
;	lda EntitySpriteColours,y
	;sta mplexBuffer.sprc+kEntsSpriteOffset,x
	jsr setEntSpriteForDirection
_nextEnt
	dex
	bpl _active
_exit
	lda EntityData.numPipes
	beq _exit2
		ldx EntityData.pipeBubbleStart
		lda #$ff
_loop	
	sta mplexBuffer.ypos+kEntsSpriteOffset,x
	inx
	cpx #kEntity.maxEntities
	bne _loop
_exit2
	rts
	
_bossBear
	jsr setBossToCorrectColour
	lda #kSprBase+96
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	inx
	lda #kSprBase+99
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	inx
	lda #kSprBase+102
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	inx 
	lda #kSprBase+104
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	dex
	dex
	dex
	bne _nextEnt
	
_bossOctopuss
	jsr setBossToCorrectColour
	lda #kSprBase+106
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	inx
	lda #kSprBase+109
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	inx
	lda #kSprBase+112
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	inx 
	lda #kSprBase+114
	sta EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	dex
	dex
	dex
	bne _nextEnt
	
setBossToCorrectColour
	lda EntityData.type,x
	tay
	;lda EntitySpriteColours,y
setBossSpriteToColour	
	;sta mplexBuffer.sprc+kEntsSpriteOffset,x ; not worth the effort for this
	;sta mplexBuffer.sprc+kEntsSpriteOffset+1,x
	;sta mplexBuffer.sprc+kEntsSpriteOffset+2,x
	;sta mplexBuffer.sprc+kEntsSpriteOffset+3,x
	rts
	
deactivateAllEntities	
	ldx #kEntity.maxEntities-1	
-	stz EntityData.active,x	
	dex
	bpl -
	rts
		

; build hte collision data for each ent first
BuildEntCollisionTable
	ldx # kEntity.maxEntities-1
innerEntitiesLoopColl
	lda EntityData.active,x
	beq updateEntitiesLoopColl
	jsr MakeMinMaxXYForX	
updateEntitiesLoopColl
	dex
	bpl innerEntitiesLoopColl
	rts
	

addYDeltaEnt
	ldx CurrentEntity	
	lda mplexBuffer.ypos+kEntsSpriteOffset,x	
	clc	
	adc checkSpriteToCharData.yDeltaCheck	
	sta mplexBuffer.ypos+kEntsSpriteOffset,x
	rts
	
updateEntities
	ldx #kEntity.maxEntities-1
innerEntitiesLoop
	lda EntityData.active,x
	bne EntitiesActive
	lda EntityData.entState,x
	bpl updateEntitiesLoop
	dec EntityData.movTimer,x
	lda EntityData.movTimer,x
	bne updateEntitiesLoop
	lda EntityData.originalY,x
	sta mplexBuffer.yPos+kEntsSpriteOffset,x
	stz EntityData.entState,x
	lda #1
	sta EntityData.active,x
updateEntitiesLoop
	dex
	bpl innerEntitiesLoop
	rts
EntitiesActive
	stx CurrentEntity
	lda EntityData.type,x
	tay	
	.mCallFunctionTable EntUpdateFuncLUT,y		
EntUpdateFuncLUT .mMakeFunctionTable entNormalMovement,springEntFunc,EntNormalMovement,entBat,entGhostFunc,entSpiderFunc,entFishFunc,circlerFunc,entBoss,entBoss,nextEnt,nextEnt,entBubble,nextEnt

entNormalMovement	
+	jsr updateEntAnimAndSetSprite
	lda CollFrameForEnt,y	
	sta CollideSpriteBoxIndex	
	.mConvertXToEntSpriteX
	stx CollideSpriteToCheck
	lda #<handleEntCollisionResult
	sta Pointer1
	lda #>handleEntCollisionResult
	sta Pointer1+1
	ldx CurrentEntity
	lda EntityData.speed,x
	tay
	lda EntityData.direction,x	
	tax
	stz CollisionResult
	.mCallFunctionTable ENTDirectionCheckFuncLUT,x
ENTDirectionCheckFuncLUT .mMakeFunctionTable entRight,entUp,entLeft,entDown
	
entPositiveTBL   .byte 002,004
entPositiveTBLUD .byte 001,002
entNegativeTBL   .byte 254,252
entNegativeTBLUD .byte 255,254

entRight	
	lda entPositiveTBL,y	
	sta checkSpriteToCharData.xDeltaCheck
	lda #0
	sta checkSpriteToCharData.yDeltaCheck
entRightNoDelta
	jsr newCollision
	lda CollideCharTRC
	jsr checkSolidTile
	rol CollisionResult
	lda CollideCharBRC
	jsr checkSolidTile
	rol CollisionResult
	jmp (Pointer1)
	
entUp	
	stz checkSpriteToCharData.xDeltaCheck
	lda entNegativeTBLUD,y
	sta checkSpriteToCharData.yDeltaCheck	
entUpNoDelta
	jsr newCollision
	lda CollideCharTLC
	jsr checkSolidTile
	rol CollisionResult
	lda CollideCharTRC
	jsr checkSolidTile
	rol CollisionResult
	jmp (Pointer1)
	
entLeft	
	lda entNegativeTBL,y	
	sta checkSpriteToCharData.xDeltaCheck
	lda #0
	sta checkSpriteToCharData.yDeltaCheck
entLeftNoDelta
	jsr newCollision
	lda CollideCharTLC
	jsr checkSolidTile
	rol CollisionResult
	lda CollideCharBLC
	jsr checkSolidTile
	rol CollisionResult
	jmp (Pointer1)
	
entDown	
	stz checkSpriteToCharData.xDeltaCheck
	lda entPositiveTBLUD,y
	sta checkSpriteToCharData.yDeltaCheck
entDownNoDelta
	jsr newCollision
	lda CollideCharBLC
	jsr checkSolidTile
	rol CollisionResult
	lda CollideCharBRC
	jsr checkSolidTile
	rol CollisionResult
	jmp (Pointer1)	

entFishFunc
	dec EntityData.movTimer,x
	lda EntityData.movTimer,x
	bmi _next
		and #1
		bne _exit
		lda EntityData.entState,x
		beq _exit	
			bra _keepGoing
_exit	
	jmp NextEnt
_next
	lda #4
	sta EntityData.movTimer,x
_moveFish	
	lda EntityData.entState,x
	clc
	adc #1
	cmp #kSinJumpMax
	bne _storeDirect
		lda #kSinJumpMax-1
_storeDirect
	sta EntityData.entState,x
_keepGoing
	tay
	lda mplexBuffer.ypos+kEntsSpriteOffset,x
	clc
	adc SinJumpTable,y
	cmp #kFishLimits.maxY
	bcc _store
		stz EntityData.entState,x
		lda #32
		sta EntityData.movTimer,x
		lda #kFishLimits.maxY
_store
	sta mplexBuffer.ypos+kEntsSpriteOffset,x
	lda EntityData.entState,x
	lsr a
	lsr a ; div 4
	cmp #8
	bcc _safe
		lda #7
_safe
	clc
	adc #kSprites.fish
	jsr SetEntSpriteFromFrame
	jmp nextEnt

entSpiderFunc	
	lda EntityData.entState,x	
	tay	
	.mCallFunctionTable SpiderEntFuncLUT,y
SpiderEntFuncLUT .mMakeFunctionTable spiderLookPlayer,spiderFall,spiderRise 
	
spiderLookPlayer
	ldx #0
	stx ZPTemp2
	jsr convertXSingleByteEntX
	sta ZPTemp
	ldx CurrentEntity
	.mConvertXToEntSpriteX
	jsr convertXSingleByteEntX
	sbc ZPTemp
	sta ZPTemp
	bcs _left
	cmp #kSpiderValues.rightStartWiggle
	bcc +
	lda #1
	sta ZPTemp2
	lda ZPTemp
	cmp #kSpiderValues.rightStartFall
	bcc +
	lda #1
	ldx CurrentEntity
	sta EntityData.entState,x
+	lda #kSprites.spiderRight
_storeSprite
	ldx CurrentEntity
	sta EntityData.animBase,x
	lda ZPTemp2
	beq _noAnim
	jsr updateEntAnimAndSetSprite
	jmp nextEnt
_noAnim	
	ldx CurrentEntity
	lda EntityData.animBase,x
	jsr SetEntSpriteFromFrame
	jmp nextEnt
_left
	cmp #kSpiderValues.leftStartWiggle
	bcs +
		lda #1
		sta ZPTemp2
		lda ZPTemp
		cmp #kSpiderValues.leftStartFall
		bcs +
		lda #1
		ldx CurrentEntity
		sta EntityData.entState,x
+	lda #kSprites.spiderLeft
	bra _storeSprite	
		
spiderFall	
	jsr updateEntAnimAndSetSprite
	;ldy #kEntity.spider
	lda CollFrameForEnt+kEntity.spider ;,y	
	sta CollideSpriteBoxIndex	
	ldx CurrentEntity	
	.mConvertXToEntSpriteX
	stx CollideSpriteToCheck
	stz checkSpriteToCharData.xDeltaCheck
	lda #kSpiderValues.yFallDelta
	sta checkSpriteToCharData.yDeltaCheck
	jsr newCollision
	lda CollideCharBLC
	jsr checkSolidTile
	bcc _noColide
	_collide
		lda #2
		ldx CurrentEntity
		sta EntityData.entState,x
		lda #kSpiderValues.pauseEndFallFrames
		sta EntityData.movTimer,x
		jmp nextEnt
_noColide
	ldx CurrentEntity
	lda mplexBuffer.ypos+kEntsSpriteOffset,x
	cmp #kBounds.screenMaxY-21
	bcs _collide
		jsr addYDeltaEnt
		jmp nextEnt
		
spiderRise	
	dec EntityData.movTimer,x
	lda EntityData.movTimer,x
	bpl +
	lda #kSpiderValues.riseDelayTime
	sta EntityData.movTimer,x
	lda mplexBuffer.ypos+kEntsSpriteOffset,x
	sec
	sbc #1
	sta mplexBuffer.ypos+kEntsSpriteOffset,x
	cmp EntityData.originalY,x
	bne +
		stz EntityData.entState,x
+	jmp nextEnt
		
circlerFunc
	lda EntityData.movTimer,x
	sec 
	sbc #1
	bmi _cirActive
	sta EntityData.movTimer,x
	jmp nextEnt
_cirActive
	lda #4
	sta EntityData.movTimer,x
	lda EntityData.entState,x
	ldy CurrentEntity
	tax
	lda CircleJumpTableStart,x
	sta checkSpriteToCharData.xDeltaCheck
	; add X with MSB offset
	lda mplexBuffer.xpos+kEntsSpriteOffset,y
	clc
	adc checkSpriteToCharData.xDeltaCheck
	sta ZPTemp
	; xdelta +ve if this is +ve but original was -ve we have gone over
	lda checkSpriteToCharData.xDeltaCheck
	bmi _subbedX
		lda mplexBuffer.xpos+kEntsSpriteOffset,y
		bpl _loadX 
			; so last pos in negative >80
			lda ZPTemp
			bmi _storeX
			; new pos is positive 0-80
				lda #1			; enable MSB
				sta mplexBuffer.xmsb+kEntsSpriteOffset,y
				bra _storeX
_subbedX
	; xdelta -ve if this is -ve but original was +ve we have gone over
	lda mplexBuffer.xpos+kEntsSpriteOffset,y
	bmi _loadX
		; last post is positive >80
		lda ZPTemp
		bpl _storeX		
			lda #0		
			sta mplexBuffer.xmsb+kEntsSpriteOffset,y ; clear msb
_loadX
_storeX	
	lda ZPTemp	
	sta mplexBuffer.xpos+kEntsSpriteOffset,y	

	lda mplexBuffer.ypos+kEntsSpriteOffset,y
	clc
	adc CircleJumpTableStart + ( CircleJumpTableCount / 4) + 1,x
	sta mplexBuffer.ypos+kEntsSpriteOffset,y
	ldx CurrentEntity
	lda EntityData.entState,x
	clc
	adc #1
	cmp # CircleJumpTableCount
	bne _cirStore
	lda #0
_cirStore
	sta EntityData.entState,x
	jsr updateEntAnimAndSetSprite
	jmp nextEnt		
			
springEntFunc
	lda EntityData.movTimer,x
	sec 
	sbc #1
	bmi _move
	sta EntityData.movTimer,x
	jmp nextEnt
_move
	lda #3
	sta EntityData.movTimer,x		
	; update Y component	
	lda EntityData.entState,x	
	sta ZPTemp
	tay	
	lda SinJumpTable,y	
	sta checkSpriteToCharData.yDeltaCheck	
	stz checkSpriteToCharData.xDeltaCheck	
	stz CollisionResult	
	lda #2 ; this might change per frame	
	sta CollideSpriteBoxIndex	
	.mConvertXToEntSpriteX ; current entity
	stx CollideSpriteToCheck	
	lda #<springEntYCollideEnd
	sta Pointer1
	lda #>springEntYCollideEnd
	sta Pointer1+1
	lda ZPTemp
	cmp #kSinJumpFall
	bcs _falling
	; rising
	lda #kSinJumpFall ; start falling
	sta ZPTemp2
	jmp entUpNoDelta
_falling
	stz ZPTemp2
	jmp entDownNoDelta
springEntYCollideEnd
	lda CollisionResult
	bne _hit
		jsr collideEntAgainstRest
		bcs _hit
			; didn't hit so carry on
			ldx CurrentEntity
			lda mplexBuffer.ypos+kEntsSpriteOffset,x
			;clc
			adc checkSpriteToCharData.yDeltaCheck
			sta mplexBuffer.ypos+kEntsSpriteOffset,x
			lda EntityData.entState,x
			clc
			adc #1
			cmp #kSinJumpMax
			bcc _store
				lda #kSinJumpMax-1
_store
	sta EntityData.entState,x
	gra springEntHandleX
_hit
	ldx CurrentEntity
	lda ZPTemp2
	sta EntityData.entState,x
springEntHandleX
	stz checkSpriteToCharData.yDeltaCheck
	stz CollisionResult
	lda #<springEntXCollideEnd
	sta Pointer1
	lda #>springEntXCollideEnd
	sta Pointer1+1
	lda EntityData.direction,x
	sta ZPTemp
	clc
	adc #4
	tay
	lda SpringDirectionToDeltaLUT,y
	sta checkSpriteToCharData.xDeltaCheck
	bmi _left
	jmp entRightNoDelta
_left 
	jmp entLeftNoDelta	
springEntXCollideEnd		
	ldx CurrentEntity		
	lda ZPTemp	
	bmi springEntXLeft
	lda CollisionResult		
	beq _noCollideRight		
_hit	
	lda #256-1		
	ldx CurrentEntity	
	sta EntityData.direction,x 		 
	bra springEndAnimate
_noCollideRight
	jsr collideEntAgainstRest
	bcs _hit
	ldx CurrentEntity
	.mConvertXToEntSpriteX
	jsr addXWithMSBAndClip
	.mRestoreEntSpriteX
	lda DidClipX
	beq _noclip
		lda #256-1
		bmi _store
_noclip
	lda EntityData.direction,x 	
	clc
	adc #1
	and #3
_store
	sta EntityData.direction,x	
	gra springEndAnimate		
springEntXLeft	
	lda CollisionResult		
	beq _noCollideLeft		
_hit		
	lda #1		
	ldx CurrentEntity
	sta EntityData.direction,x 		 
	gra springEndAnimate
_noCollideLeft
	jsr collideEntAgainstRest
	bcs _hit
	ldx CurrentEntity
	.mConvertXToEntSpriteX
	jsr addXWithMSBAndClip
	.mRestoreEntSpriteX
	lda DidClipX
	beq _noclip2
		lda #1
		bra _store2
_noClip2	
	lda EntityData.direction,x 	
	sec
	sbc #1
	cmp #256-5
	bne _store2
		inc a  ;256-4	
_store2	
	sta EntityData.direction,x
springEndAnimate
	ldx CurrentEntity
	lda EntityData.entState,x
	tay
	cmp #kSinJumpFall
	bcs _fall
		lda SpringFrameFrameTable,y
		jsr SetEntSpriteFromFrame
		jmp nextEnt
_fall
	lda #kSprites.springFall
	sta EntityData.animBase,x
	jsr updateEntAnimAndSetSprite
	jmp nextEnt

entGhostFunc
	lda #<entGhostXResults
	sta Pointer1
	lda #>entGhostXResults
	sta Pointer1+1
	.mConvertXToEntSpriteX
	stx CollideSpriteToCheck
	ldx CurrentEntity
	lda EntityData.speed,x
	tay
	lda EntityData.direction,x
	cmp #4
	bcc +
	lda #0
	sta EntityData.direction,x
	; 0 00= UpRight	
	; 1 01= UpLeft	
+	and #1
	beq ghostLeft
; ghostRight
	jmp entRight
ghostLeft
	jmp entLeft
entGhostXResults
	ldx CurrentEntity
	lda CollisionResult	
	beq _addXDelta
_toggleX
	ldx CurrentEntity	
	lda EntityData.ignoreColl,x	
	bne _ignoreCollision	
		ora #1	
		sta EntityData.ignoreColl,x	
_toggleXForce
	ldx CurrentEntity
	lda EntityData.direction,x
	eor #1
	sta EntityData.direction,x
	jsr setEntSpriteForDirection
	gra entGhostCheckY
_addXDelta
	jsr collideEntAgainstRest
	bcs _togglex	
		ldx CurrentEntity
		lda EntityData.ignoreColl,x	
		and #$fe ; clear bit 0
		sta EntityData.ignoreColl,x
_ignoreCollision
	.mConvertXToEntSpriteX
	jsr addXWithMSBAndClip
	lda DidClipX
	bne _toggleXForce
entGhostCheckY
	lda #<entGhostYResults
	sta Pointer1
	lda #>entGhostYResults
	sta Pointer1+1
	ldx CurrentEntity
	lda EntityData.speed,x
	tay
	lda EntityData.direction,x
	and #2
; 2 10= DownRight	
; 3 11= DownLeft	
	bne _down	
	; up	
	gra entUp	
_down	
	gra entDown	
entGhostYResults
	ldx CurrentEntity
	lda CollisionResult	
	beq _entGhostCheckSprites
_toggleY
	ldx CurrentEntity	
	lda EntityData.ignoreColl,x	
	bne _ignoreCollision	
		ora #2	
		sta EntityData.ignoreColl,x	
		lda EntityData.direction,x
		eor #2
		sta EntityData.direction,x
_entHitAndGoNext	
	gra nextEnt
_entGhostCheckSprites	
	jsr collideEntAgainstRest
	bcs _toggleY	
		ldx CurrentEntity
		lda EntityData.ignoreColl,x		
		and #%11111101		
		sta EntityData.ignoreColl,x 		
_ignoreCollision
	jsr addYDeltaEnt
	jsr updateEntAnimAndSetSprite
	gra nextEnt	

entBat
	; we check to see if we can fall down
	lda CollFrameForEnt+kEntity.bat ; this might change per frame	
	sta CollideSpriteBoxIndex	
	.mConvertXToEntSpriteX ; current entity
	stx CollideSpriteToCheck	
	lda #<entBatYResults
	sta Pointer1
	lda #>entBatYResults
	sta Pointer1+1
	ldy #1 ; fall fast
	gra entDown
entBatYResults
	ldx CurrentEntity
	lda CollisionResult	
	bne _dontFall
	; yes update Y
	jsr addYDeltaEnt
_dontFall
	; jump to normal left right update
	jmp entNormalMovement
	
handleEntCollisionResult	
	ldx CurrentEntity	
	lda CollisionResult	
	beq _addDeltas
		bra _skipIgnore
		
_entHitAndGoNext
	ldx CurrentEntity
	lda EntityData.ignoreColl,x
 	bne _ignoreCollision
		lda #4
		sta EntityData.ignoreColl,x
_skipIgnore
	jsr setNextEntDir	
	gra nextEnt	
_addDeltas	
	jsr collideEntAgainstRest
	bcs _entHitAndGoNext
		ldx CurrentEntity
		lda EntityData.ignoreColl,x	
		beq _ignoreCollision	
			sec			; hasn't collided so clear flag
			sbc #1
			sta EntityData.ignoreColl,x	
_ignoreCollision
	jsr addYDeltaEnt ; will set X to current Ent	
	.mConvertXToEntSpriteX
	jsr addXWithMSBAndClip
	lda DidClipX
	beq _skipFlipDueToX
		lda mplexBuffer.xpos,x	; x was increased above
		sec	
		sbc checkSpriteToCharData.xDeltaCheck ; undo the move	
		sta mplexBuffer.xpos,x
		jsr setNextEntDir
_skipFlipDueToX	
nextEnt
	ldx CurrentEntity	
	jmp updateEntitiesLoop

entBubble 
	lda mplexBuffer.ypos+kEntsSpriteOffset,x
	sec
	sbc #1
	bne _safe
		stz EntityData.active,x
		lda #$FF ; disable sprite
_safe
	sta mplexBuffer.ypos+kEntsSpriteOffset,x
	jsr updateEntAnimAndSetSprite
	gra nextEnt ; for now	
		
setNextEntDir
	jsr getEntTableIndex
	lda NextDirectionLUT,y
	sta EntityData.direction,x
	ora ZPTemp ; add the ent type offset to it
	tay
	gra setEntFrameForDir
	
setEntSpriteForDirection
	jsr getEntTableIndex
	;jmp setEntFrameForDir
setEntFrameForDir
	lda BaseAnimeFrameForDir,y
	sta EntityData.animBase,x
	clc
	adc EntityData.animFrame,x
	gra SetEntSpriteFromFrame
	;rts
	
getEntTableIndex
	ldx CurrentEntity
	lda EntityData.type,x
	asl a
	asl a
	sta ZPTemp
	ora EntityData.direction,x
	tay
	rts
	
updateEntAnimAndSetSprite	
	lda EntityData.type,x	
	tay	
	inc EntityData.animTimer,x
	lda EntityData.animTimer,x
	cmp AnimFrameTimerForEnt,y
	bne SetEntSpriteFromFrame._notAnimUpdate ; rts
		stz EntityData.animTimer,x	
		inc EntityData.animFrame,x
		lda EntityData.animFrame,x
		cmp FrameCountForEnt,y
		bne _dontResetFrames
			lda #0
			sta EntityData.animFrame,x
	_dontResetFrames	
		clc	
		adc EntityData.animBase,x
SetEntSpriteFromFrame
	sta mplexBuffer.sprp+kEntsSpriteOffset,x ; this needs to be x16 | $800
	stz mplexBuffer.sprph+kEntsSpriteOffset,x 
	asl mplexBuffer.sprp+kEntsSpriteOffset,x ; x2
	rol mplexBuffer.sprph+kEntsSpriteOffset,x
	asl mplexBuffer.sprp+kEntsSpriteOffset,x ; x4
	rol mplexBuffer.sprph+kEntsSpriteOffset,x
	asl mplexBuffer.sprp+kEntsSpriteOffset,x ; x8
	rol mplexBuffer.sprph+kEntsSpriteOffset,x
	asl mplexBuffer.sprp+kEntsSpriteOffset,x ; x16
	rol mplexBuffer.sprph+kEntsSpriteOffset,x
	lda mplexBuffer.sprph+kEntsSpriteOffset,x
	ora #$08
	sta mplexBuffer.sprph+kEntsSpriteOffset,x
_notAnimUpdate 
	rts	
	

updateBubbles
	ldx EntityData.numPipes
	beq _exit
		lda TickDowns.bubbleTimer
		bne _exit
			ldx EntityData.pipeBubbleStart
_findFreeEnt
	lda EntityData.active,x
	beq _foundOne
		inx
		cpx EntityData.number
		bne _findFreeEnt
			bra _exit
_foundOne
	stx ZPTemp2 ; bubble ent number
	lda #1
	sta EntityData.active,x
	ldy EntityData.lastPipeUsed
	lda EntityData.pipeIndex,y
	jsr convertIndexToEntSpriteXY
	lda mplexBuffer.xpos+kEntsSpriteOffset,x
	sec
	sbc #4
	sta mplexBuffer.xpos+kEntsSpriteOffset,x
	bcs +
		lda #3
		sta mplexBuffer.xmsb+kEntsSpriteOffset,x
+	lda #kTimers.spawnBubble
	sta TickDowns.bubbleTimer
	lda EntityData.lastPipeUsed
	clc
	adc #1
	cmp EntityData.numPipes
	bne _store
		lda #0
_store
	sta EntityData.lastPipeUsed
_exit
	rts 

entBoss
	lda EntityData.entState,x
	tay
	.mCallFunctionTable BossLUT,y
BossLut .mMakeFunctionTable BossNormal,BossDeath

BossNormal
	lda EntityData.movTimer+1,x
	beq _notFlash
		dec EntityData.movTimer+1,x
		bne _notFlash
			jsr setBossToCorrectColour
_notFlash
	jsr AnimateUpperHalfBoss
	dec EntityData.movTimer,x
	beq _doneMove
		lda EntityData.movTimer,x
		cmp #16
		bcs _noMove
			jsr AnimateLowerHalfBoss
			lda EntityData.direction,x
			bne _left
				dec mplexBuffer.xpos+kEntsSpriteOffset,x
				dec mplexBuffer.xpos+kEntsSpriteOffset+2,x
				dec mplexBuffer.xpos+kEntsSpriteOffset+1,x
				dec mplexBuffer.xpos+kEntsSpriteOffset+3,x
				lda mplexBuffer.xpos+kEntsSpriteOffset,x
				; cmp #kBounds.screenMinX this is now 0
				.cerror kBounds.screenMinX != 0, "put cmp back"
				bne _noMove
				_toggleDir
					lda EntityData.direction,x
					eor #2 ; switch from 0 & 2
					sta EntityData.direction,x
					bra _noMove
	_left
		inc mplexBuffer.xpos+kEntsSpriteOffset,x
		inc mplexBuffer.xpos+kEntsSpriteOffset+2,x
		inc mplexBuffer.xpos+kEntsSpriteOffset+1,x
		inc mplexBuffer.xpos+kEntsSpriteOffset+3,x
		lda mplexBuffer.xpos+kEntsSpriteOffset+1,x
		cmp #$ff-24
		beq _toggleDir
			bra _noMove
_doneMove
	lda EntityData.type,x
	sec
	sbc #kEntity.bear
	tay
	lda BossMoveTimerLut,y
	sta EntityData.movTimer,x
_noMove
	jmp nextEnt

BossMoveTimerLut .byte 32,24	
	
BossDeath
	dec mplexBuffer.ypos+kEntsSpriteOffset,x
	dec mplexBuffer.ypos+kEntsSpriteOffset+1,x
	inc mplexBuffer.ypos+kEntsSpriteOffset+2,x
	inc mplexBuffer.ypos+kEntsSpriteOffset+3,x
	dec mplexBuffer.xpos+kEntsSpriteOffset,x
	dec mplexBuffer.xpos+kEntsSpriteOffset+2,x
	inc mplexBuffer.xpos+kEntsSpriteOffset+1,x
	inc mplexBuffer.xpos+kEntsSpriteOffset+3,x
	dec EntityData.movTimer,x
	bne _exit
		stz EntityData.active,x
		stz EntityData.active+1,x
		stz EntityData.active+2,x
		stz EntityData.active+3,x
		lda #$ff
		sta mplexBuffer.ypos+kEntsSpriteOffset,x
		sta mplexBuffer.ypos+kEntsSpriteOffset+1,x
		sta mplexBuffer.ypos+kEntsSpriteOffset+2,x
		sta mplexBuffer.ypos+kEntsSpriteOffset+3,x
_exit
	jmp nextEnt
	
AnimateLowerHalfBoss
	lda EntityData.animTimer,x
	beq _anim
		dec EntityData.animTimer,x
		rts
_anim
	lda EntityData.animFrame+2,x
	eor #1
	sta EntityData.animFrame+2,x
	sta ZPTemp
	lda EntityData.animBase+2,x
	clc
	adc ZPTemp
	inx
	inx
	jsr SetEntSpriteFromFrame 
	lda EntityData.animBase+1,x ; x has been increased by 2
	clc
	adc ZPTemp
	inx
	jsr SetEntSpriteFromFrame
	dex
	dex
	dex
	lda #4
	sta EntityData.animTimer,x
	rts

;<<<<<32--0--32>>>>>	
AnimateUpperHalfBoss
	stx ZPTemp
	.mConvertXToEntSpriteX
	jsr convertXSingleByteEntX
	sta ZPTemp2
	ldx #0 ; player
	jsr convertXSingleByteEntX
	sta ZPTemp3
	cmp ZPTemp2
	bcc _playerLeft
		sbc ZPTemp2 ; carry is already set
		cmp #32
		bcc _under
			lda #2
			.byte $2c ; bit XXXX
	_under
		lda #1
		.byte $2c
_playerLeft
	lda #0	
	sta ZPTemp4
	ldx ZPTemp
	sta EntityData.animFrame,x
	clc	
	adc EntityData.animBase,x	
	jsr SetEntSpriteFromFrame
	lda ZPTemp4	
	clc	
	adc EntityData.animBase+1,x	
	inx	
	jsr SetEntSpriteFromFrame	
	dex	
	rts
		
; }}}
.send sEntity
; ----- @Collision@ -----
.dsection sCollision
.section sCollision
; {{{
collideBulletAgainstRest
	ldy #3
	ldx #1
	bra collideAgainstRestEntry
collidePlayerAgainstRest
	ldx #0
	ldy #0
collideAgainstRestEntry
	lda mplexBuffer.ypos,x
	clc
	adc CollisionBoxesY,y
	sta Pointer3
	sta TestingSprY1
	clc
	adc CollisionBoxesH,y
	sta Pointer3+1
	sta TestingSprY2
	jsr convertXSingleByteEntX
	clc
	adc CollisionBoxesX,y
	sta TestingSprX1
	clc
	adc CollisionBoxesW,y
	sta TestingSprX2
	lda #$FF
	sta CurrentEntity ; so we don't skip any
	bra collideAgainstEntPlayerEntry
collideEntAgainstRest
	; start at the mplex y + 1 and check to see if the Y is in Range
	; to do this we need to know which collsiion box the ent we are is using
	; and the one that the other is using
	; a hit is if my x1 <= y2 && y1 <= x2
	; where x1 = my Ent Y, x2 = my Ent Y+Height 
	; y1 = Other Ent Y, y2 = other Ent Y+Height
	;dec $d020
	ldx CurrentEntity
	ldy #0
	lda EntityData.collisionX1,x
	clc
	adc checkSpriteToCharData.xDeltaCheck
	sta TestingSprX1 ; cache X
	lda EntityData.collisionX2,x
	clc
	adc checkSpriteToCharData.xDeltaCheck
	sta TestingSprX2
	lda EntityData.collisionY1,x
	clc
	adc checkSpriteToCharData.yDeltaCheck
	sta TestingSprY1
	lda EntityData.collisionY2,x
	clc
	adc checkSpriteToCharData.yDeltaCheck
	sta TestingSprY2
	;inc $d020
collideAgainstEntPlayerEntry
	;dec $d020
	ldy #2 ; other slot
	ldx #0
-	cpx CurrentEntity
	beq Ent_Ent_Coll_skipSelf
	lda EntityData.active,x
	beq Ent_Ent_Coll_skipSelf
	bmi Ent_Ent_Coll_skipSelf ; if there active is 0 or - don't collide
	stz ZPTemp	
	lda TestingSprY1
	cmp EntityData.collisionY2,x
	jsr doMinMaxBitTest
	lda EntityData.collisionY1,x
	cmp TestingSprY2
	jsr doMinMaxBitTest
	lda ZPTemp	
	and #3	
	beq hitY	
Ent_Ent_Coll_skipSelf	
	inx	
	cpx EntityData.number	
	bne -
	;inc $d020
	clc
	rts
	
hitY ; now we need to do the same thing but for the X	
	stz ZPTemp	
	lda TestingSprX1
	cmp EntityData.collisionX2,x
	jsr doMinMaxBitTest
	lda EntityData.collisionX1,x
	cmp TestingSprX2
	jsr doMinMaxBitTest
	lda ZPTemp
	and #3
	beq hitX
		bra Ent_Ent_Coll_skipSelf
hitX
	sec
	rts

MakeMinMaxXYForX
	lda EntityData.type,x
	tay
	lda CollFrameForEnt,y
	tay
	.mConvertXToEntSpriteX ; convert to all sprites not just ents
	jsr convertXSingleByteEntX
	.mRestoreEntSpriteX ; convert back
	clc
	adc CollisionBoxesX,y
	sta EntityData.collisionX1,x
	clc
	adc CollisionBoxesW,y
	sta EntityData.collisionX2,x
	lda mplexBuffer.ypos+kEntsSpriteOffset,x
	clc
	adc CollisionBoxesY,y
	sta EntityData.collisionY1,x
	clc
	adc CollisionBoxesH,y
	sta EntityData.collisionY2,x
	rts

doMinMaxBitTest
	beq _secPass		
	bcc _secPass		
		bcs _secFail		
_secPass
	clc					
_secFail
	rol ZPTemp			
	rts					
.send sCollision			
; }}}

plotStringAAtIndexXGameScreen
	stz psaaixCommon._cram+1
	bra psaaixCommon
plotStringAAtIndexX			
	ldy #1			
	sty psaaixCommon._cram+1			
psaaixCommon			
	stz kVERA.CTRL				
	lda TitleScreenData.stringPos.lo,x
	sta kVERA.ADDR_Lo
	lda TitleScreenData.stringPos.hi,x
	sta kVERA.ADDR_Mid
	lda TitleScreenData.stringPos.bank,x
	sta kVERA.ADDR_Hi
	ldy TitleScreenData.string,x
	lda StringTableLUTLo,y
	sta Pointer1.lo
	lda StringTableLUTHi,y
	sta Pointer1.hi
	ldy #0			
_l	lda (Pointer1),y			
	cmp #$ff				
	beq _done			
		sta kVERA.DATA_0			
	_cram 		
		lda #$01	; this needs to changed depending on the screen mode
		sta kVERA.DATA_0			
		iny			
		bne _l			
_done			
	rts		
	

	
; ----- @multiplexor@ -----
.dsection multiplexer
.section multiplexer
; {{{ 
setirq
	sei			 ;set interrupt disable
	lda #1
	sta kVERA.IEN ; enable vsync pulse
	lda #<IRQ
	sta $0314
	lda #>IRQ
	sta $0315
	cli
	rts
	
IRQ
	inc mplexZP.lsbtod
	lda kVERA.ISR
	sta kVERA.ISR
	
	jsr GETJOY
	; blast the Sprite data into VRAM
	stz kVERA.CTRL
	lda #<kVERA.SpriteAttributes+8 ; skip first due to cursor
	sta kVERA.ADDR_Lo
	lda #>kVERA.SpriteAttributes
	sta kVERA.ADDR_Mid
	lda #`kVERA.SpriteAttributes|kVERA.inc_1
	sta kVERA.ADDR_Hi
	
	ldx #0
-	lda mplexBuffer.sprp,x
	sta kVERA.DATA_0
	lda mplexBuffer.sprph,x
	sta kVERA.DATA_0
	lda mplexBuffer.xpos,x
	sta kVERA.DATA_0
	lda mplexBuffer.xmsb,x
	sta kVERA.DATA_0
	lda mplexBuffer.ypos,x
	sta kVERA.DATA_0
	stz kVERA.DATA_0 ; for y high to be 0, it just as fast as a load
	lda kVERA.DATA_0
	lda kVERA.DATA_0 ; skip next two bytes
	inx
	cpx #mplex.kMaxSpr-1
	bne - 
	ply
	plx
	pla
	rti

; }}}
.send multiplexer
; ----- @Sprite and Char@ -----
.dsection sSprChar
.section sSprChar
; {{{
setupBackDisolveFruitChars
		ldx LevelData.levelGraphicsSet
		lda BackCharsLUT.lo,x
		sta Pointer1.lo
		lda BackCharsLUT.hi,x
		sta Pointer1.hi
		; set up VERA DEST
		sei
			#appendVeraAddress kVRAM.gameChars|kVERA.inc_1
			; copy $680 bytes to VRAM
			ldx #5
			ldy #0	
		-	lda (Pointer1),y	
			sta kVERA.DATA_0	
			iny	
			bne -	
			inc Pointer1.hi
			dex 
			bpl -
		-	lda (Pointer1),y	
			sta kVERA.DATA_0		
			iny		
			cpy #$80		
			bne -		
		cli			
		rts

			
copyStuff	
	ldx #len(CopyDataFields.values)-1	
	stx ZPTemp	
	; use x to index and set up VRAM ports		
	stz kVERA.CTRL ; port 0		
_loopSet		
	ldx ZPTemp	
	lda CopyDataFields.dest.lo,x		
	sta kVERA.ADDR_Lo		
	lda CopyDataFields.dest.hi,x		
	sta kVERA.ADDR_Mid		
	lda CopyDataFields.dest.bank,x		
	sta kVERA.ADDR_Hi
	lda CopyDataFields.src.lo,x
	sta Pointer1.lo
	lda CopyDataFields.src.hi,x
	sta Pointer1.hi
	lda CopyDataFields.pages,x
	tax
	ldy #0
_loopPage
	lda (Pointer1),y
	sta kVERA.DATA_0
	iny
	bne _loopPage
	inc Pointer1.hi
	dex
	bne _loopPage
	dec ZPTemp
	bpl _loopSet
	rts
.cerror size(CopyDataFields.pages)-1	> 127, "need to change branch"
	


PlotTransitionScreenAndMakeNextChars			
		jsr ClearMapScreenToSolidBlack	
		; we need to copy in the current wall char
		sei
			#appendVeraAddress kVRAM.gameChars+(124*4*8) | kVERA.inc_1
			ldx LevelData.levelGraphicsSet
			lda WallCharLUT.lo,x
			sta Pointer1.lo
			lda WallCharLUT.hi,x
			sta Pointer1.hi
			ldy #0
		-	lda (Pointer1),y
			sta kVERA.DATA_0
			iny			
			cpy #(4*8*4) ; copy 4 chars
			bne -
		cli
		
		lda #kIntermission.firstExit	
		sta ActiveTileIndex	
		sta LevelData.playerIndex
		sta LevelData.exitIndex
		lda #kDoorOpen
		jsr pltSingleTileNoLookupNew	
		lda #kIntermission.secondExit	
		sta ActiveTileIndex	
		lda #kDoorClosed	
		jsr pltSingleTileNoLookupNew				
		ldx #(kTileXCount/2)-1	
_firstLoop	
		txa	
		pha	
		inc ActiveTileIndex
		lda #kTiles.intermissionOldWall
		jsr pltSingleTileNoLookupNew
		pla
		tax
		dex
		bpl _firstLoop				
					
		jsr incLevelGraphicSet				
		jsr setupBackDisolveFruitChars		
					
		ldx #(kTileXCount/2)-1	
_secondLoop	
		txa	
		pha	
		inc ActiveTileIndex
		lda #kTiles.wall
		jsr pltSingleTileNew
		pla
		tax
		dex
		bpl _secondLoop
		rts		
				
ClearMapScreenToSolidBlack			
	sei						
		#appendVeraAddress kVRAM.gameScreen | kVERA.inc_2
		ldx #kTileYCount*2-1	
_yloop			
		ldy #(kTileXCount*2)-1			
		lda #47			
_xloop			
		sta kVERA.DATA_0			
		dey					
		bpl _xloop					
		lda kVERA.ADDR_Lo				
		clc				
		adc #128-64			
		sta kVERA.ADDR_Lo				
		bcc + 				
			inc kVERA.ADDR_Mid				
	+	dex					
		bpl _yloop					
	cli					
	rts					

BackCharsLUT .block
	positions = (BackChars1,BackChars2,BackChars3,BackChars4)
	lo .byte <(positions)
	hi .byte >(positions)
.bend

; 0 = right, 1 = up, 2 = left, 3 = down
;DirectionXLUT	.byte 6,	24-12,	25,		24-12
;DirectionXLUT	.byte 8,	12,		24,	 	12
;DirectionYLUT	.byte 50-8,	50,		50-8,	50-16 ; raw sprite Y offsets
NextDirectionLUT
.byte 3,3,1,1 ; heli
.byte 0,0,0,0 ; spring
.byte 2,2,0,0 ; worm
.byte 2,2,0,0 ; bat
.byte 3,0,1,2 ; ghost
.byte 3,3,1,1 ; spider
.byte 0,0,0,0 ; fish - not used
.byte 0,0,0,0 ; flying thing - not used
BaseAnimeFrameForDir
.byte kSprBase+32,kSprBase+32,kSprBase+32,kSprBase+32 ; heli
.byte kSprBase+40,kSprBase+40,kSprBase+40,kSprBase+40 ; spring
.byte kSprBase+52,kSprBase+52,kSprBase+48,kSprBase+48 ; worm
.byte kSprBase+60,kSprBase+60,kSprBase+56,kSprBase+56 ; bat
.byte kSprBase+64,kSprBase+68,kSprBase+64,kSprBase+68 ; ghost
.byte kSprBase+72,kSprBase+72,kSprBase+72,kSprBase+72 ; spider
.byte kSprBase+80,kSprBase+80,kSprBase+84,kSprBase+84 ; fish 
.byte kSprBase+92,kSprBase+92,kSprBase+88,kSprBase+88 ; flying thing 
.byte 0,0,0,0 ; bear
.byte 0,0,0,0 ; other bear
.byte 0,0,0,0 ; octopus
.byte 0,0,0,0 ; other octopus
.byte kSprBase+124,kSprBase+124,kSprBase+124,kSprBase+124 ; bubble
FrameCountForEnt
.byte 008,004,004,004,004,002,004,004,002,002,002,002,003,000
CollFrameForEnt
.byte 000,000,000,000,000,000,000,000,004,004,005,005,007,006
;CollisionResultEORForEnt
;.byte 000,000,000,001,000,000,000,000,000,000,000,000,000,000
AnimFrameTimerForEnt
.byte 008,002,008,008,008,008,001,002,004,004,004,004,012,004
SpringDirectionToDeltaLUT
.char -2,-1,-1,-1,01,01,01,02 
SinJumpTable
.char -5, -5, -4, -4, -5, -3
.char -4, -3, -2, -3, -1, -2, -1, 0, -1, -1, 0 
kSinJumpFall = * - SinJumpTable 
.char  1,  2,  1,  3,  2,  3,  4  
.char  3,  5,  4,  5,  6,  5, 6,  6,  7, 8, 8 
kSinJumpMax = * - SinJumpTable - 1
SpringFrameFrameTable
.byte kSprites.springCompress,kSprites.springCompress,kSprites.springCompress
.byte kSprites.springNormal,kSprites.springNormal,kSprites.springNormal
.byte kSprites.springExpand,kSprites.springExpand,kSprites.springExpand
.byte kSprites.springFull,kSprites.springFull,kSprites.springFull
.byte kSprites.springFull,kSprites.springExpand,kSprites.springExpand,kSprites.springNormal,kSprites.springNormal

CircleJumpTableStart 
.char  5, 5, 5, 5, 4, 4, 4, 3, 2, 2, 1, 1, 0,-1,-1,-2,-2,-3,-4,-4,-4,-5,-5,-5,-5
.char -5,-5,-5,-4,-4,-4,-3,-3,-2,-1,-1, 0, 1, 1, 2, 3, 3, 4, 4, 4, 5, 5, 5
CircleJumpTableCount = * - CircleJumpTableStart	  
.char  5, 5, 5, 5, 4, 4, 4, 3, 2, 2, 1, 1, 0

statusLine0 .byte kSBC.TL,kSBC.T,kSBC.T,kSBC.T,kSBC.T,kSBC.T,kSBC.T,kSBC.TR	
statusLine1 .byte kSBC.L ,kSBC.M,kSBC.M,kSBC.M,kSBC.M,kSBC.M,kSBC.M,kSBC.R	
statusLine2 .byte kSBC.BL,kSBC.B,kSBC.B,kSBC.B,kSBC.B,kSBC.B,kSBC.B,kSBC.BR	
statusLine3 .byte kSBC.L ,kSBC.QWAKT,kSBC.QWAKT+1,kSBC.QWAKT+2,kSBC.QWAKT+3,kSBC.QWAKT+4,kSBC.QWAKT+5,kSBC.R	
statusLine4 .byte kSBC.L ,kSBC.QWAKB,kSBC.QWAKB+1,kSBC.QWAKB+2,kSBC.QWAKB+3,kSBC.QWAKB+4,kSBC.QWAKB+5,kSBC.R	
statusLine5 .byte kSBC.L ,kSBC.Score,kSBC.Score+1,kSBC.Score+2,kSBC.Score+3,kSBC.Score+4,kSBC.Score+5,kSBC.R
statusLine6 .byte kSBC.L ,kSBC.M,kSBC.High,kSBC.High+1,kSBC.High+2,kSBC.High,kSBC.M,kSBC.R
statusLine7 .byte kSBC.L ,kSBC.M,kSBC.QwakP,kSBC.QwakP+1,kSBC.M,kSBC.M,kSBC.M,kSBC.R	
statusLine8 .byte kSBC.L ,kSBC.M,kSBC.QwakP+2,kSBC.QwakP+3,kSBC.X,kSBC.M,kSBC.M,kSBC.R
statusLine9 .byte kSBC.L ,kSBC.M,kSBC.Flower,kSBC.Flower+1,kSBC.M,kSBC.M,kSBC.M,kSBC.R	
statusLine10 .byte kSBC.L ,kSBC.M,kSBC.Flower+2,kSBC.Flower+3,kSBC.X,kSBC.M,kSBC.M,kSBC.R
.comment
statusColour0 .byte kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col
statusColour1 .byte kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col
statusColour2 .byte kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col
statusColour3 .byte kSBC.Col,1,1,1,1,1,1,kSBC.Col
statusColour4 .byte kSBC.Col,3,3,3,3,3,3,kSBC.Col
statusColour5 .byte kSBC.Col,3,3,3,3,3,3,kSBC.Col
statusColour6 .byte kSBC.Col,kSBC.Col,3,3,3,3,kSBC.Col,kSBC.Col
statusColour7 .byte kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col
statusColour8 .byte kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,0,kSBC.Col,kSBC.Col,kSBC.Col
statusColour9 .byte kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col,kSBC.Col
statusColour10 .byte kSBC.Col,kSBC.Col,13,13,0,kSBC.Col,kSBC.Col,kSBC.Col
.endc
statusLines .byte 0,1,3,4,1,2,0,1,5,1,1,1,6,1,1,1,7,8,1,1,9,10,1,2	

; }}}
.send sSprChar

.dsection sPassword
.section sPassword
; ----- @password functions@ -----
loadPasswordTemp
	ldx #15
-	lda GameData,x
	sta PasswordTemp,x
	dex
	bpl -
	lda LevelData.levelGraphicsSet
	asl a
	asl a
	sta PasswordTemp.score+5 
	rts	

unloadPasswordTemp		
	ldx #15
-	lda PasswordTemp,x
	sta GameData,x
	dex	
	bpl -	
	lda PasswordTemp.score+5
	lsr a
	lsr a
	and #3
	sta LevelData.levelGraphicsSet 
	rts	

; carry set = fail	
validateExtractedPassword		
	ldx #5	
-	lda PasswordTemp.high,x
	cmp #10	
	bcs _fail	
	lda PasswordTemp.score,x	
	cmp #10	
	bcs _fail	
	dex	
	bpl -	
	lda PasswordTemp.lives	
	cmp #10	
_fail	
	rts	
		
makePassword
	ldx #11
	lda #0
-	sta ActivePassword,x
	dex
	bpl -
	tax
	stz ZPTemp ; score index
	stz ZPTemp2 ; password index
	stz ZPTemp3 ; password counter
	stz ZPTemp4 ; score counter
	;1st 5 bits SHVSH
	jsr pushOutScoreHiscorePair ; SH
	lsr PasswordTemp.currLevel
	rol ActivePassword				; V
	inc ZPTemp3					; count V
	jsr pushOutScoreHiscorePair ; SH
	;2nd 5 bits VSHVS
	lsr PasswordTemp.currLevel
	rol ActivePassword+1				; V
	inc ZPTemp3	
	jsr pushOutScoreHiscorePair ; SH
	lsr PasswordTemp.currLevel
	rol ActivePassword+1				; V
	inc ZPTemp3	
	jsr pushOutScoreHiscorePair ; S
	; 3rd 5 bits HVSHV
								; H
	lsr PasswordTemp.currLevel
	rol ActivePassword+2				; V
	inc ZPTemp3								
	jsr pushOutScoreHiscorePair ; SH						
	lsr PasswordTemp.currLevel
	rol ActivePassword+2				; V
	jsr nextPassword						
	; 4th 5 bits SHLSH						
	jsr pushOutScoreHiscorePair ; SH			
	lsr PasswordTemp.lives
	rol ActivePassword+3				; L
	inc ZPTemp3				
	jsr pushOutScoreHiscorePair ; SH			
	; 5th 5 bits LSHLS			
	lsr PasswordTemp.lives
	rol ActivePassword+4				; L
	inc ZPTemp3				
	jsr pushOutScoreHiscorePair ; SH			
	lsr PasswordTemp.lives
	rol ActivePassword+4				; L
	inc ZPTemp3				
	jsr pushOutScoreHiscorePair ; S
	; 6th 5 bits HLSHF
								; H			
	lsr PasswordTemp.lives
	rol ActivePassword+5				; L
	inc ZPTemp3				
	jsr pushOutScoreHiscorePair ; SH				
	lsr PasswordTemp.Flowers				
	rol ActivePassword+5				; F
	jsr nextPassword			
	; 7th 5 bits SHFSH				
	jsr pushOutScoreHiscorePair ; SH				
	lsr PasswordTemp.Flowers				
	rol ActivePassword+6				; F
	inc ZPTemp3					
	jsr pushOutScoreHiscorePair ; SH				
	; 8th 5 bits FSHSH
	lsr PasswordTemp.Flowers				
	rol ActivePassword+7				; F
	inc ZPTemp3		
	ldy #11	
-	jsr pushOutScoreHiscorePair ; SH
	dey 
	bpl -
	rts 				

extractPassword					
	ldx #3
	stx ZPTemp4 ; score counter									
	inx
	stx ZPTemp3 ; password counter								
	inx
	stx ZPTemp ; score index							
	ldy #11
	sty ZPTemp2 ; password index
-	jsr pullOutHiScoreScorePair ; SH
	dey 
	bpl -
	lsr ActivePassword+7				; F
	rol PasswordTemp.Flowers
	jsr prevPassword
	;
	jsr pullOutHiScoreScorePair ; SH
	lsr ActivePassword+6				; F
	rol PasswordTemp.Flowers
	dec ZPTemp3
	jsr pullOutHiScoreScorePair ; sh
	;
	lsr ActivePassword+5				; F
	rol PasswordTemp.Flowers
	dec ZPTemp3
	jsr pullOutHiScoreScorePair ; sh
	lsr ActivePassword+5
	rol PasswordTemp.Lives					; l
	dec ZPTemp3
	jsr pullOutHiScoreScorePair ; s
	;
								; h
	lsr ActivePassword+4
	rol PasswordTemp.Lives					; l
	dec ZPTemp3
	jsr pullOutHiScoreScorePair ; sh
	lsr ActivePassword+4
	rol PasswordTemp.Lives					; l
	jsr prevPassword
	;
	jsr pullOutHiScoreScorePair ; sh
	lsr ActivePassword+3
	rol PasswordTemp.Lives					; l
	dec ZPTemp3
	jsr pullOutHiScoreScorePair ; sh
	;
	lsr ActivePassword+2				; V
	rol PasswordTemp.currLevel
	dec ZPTemp3
	jsr pullOutHiScoreScorePair ; sh
	lsr ActivePassword+2				; V
	rol PasswordTemp.currLevel
	dec ZPTemp3
	jsr pullOutHiScoreScorePair ; s
	;
								; h					
	lsr ActivePassword+1				; V
	rol PasswordTemp.currLevel
	dec ZPTemp3					
	jsr pullOutHiScoreScorePair ;sh		
	lsr ActivePassword+1				; V
	rol PasswordTemp.currLevel
	jsr prevPassword		
	;		
	jsr pullOutHiScoreScorePair ;sh			
	lsr ActivePassword				; V
	rol PasswordTemp.currLevel
	dec ZPTemp3			
	gra pullOutHiScoreScorePair ;sh			
	;rts		
			
pushOutScoreHiscorePair		
	ldx ZPTemp
	lsr PasswordTemp.Score,x
	ldx ZPTemp2
	rol ActivePassword,x
	jsr nextPassword
	ldx ZPTemp
	lsr PasswordTemp.high,x
	ldx ZPTemp2
	rol ActivePassword,x
	jsr nextpassword
	bra nextScore
	
nextPassword
	inc ZPTemp3
	lda ZPTemp3
	cmp #5
	bne +
		stz ZPTemp3
		inc ZPTemp2
+	rts

nextScore
	inc ZPTemp4
	lda ZPTemp4
	cmp #4
	bne +
		stz ZPTemp4
		inc ZPTemp
+	rts

pullOutHiScoreScorePair
	ldx ZPTemp2
	lsr ActivePassword,x
	ldx ZPTemp
	rol PasswordTemp.high,x
	jsr prevPassword
	ldx ZPTemp2
	lsr ActivePassword,x
	ldx ZPTemp
	rol PasswordTemp.Score,x
	jsr prevPassword
	bra prevScore

prevPassword
	dec ZPTemp3
	bpl +
	lda #4
	sta ZPTemp3
	dec ZPTemp2
+	rts

prevScore
	dec ZPTemp4
	bpl +
	lda #3
	sta ZPTemp4
	dec ZPTemp
+	rts

convertToPasswordLetter
	beq _at
	cmp #22
	beq _zero
	clc
	adc #128
	cmp #0+128
	beq _exit
	clc
	adc #1 ; 1 = B
	cmp #2+128
	beq _exit
	clc
	adc #1 ; 2 = D
	cmp #11+128
	bcc _exit 
	clc
	adc #1 ; 9 = L
	cmp #17+128
	bcc _exit
	clc
	adc #1 ; 14 = R
	cmp #23+128
	bcc _exit
	clc
	adc #1 ; 19 = X
	cmp #27+128
	bcc _exit 
	clc
	adc #21 ; 22 = 0
_exit
	rts
_at
	lda #61+128
	rts
_zero
	lda #43+128
	rts
	
convertLetterToNumber
	sec
	sbc #128
	beq _exit ; @ case
		cmp #43 ; +
		beq _fake0
			cmp #61
			beq _fakeAt ; = case
				cmp #48
				bcc _notANum
					;sec branch make sec
					sbc #26 ; 0-9 convertion
_exit
	rts
	
_fake0
	lda #22
	rts
	
_fakeAt
	lda #0
	rts
	
_notANum
	sec
	sbc #1 ; B
	cmp #3
	bcc _exit
		;sec
		sbc #1 ; D
		cmp #9
		bcc _exit
			;sec
			sbc #1
			cmp #14
			bcc _exit
				;sec
				sbc #1
				cmp #19
				bcc _exit
					;sec branch makes sec
					sbc #1
					rts
	
convertASCIIToQwakChar
	cmp #43 ; +
	beq _number ; add 128
	cmp #61
	beq _number ; add 128
	cmp #64
	bcc _number
	adc #63
	rts
_number
	clc
	adc #128
	rts
	
isValidLetter
	cmp #43+128 ; +
	beq _yes
	cmp #61+128 ; =
	beq _yes
	cmp #49+128
	bcc _checkAZ
	cmp #58+128
	bcs _no
_yes 
	sec	
	rts	
_checkAZ	
	cmp #91+64	; {
	bcs _no	
	cmp #66+64	; <A
	bcc _no	
	cmp #75+64	; K
	beq _no	
	cmp #81+64	; Q
	beq _no	
	cmp #87+64	; W
	bne _yes	
_no	
	clc	
	rts	


.send sPassword	

VERADestStructLUT .block
	lo .byte <(VeraDESTAddressLUT)
	hi .byte >(VeraDESTAddressLUT)
	bank .byte `(VeraDESTAddressLUT)
.bend

setVERAAddressPort0_X
	stz kVERA.CTRL
	lda VERADestStructLUT.lo,x
	sta kVERA.ADDR_Lo
	lda VERADestStructLUT.hi,x
	sta kVERA.ADDR_Mid
	lda VERADestStructLUT.bank,x
	sta kVERA.ADDR_Hi
	rts

	
; ----- @TitleScreen Data@ -----
; {{{
.dsection sTitleScreenData
.section sTitleScreenData
TitleScreenData .block

SpriteStruct .block 
	sprites = [(getVeraSpriteAddress32x32(kSprites.Q), 99,10),
					(getVeraSpriteAddress32x32(kSprites.W),136,10),
					(getVeraSpriteAddress32x32(kSprites.A),171,10),
					(getVeraSpriteAddress32x32(kSprites.K),206,10)
				  ]
	ptr .block
		lo .byte <(sprites[:,0])
		hi .byte >(sprites[:,0])
	.bend
	x .block
		lo .byte <(sprites[:,1])
		hi .byte >(sprites[:,1])
	.bend
	y .byte (sprites[:,2])
.bend

Version = (kStrings.version,12,4)
Original = (kStrings.original,3,6)
Ported = (kStrings.cx16port,5,8)
Code = (kStrings.program,11,10)
Art = (kStrings.art,11,11)
Music = (kStrings.music,11,12)
Special = (kStrings.specialThanks,12,14)
Soci = (kStrings.soci,12,16)
Didi = (kStrings.martinPiper,15,17)
Saul1 = (kStrings.saul,17,11)
Saul2 = (kStrings.saul,17,12)
Both = (kStrings.both,7,22)
Music2 = (kStrings.music,15,22)
SFX = (kStrings.sfx,24,22)
None = (kStrings.none,30,22)
Password = (kStrings.password,5,19)
PasswordBlank = (kStrings.passwordBlank,14,20)

G1 = (Version,Original,Ported,Code)
G2 = (Art,Music,Special,Soci)
G3 = (Didi,Saul1,Saul2,Both)
G4 = (Music2,SFX,None,Password)
G5 = (PasswordBlank,) ;this use to have game over in it as well
AllStrings = G1 .. G2 .. G3 .. G4 .. G5

string .byte AllStrings[:,0]..(kStrings.gameOver,)
allPos = (kVRAM.titleScreen+(AllStrings[:,2]*128)+(AllStrings[:,1]*2)).. (kVRAM.gameScreen+8*128+11*2,)
stringPos .block 	
	lo .byte <(allPos)	
	hi .byte >(allPos)
	bank .byte `(allPos|kVERA.inc_1)
.bend	
	

	
spriteCol	.byte 7,13,14,10

menuOffsetsStart	.byte (30,23,15,7)*2
menuOffsetsEnd		.byte (37,30,22,14)*2

.bend ; titlescreendata

kStrings .block 
gameOver = 0
original = 1
cx16port = 2
program = 3
art = 4
music = 5
specialThanks = 6
soci = 7
martinPiper = 8
saul = 9
sfx = 10
none = 11
both = 12
version = 13
password = 14
passwordBlank = 15
.bend

StringTableLUTLo .byte <GAMEOVER,<ORIGINAL,<CX16PORT,<PROGRAM,<ART,<MUSIC,<SPECIALTHANKS,<SOCI,<MARTINPIPER,<SAUL,<SFX,<NONE,<BOTH,<VERSION,<PASSWORD,<PASSWORDBLANK
StringTableLUTHi .byte >GAMEOVER,>ORIGINAL,>CX16PORT,>PROGRAM,>ART,>MUSIC,>SPECIALTHANKS,>SOCI,>MARTINPIPER,>SAUL,>SFX,>NONE,>BOTH,>VERSION,>PASSWORD,>PASSWORDBLANK

GAMEOVER 		.text "GAME OVER"
		 			.byte $FF
ORIGINAL 		.text "ORIGINAL CONCEPT : JAMIE WOODHOUSE"		
					.byte $FF
CX16PORT  		.text "PORTED TO THE COMMANDER X16 BY"		
					.byte $FF		
PROGRAM	 		.text "CODE  : OZIPHANTOM"		
					.byte $FF		
ART		 		.text "ART"		
					.byte $FF		
SAUL				.text ": SAUL CROSS"		
					.byte $FF		
MUSIC 	 		.text "MUSIC"		
					.byte $FF		
SFX				.text "SFX"		
					.byte $FF		
NONE				.text "NONE"		
					.byte $FF		
BOTH				.text "BOTH"		
					.byte $FF		
SPECIALTHANKS 	.text "SPECIAL THANKS TO"		
					.byte $FF		
SOCI		  		.text "SOCI, MARTIN PIPER"		
					.byte $FF		
MARTINPIPER	  	.text "DIDI, THERYK"		
					.byte $FF			
VERSION			.text "CX 16 EDITION 1.3",$FF		
PASSWORD			.text "TYPE PASSWORD : SPACE TO CLEAR",$FF	
PASSWORDBLANK	.text "------------",$FF	
					
PASSWORD_LIVES 	.byte $88,$8f,$94,$8f,$90,$81,$81,$83,$92,$8f,$93,$93 ; hotopaacross						
PASSWORD_RED 		.byte $89,$93,$88,$8f,$8f,$94,$92,$85,$84,$81,$8c,$8c ; ishootredall
PASSWORD_SPRING	.byte $8d,$81,$99,$84,$81,$99,$8d,$81,$99,$84,$81,$99 ; maydaymayday 
PASSWORD_LEVEL  	.byte $93,$94,$85,$90,$90,$85,$84,$8f,$96,$85,$92,$81 ; steppedovera					
; }}}


BossLevels 		.byte 4,4+5,4+10,4+15,4+20,4+25

kSFX .block
flower = 0
door =1
collect = 2
bubble = 3
ebubble = 4
powerup = 5
jump = 6
hurt = 7
.bend
SNDTBL mMakeTable SND_FLOWER,SND_DOOR,SND_COLLECT,SND_BUBBLE,SND_EBUBBLE,SND_POWER_UP,SND_JUMP,SND_HURT
.send sTitleScreenData

.dsection sCharSprData
.section sCharSprData
.union
	.binary "back_shadow.ver"
	.struct
		BackChars1 .fill $680
		BackChars2 .fill $680
		BackChars3 .fill $680
		BackChars4 .fill $680
	.ends
.endu
WallCharLUT .block
	_offset = 16*4*8
	values = (BackChars1,BackChars2,BackChars3,BackChars4)+_offset
	lo .byte <(values)
	hi .byte >(values) 
.bend

LowerFixedChars .binary "fixed_section_chars.ver"
UpperFixedChars .binary "top_fixed_chars.ver"
fileTiles ;		
;.binary "tiledefs.raw",0,32*4
;.byte 84,85,86,87
linerTile4 .macro
    .byte \1*4+range(0,4)
.endm
#linerTile4 0 ; back
#linerTile4 4 ; wall
#linerTile4 14 ; spike
#linerTile4 17 ; flower
#linerTile4 12 ; fruit
#linerTile4 15 ; key
#linerTile4 18 ; shield
#linerTile4 19 ; spring
#linerTile4 20 ; potion
#linerTile4 21 ; egg
#linerTile4 16 ; exit
.byte 193,194,195,196 ; exit open frame 1
.byte 197,198,199,200 ; exit open frame 2
.byte 197,201,199,202 ; exit open frame 3
.byte 197,201,199,203 ; exit open frame 4
#linerTile4 16 ; ???
#linerTile4 13 ; bubble launcher 
#linerTile4 5 ; Diss start
.byte 20,21,24,25
.byte 20,21,26,27
.byte 20,21,28,29
.byte 20,21,30,31
.byte 20,21,32,33
.byte 20,21,14,15
.byte 34,35,14,15
.byte 36,37,14,15
.byte 38,39,14,15
.byte 40,41,14,15
.byte 42,43,14,15
.byte 44,45,14,15
.byte 12,13,14,15 ; DISS End
.byte 4,5,2,3 ; underhang start
.byte 7,5,2,3 ; underhang 
.byte 8,1,2,3 ; shadow open corner
.byte 9,1,11,3 ; side shadow
.byte 10,1,11,3 ; middlesideShadow
.byte 6,5,11,3 ; topLeftCorner
.byte 124,125,126,127 ; old wall for intermission 

fileFont ;
.binary "font.raw"
FILE_END 
.send sCharSprData
.enc "none"
spriteFileName .text "sprites.ver"
font4bpp .binary "font4bpp.ver"

CopyDataFields .block	
  src .block
    lo .byte <(values[:,0])
    hi .byte >(values[:,0])
  .bend
  dest .block
    lo   .byte <(values[:,1])
    hi   .byte >(values[:,1])
    bank .byte `(values[:,1] | kVERA.inc_1) ; set increment to 1
  .bend
  pages .byte (values[:,2])
.bend

.enc "qwak"

.dsection sLEVEL_TABLE
.section sLEVEL_TABLE
LevelTableLo	
.byte <fileTileMap,<Level02,<Level03,<Level04,<Level05,<Level06,<Level07,<Level08,<Level09,<Level10,<Level11,<Level12,<Level13,<Level14,<Level15,<Level16,<Level17,<Level18,<Level19,<Level20,<Level21,<Level22,<Level23,<Level24,<Level25,<Level26,<Level27,<Level28,<Level29,<Level30,<Level31	
LevelTableHi	
.byte >fileTileMap,>Level02,>Level03,>Level04,>Level05,>Level06,>Level07,>Level08,>Level09,>Level10,>Level11,>Level12,>Level13,>Level14,>Level15,>Level16,>Level17,>Level18,>Level19,>Level20,>Level21,>Level22,>Level23,>Level24,>Level25,>Level26,>Level27,>Level28,>Level29,>Level30,>Level31	
.send sLEVEL_TABLE	
	
.dsection sLEVEL_MAP
.section sLEVEL_MAP
fileTileMap
.binary "levels/01.bin"
Level02 .binary "levels/02.bin"
Level03 .binary "levels/03.bin"
Level04 .binary "levels/04.bin"
Level05 .binary "levels/04boss01.bin"
Level06 .binary "levels/05.bin"
Level07 .binary "levels/06.bin"
Level08 .binary "levels/07.bin"
Level09 .binary "levels/08.bin"
Level10 .binary "levels/08boss02.bin"
Level11 .binary "levels/09.bin"
Level12 .binary "levels/10.bin"
Level13 .binary "levels/11.bin"
Level14 .binary "levels/12.bin"
Level15 .binary "levels/12boss03.bin"
Level16 .binary "levels/13.bin"
Level17 .binary "levels/14.bin"
Level18 .binary "levels/15.bin"
Level19 .binary "levels/16.bin"
Level20 .binary "levels/16boss04.bin"
Level21 .binary "levels/17.bin"
Level22 .binary "levels/18.bin"
Level23 .binary "levels/19.bin"
Level24 .binary "levels/20.bin"
Level25 .binary "levels/20boss05.bin"
Level26 .binary "levels/21.bin"
Level27 .binary "levels/22.bin"
Level28 .binary "levels/23.bin"
Level29 .binary "levels/24.bin"
Level30 .binary "levels/24boss06.bin"
Level31 .binary "levels/end.bin"
.send sLEVEL_MAP
* = $a000
.dsection sAUDIO
.section sAUDIO
SID ;.binary "QWAK.sid",126
; SFX
SND_FLOWER	;	.binary "qwak_flower.snd"
SND_DOOR		;.binary "qwak_door.snd"
SND_COLLECT	;	.binary "qwak_collect.snd"
SND_BUBBLE	;	.binary "qwak_bubble.snd"
SND_EBUBBLE	;	.binary "enemy_bubble.snd"
SND_POWER_UP;	.binary "qwak_power_up.snd"
SND_JUMP		;.binary "qwak_jump.snd"
SND_HURT		;.binary "qwak_hurt.snd"
.send sAUDIO

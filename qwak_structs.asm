sGameData .struct 
lives .byte ?
flowers .byte ?
score .byte ?,?,?,?,?,?
high .byte ?,?,?,?,?,?
currLevel .byte ?
exitOpen .byte ?
musicMode .byte ?
.ends

sLevelData .struct
numKeys .byte ?
totalKeys .byte ?
playerIndex .byte ?
exitIndex .byte ?,?
exitFrame .byte ?
levelGraphicsSet .byte ?
.ends

sTimerTickDowns .struct
dissBlocks 	.byte ?
playerAnim 	.byte ?
doorAnim	.byte ?
bulletLifeTimer .byte ?
shieldFlashTimer .byte ?
shieldFlashTimerSpeedUp .byte ?
bubbleTimer .fill kEntity.maxBubbleMakers 
.ends

sPlayerData .struct
dead .byte ?
hasShield .byte ?
canFloat .byte ?
hasSpring .byte ?
onGround .byte ?
hasJumped .byte ?
isFalling .byte ?
floatTimer .byte ?
facingRight .byte ?
yDeltaAccum .word ?
baseSprite .byte ?
frameOffset .byte ?
frameCount .byte ?
frameTimer .byte ?
movingLR .byte ?
startedJumpLR .byte ?
slowMove	.byte ?
currAnim .byte ?
state .byte ?
minorState .byte ?
bulletActive .byte ?
bulletUD .byte ?
bulletLR .byte ?
bulletBurst .byte ?
bulletEgg	.byte ?
exitAtIndex .byte ?
hitBubbleNum .byte ?
forceJump .byte ?
baseFlashTimeDelta .byte ?
.ends

sEntityData .struct
number		.byte ?
type		.fill kEntity.maxEntities 
direction	.fill kEntity.maxEntities 
active		.fill kEntity.maxEntities 
movTimer	.fill kEntity.maxEntities 
animTimer	.fill kEntity.maxEntities 
animBase 	.fill kEntity.maxEntities
animFrame	.fill kEntity.maxEntities
originalY	.fill kEntity.maxEntities 
entState	.fill kEntity.maxEntities 
collisionX1 .fill kEntity.maxEntities
collisionX2 .fill kEntity.maxEntities
collisionY1 .fill kEntity.maxEntities
collisionY2 .fill kEntity.maxEntities
speed		.fill kEntity.maxEntities
ignoreColl	.fill kEntity.maxEntities
numPipes	.byte ?
pipeIndex 	.fill kEntity.maxBubbleMakers
lastPipeUsed .byte ?
pipeBubbleStart .byte ?
.ends

sCSTCCParams .struct	
xDeltaCheck .byte ? ; pixels
yDeltaCheck .byte ?  ; pixels
xDeltaBackup .byte ? ; pixels
yDeltaBackup .byte ? ; pixels
.ends

sMplexZP .struct
lsbtod .byte ?
.ends

sMplexBuffer .struct
sprp  .fill mplex.kMaxSpr+1		;sprite pointer frame buffer
sprph	.fill mplex.kMaxSpr+1		
xpos  .fill mplex.kMaxSpr+1		;sprite x position frame buffer
xmsb  .fill mplex.kMaxSpr+1		;sprite x msb frame buffer	
ypos  .fill mplex.kMaxSpr+1		;sprite y position frame buffer
;yposh .fill mplex.kMaxSpr+1
;sprc .fill mplex.kMaxSpr+1	;sprite color frame buffer
.ends

; here it doubled the byte that tells how many whitespace chars to show
; as left padding for a message, since now whitespace is only one byte
; there's no need to double it

.org 0x80038ea0
nop

; same as comment above, but for the byte that stores message length in chars
.org 0x80038ec4
nop

.org 0x80049af8
nop

; sets whitespace char size as 1 byte, originally as 2
.org 0x80038ed8
li		a2, 0x1

.org 0x80049b0c
li		a2, 0x1

; sets current char width as 2, originally as 4
.org 0x80053fc0
li		v0, 0x2

; incs current char x offset by 1, originally by 2
.org 0x80053ff8
sll		v0, s0, 0x1

; incs current text pointer by 1, originally by 2
.org 0x80054010
addiu	s2, s2, 0x1

; sets max chars per line as 32, originally as 16 (half-width, biatch!)
.org 0x80023c34
li		v0, 0x20

; don't do right padding with spaces when displaying location in map
.org 0x80047314
li		a2, 0x0

; hardcoded byte length of "Undgrd." location name in map, originally 4
.org 0x80047338
li		a2, 0x07

; hardcoded byte length of "Undgrd." location name in memcard save text, originally 4
.org 0x8004a128
li		a2, 0x07

; hardcoded byte length of hyphen, originally 2
.org 0x8004a140
li		a2, 0x01

; memcard save text is a mess
; format is file#: floor#-room name
; these pos are hardcoded

; hardcoded addr for file# in memcard text
.org 0x80049d34
la		a0, 0x8008BC80

.org 0x80049d4c
la		a0, 0x8008BC80

.org 0x80049d64
la		a0, 0x8008BC80

; hardcoded addr for floor# pos in memcard text
.org 0x8004a110
la		a0, 0x8008bc84

; hardcoded addr for hyphen pos in memcard text
.org 0x8004a12c
la		a0, 0x8008bc84

; call strncat for hyphen instead of strncpy
.org 0x8004a13c
jal		0x800546d8

; hardcoded addr for room name pos in memcard text
.org 0x8004a160
la		a0, 0x8008bc84

; call strncat for room name instead of strncpy
.org 0x8004a174
jal		0x800546d8

; Dead function at this adress, just about the right size for the whole font map
.org 0x80053960
.area 0x80053a68 - 0x80053960

FontMap:
	.include "src/font_map.asm"
		
.endarea

.org 0x80054138
.area 0x80054268 - 0x80054138

	jal		GetASCIICharTextureFromBios
	move	s0, a1
	move	t1, v0
	li		v0, -0x1
	bne		t1, v0, convert_to_16bpp_80054158
	move	t0, s0
	j		return_80054364
	li		v0, 0x1

convert_to_16bpp_80054158:
	move	t2, zero

mask_loop_8005415c:
	srl		a0, t2, 0x1f
	addu	a0, t2, a0
	sra		a0, a0, 0x1
	addiu	a0, a0, 0x1
	
	li		v1, 0
    li		a2, 7
    li		a3, 0

@entry_01:
    lbu		v0, 0x0(t1) 
    nop
    srlv	v0, v0, a2
    addiu	a2, -1
    andi	v0, v0, 0x1
    sllv	a1, a0, a3
    addiu	a3, 4
    mult	v0, a1
    mflo	v0
    addu	v1, v1, v0
    sh		v1, 0x0(t0)

    slti	v0, a3, 16
    bne		v0, 0, @entry_01     
    nop

    addiu	t0, t0, 0x2
    
    li		v1, 0
    li		a3, 0

@entry_02:
    lbu		v0, 0x0(t1) 
    nop
    srlv	v0, v0, a2
    addiu	a2, -1
    andi	v0, v0, 0x1
    sllv	a1, a0, a3
    addiu	a3, 4
    mult	v0, a1
    mflo	v0
    addu	v1, v1, v0
    sh		v1, 0x0(t0)

    slti	v0, a3, 16
    bne		v0, 0, @entry_02     
    nop

    addiu	t0, t0, 0x2

@next_line:
    addiu	t2, t2, 0x1 
    slti	v0, t2, 0x0F
    bne		v0, 0, mask_loop_8005415c
    addiu	t1, t1, 0x1
    clear	v0

return_80054364:
	lw		ra, 0x14(sp)
	lw		s0, 0x10(sp)
	addiu	sp, sp, 0x18
	jr		ra
	nop

GetASCIICharTextureFromBios:
	addiu	sp, sp, -0x18
    sw		ra, 0x10(sp)

    lbu		v0, 0x0(a0)
    nop
    andi	v0, 0x7F

    la		v1, FontMap
    nop
    sll		v0, 1
    addu	v0, v1

    lhu		v0, 0x0(v0)
    nop

    li		v1, 0xBFC70000
    or		v0,v1 

    lw		ra,0x10(sp)
    addiu	sp,sp,0x18
    jr		ra
    nop

.endarea

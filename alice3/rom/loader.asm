
; This is the loader. It is copies to RAM by the preloader (see rom.asm).
; It is responsible for loading the first few sectors of the disk and
; running them.

; Defines loader:
#include "loader_address.asm"

; The port we use to interact with the pic.
PICPORT EQU     0

; Where we load the boot sectors to.
BOOT    EQU     0100H

        org     loader

        ; Disable interrupts.
        di

        ; Set up the stack at the top of RAM.
        ld      sp, 0

        ; Display message.
        ld      hl, msg
        call    print

        ; Replace ROM with RAM.
        ld      hl, 0
        ld      (hl), 0

        ; Check that enabling RAM has worked.
        ld      b, 0
        ld      (hl), b
        ld      a, (hl)
        cp      b
        jp      nz, ramfail

        ld      b, 0FFH
        ld      (hl), b
        ld      a, (hl)
        cp      b
        jp      nz, ramfail

        ; Inform user that RAM succeeded.
        ld      hl, ramgoodmsg
        call    print

        ; Load boot sector 0 from disk.
        ld      a, 0            ; Disk 0
        ld      de, 0           ; Sector 0
        ld      bc, 0           ; Track 0
        ld      hl, BOOT        ; Buffer
        call    ldsector

        ; Load boot sector 1 from disk.
        inc     de
        call    ldsector

        ; Inform user that we are about to jump.
        ld      hl, jmpmsg
        call    print

        ; Jump to boot sector.
        jp      BOOT

        ; ------------------------------------------
        ; Load a sector from disk.
        ; A = disk number
        ; DE = sector number
        ; BC = track number
        ; HL = buffer address with 128 bytes. This register
        ;      is left one byte past the end of the buffer.
        ;
        ; Halts on error.
ldsector:
        push    af
        push    bc
        push    de
        push    iy

        push    hl
        ld      hl, loadingmsg
        call    print
        pop     hl

        ; Send command to load sector.
        push    bc
        ld      c, PICPORT

        push    af
        ld      a, 6
        out     (c), a          ; "Read sector with checksum"
        pop     af
        out     (c), a          ; Disk
        out     (c), e          ; Sector (LSB)
        out     (c), d          ; Sector (MSB)
        pop     de              ; Was "bc"
        out     (c), e          ; Track (LSB)
        out     (c), d          ; Track (MSB)

        ; Poll until we get a non-zero result.
        ld      de, 0
ldwait:
        inc     de
        ld      a, 0
        cp      d
        jp      nz, cont
        cp      e
        jp      nz, cont
        call    prprog
cont:
        in      a, (c)
        or      a
        jp      z, ldwait

        ; Check for failure (success = 1).
        ld      b, 1
        cp      b
        jp      nz, ldfail

        ; Load 128 bytes.
        ld      b, 128
        inir                        ; Read B bytes from port C into (HL)

        ; Read checksum into DE.
        in      e, (c)
        ld      a, e
        call    prbyte
        in      d, (c)
        ld      a, d
        call    prbyte
        call    preol

        ; Compute checksum of the sector we got into IY.
        ld      iy, 0

        ; Reset HL to start of buffer.
        ld      bc, 128
        scf
        ccf
        sbc     hl, bc

        ; Checksum loop.
        push    de
        ld      b, 128
        ld      d, 0
xsum:
        ld      e, (hl)
        ld      a, e
        call    prbyte
        add     iy, de
        inc     hl
        djnz    xsum
        pop     de
        call    preol

        ; Compare checksum.
        defb    0FDh, 07Dh      ; ld a, iyl
        call    prbyte
        cp      e
        jp      nz, xsum_fail
        defb    0FDh, 07Ch      ; ld a, iyh
        call    prbyte
        cp      d
        jp      nz, xsum_fail
        call    preol

        pop     iy
        pop     de
        pop     bc
        pop     af

        ret

xsum_fail: ld   hl, badxsummsg
        call    print
        halt

        ; ------------------------------------------
        ; Inform user that RAM failed and halt.
ramfail: ld      hl, rambadmsg
        call    print
        halt

        ; ------------------------------------------
        ; Inform user that sector load failed and halt.
        ; First print the contents of A.
ldfail: call    printa
        ld      hl, ldfailmsg
        call    print
        halt

        ; ------------------------------------------
        ; Print a nul-terminated string at HL.
print:  push    af
        push    hl

prtlp:  ld      a, (hl)
        or      a               ; See if it is a nul (\0).
        jp      z, prtend
        out     (128), a
        inc     hl
        jp      prtlp

prtend: pop     hl
        pop     af
        ret

        ; ------------------------------------------
        ; Print the value of A in hex, with a nice message
        ; and a newline.
printa: push    hl

        ; Text before.
        ld      hl, preprinta
        call    print

        ; Print A.
        call    prbyte

        ; Text after.
        call    preol

        pop     hl

        ret

        ; ------------------------------------------
        ; Print an 8-bit value (register A) in hex.
prbyte: push    af

        ; High nybble.
        srl     a
        srl     a
        srl     a
        srl     a
        call    prnyb
        pop     af

        ; Low nybble.
        call    prnyb

        ret

        ; ------------------------------------------
        ; Print a 4-bit value (register A) in hex. Ignores
        ; the top nybble of A.
prnyb:  push    hl
        push    de
        push    af

        ; Look up in hex table.
        and     0x0F
        ld      hl, bin2hex
        ld      d, 0
        ld      e, a
        add     hl, de
        ld      a, (hl)
        out     (128), a

        pop     af
        pop     de
        pop     hl

        ret

        ; ------------------------------------------
        ; Print a newline.

preol:
        push    hl
        ld      hl, eolmsg
        call    print
        pop     hl
        ret

        ; ------------------------------------------
        ; Print a progress dot.

prprog:
        push    hl
        ld      hl, progmsg
        call    print
        pop     hl
        ret

        ; ------------------------------------------
        ; Constants.

msg:    defm    'Alice 3 loader'
        defb    13,10,0

jmpmsg: defm    'About to jump to boot loader'
        defb    13,10,0

ramgoodmsg:
        defm    'RAM successfully swapped'
        defb    13,10,0

rambadmsg:
        defm    'RAM failed to swap'
        defb    13,10,0

loadingmsg:
        defm    'Loading sector...'
        defb    13,10,0

ldfailmsg:
        defm    'Sector load failed'
        defb    13,10,0

bin2hex:
        defm    '0123456789ABCDEF'

preprinta:
        defm    'Value of A register: '
        defb    0

eolmsg:
        defb    13,10,0

progmsg:
        defm    '.'
        defb    0

badxsummsg:
        defm    'Bad sector xsum.'
        defb    13,10,0

	end

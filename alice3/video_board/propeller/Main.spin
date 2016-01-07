' Main.spin
'
' The main code for the Alice 3 video board.
'
' Spins off some cogs to do the real work.

CON

  ' Multiply crystal input by 16 to get system clock. Our crystal is 5 MHz, so
  ' our system clock is 80 MHz, the maximum that the Propeller can handle.
  _clkmode = xtal1 + pll16x
  
  ' Specify our crystal frequency in Hz. This (multiplied by 16 for the PPLL) is
  ' stored in _clkfreq and RAM (address zero), not used by the hardware.
  _xinfreq = 5_000_000

  cols = vgatext#cols
  rows = vgatext#rows
  chrs = cols * rows
  queue_capacity = 512
  
  CLK_PIN = 5

OBJ
 
  vgatext : "VGA_driver"
  bus_interface : "Bus_interface"
  terminal : "Terminal"

VAR

  'sync long - written to -1 by VGA driver after each screen refresh
  long  sync
  'screen buffer - could be bytes, but longs allow more efficient scrolling
  long  screen[cols*rows/4]
  'row colors
  word  colors[rows]
  'cursor control bytes
  byte  cx0, cy0, cm0, cx1, cy1, cm1
  
  byte  queue[queue_capacity]
  long  queue_head
  long  queue_tail

PUB start | i, j, addr, data

  ' Start vga text driver.
  vgatext.start(8, @screen, @colors, @cx0, @sync)
  
  ' Start the terminal.
  queue_head := 0
  queue_tail := 0
  terminal.start(@queue, @queue_head, @queue_tail, queue_capacity, @screen, @cx0, @cy0)
  
  ' Start bus interface.
  bus_interface.start(@queue, @queue_head, @queue_tail, queue_capacity)

  ' Configure cursor shapes and blinking.
  cm0 := %011
  cm1 := %000
  cy0 := 0
  
  ' Set up colors.
  repeat i from 0 to rows - 1
    colors[i] := %%0100_1310

  ' Fill screen with spaces.
  repeat i from 0 to chrs - 1
    screen.byte[i] := 32
    
  ' Write welcome message.
  waitcnt(clkfreq*2 + cnt)
  queue[queue_tail] := "V"
  queue_tail += 1
  queue[queue_tail] := "G"
  queue_tail += 1
  queue[queue_tail] := "A"
  queue_tail += 1
  queue[queue_tail] := 13
  queue_tail += 1
  queue[queue_tail] := 10
  queue_tail += 1
  
  ' Start Z-80 clock.
  cognew(@z80clock, 0)

  if false ' Testing
    colors[0] := %%3000_3330
    colors[1] := %%0000_0300
    colors[2] := %%1100_3300
    colors[3] := %%0020_3330
    colors[4] := %%3130_0000
    colors[5] := %%3310_0000
    colors[6] := %%1330_0000
    colors[7] := %%0020_3300
    colors[rows-1] := %%1110_2220

    ' Fill screen with characters
    repeat i from 0 to chrs - 1
      screen.byte[i] := i // $100

    ' Advance cursor forever.
    repeat
      waitcnt(clkfreq + cnt)
      cx0 += 1
      if cx0 == 80
        cx0 := 0
        cy0 += 1
        if cy0 == 40
          cy0 := 0

DAT

                        org 0
                        
z80clock                ' We write the clock.
                        mov     dira, #|<CLK_PIN

:loop
                        mov     outa, #|<CLK_PIN
                        nop
                        nop
                        nop
                        nop
                        mov     outa, #0
                        nop
                        nop
                        nop
                        jmp     #:loop

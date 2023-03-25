PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

value = $0200 ; 2 bytes
mod10 = $0202 ; 2 bytes
message = $0204 ; 6 bytes

E  = %10000000 ; Enable
RW = %01000000 ; Read / Write
RS = %00100000 ; Register Select

  .org $8000

reset:
  ldx #$ff
  txs

  lda #%11111111 ; Set all pins on port B to output
  sta DDRB
  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA

  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction
  lda #%00001110 ; Display on; Cursor on; Blink off
  jsr lcd_instruction
  lda #%00000110 ; Increment and shift cursor; Don't shift display
  jsr lcd_instruction
  lda #%00000001 ; Clear LCD display
  jsr lcd_instruction

  lda #0
  sta message

  ; Initialize value to number to convert
  lda number
  sta value
  lda number + 1
  sta value + 1

divide:
  ; Initialize remainder to zero
  lda 0
  sta mod10
  sta mod10 + 1
  clc

  ldx #16
divloop:
  ; Rotate quotient and remainder
  rol value
  rol value + 1
  rol mod10
  rol mod10 + 1

  ; a,y = dividend - divisor
  sec
  lda mod10
  sbc #10
  tay ; save low byte in Y
  lda mod10 + 1
  sbc #0
  bcc ignore_result ; branch if dividend < divisor
  sty mod10
  sta mod10 + 1

ignore_result:
  dex
  bne divloop
  rol value ; shift in the last bit of the quotient
  rol value + 1

  lda mod10
  clc
  adc #"0"
  jsr push_char

  ; if value != 0, continue dividing
  lda value
  ora value + 1
  bne divide ; branch if value is not 0

  ldx #0
print:
  lda message,x
  beq loop
  jsr print_char
  inx
  jmp print

loop:
  jmp loop

number: .word 1729

; Add the char in A to the beggining of the null-terminated 'message'
push_char:
  pha ; push new first char onto stack
  ldy #0

char_loop:
  lda message,y ; Get char on string and push into X
  tax
  pla
  sta message,y ; Pull char off stack and add it to string
  iny
  txa
  pha           ; Push char from string onto stack
  bne char_loop

  pla
  sta message,y ; Pull the null off the stack and add it to string

  rts

lcd_wait:
  pha
  lda #%00000000 ; Set Port B to input
  sta DDRB
lcd_busy:
  lda #RW
  sta PORTA
  lda #(RW | E)
  sta PORTA
  lda PORTB
  and #%10000000
  bne lcd_busy  

  lda #RW
  sta PORTA
  lda #%11111111 ; Set Port B to output
  sta DDRB
  pla
  rts

lcd_instruction:
  jsr lcd_wait
  sta PORTB
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  lda #E         ; Set enable bit to send instruction
  sta PORTA
  lda #0         ; Clear RS/RW/E bits
  sta PORTA
  rts

print_char: 
  jsr lcd_wait
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA
  rts

  .org $fffc
  .word reset
  .word $0000

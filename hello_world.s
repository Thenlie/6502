PORTB = $6000
PORTA = $6001
DDRB = $6002
DDRA = $6003

E  = %10000000 ; Enable
RW = %01000000 ; Read / Write
RS = %00100000 ; Register Select

  .org $8000

reset:
  lda #%11111111 ; Set all pins on port B to output
  sta DDRB
  lda #%11100000 ; Set top 3 pins on port A to output
  sta DDRA
  lda #%00111000 ; Set 8-bit mode; 2-line display; 5x8 font
  sta PORTB

  lda #0         ; Clear RS/RW/E bits
  sta PORTA

  lda #E         ; Set enable bit to send instruction
  sta PORTA

  lda #0         ; Clear RS/RW/E bits
  sta PORTA

  lda #%00001110 ; Display on; Cursor on; Blink off
  sta PORTB

  lda #0         ; Clear RS/RW/E bits
  sta PORTA

  lda #E         ; Set enable bit to send instruction
  sta PORTA

  lda #0         ; Clear RS/RW/E bits
  sta PORTA

  lda #%00000110 ; Increment and shift cursor; Don't shift display
  sta PORTB

  lda #0         ; Clear RS/RW/E bits
  sta PORTA

  lda #E         ; Set enable bit to send instruction
  sta PORTA

  lda #0         ; Clear RS/RW/E bits
  sta PORTA

  lda #"H"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"e"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"l"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"l"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"o"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #","
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #" "
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"w"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"o"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"r"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"l"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"d"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

  lda #"!"
  sta PORTB
  lda #RS         ; Set RS bit; Clear RW/E
  sta PORTA
  lda #(RS | E)   ; Set E bit to send instruction 
  sta PORTA
  lda #RS         ; Clear E bit
  sta PORTA

loop:
  jmp loop

  .org $fffc
  .word reset
  .word $0000

; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point



; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 
	  
ROMStart    EQU  	$4000  ; absolute address to place my code/constant data
BIT5		equ		$20
; variable/data section

            ORG RAMStart
 ; Insert here your data definition.

; code section
            org     $1500
Entry:
_Startup:
            lds     #$1500
            bset    DDRT,BIT5   ; configure PT5 pin for output 
                       
Hz200       ldx     #125
run200      bset    PTT,BIT5    ; pull PT5 pin to high
            ldy     #50         ; wait for 0.2 ms
            jsr     Delay50us   
            bclr    PTT,BIT5    ; pull PT5 pin to low
            ldy     #50         ; wait for 0.2 ms
            jsr     Delay50us
            dbne    x,run200

Hz500       ldx     #250
run500      bset    PTT,BIT5    ; pull PT5 pin to high
            ldy     #20         ; wait for 0.1 ms
            jsr     Delay50us   
            bclr    PTT,BIT5    ; pull PT5 pin to low
            ldy     #20         ; wait for 0.1 ms
            jsr     Delay50us
            dbne    x,run500

Hz1000      ldx     #500
run1000     bset    PTT,BIT5    ; pull PT5 pin to high
            ldy     #10         ; wait for 0.5 ms
            jsr     Delay50us   
            bclr    PTT,BIT5    ; pull PT5 pin to low
            ldy     #10         ; wait for 0.5 ms
            jsr     Delay50us   
            dbne    x,run1000
            
            bra     Hz200

Delay50us   pshx
            ldx     #30     ; 2 E cycles
iloop       psha            ; 2 E cycles
            pula            ; 3 E cycles
            psha            ; 2 E cycles
            pula            ; 3 E cycles
            psha            ; 2 E cycles
            pula            ; 3 E cycles
            psha            ; 2 E cycles
            pula            ; 3 E cycles
            psha            ; 2 E cycles
            pula            ; 3 E cycles
            psha            ; 2 E cycles
            pula            ; 3 E cycles
            psha            ; 2 E cycles
            pula            ; 3 E cycles
            nop             ; 1 E cycle
            nop             ; 1 E cycle
            dbne    x,iloop
            pulx
            dbne    y,Delay50us
            rts

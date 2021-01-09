


; this is an example of out instruction.
; it writes values to virtual i/o port
; that controls the stepper-motor.
; c:\emu8086\devices\stepper_motor.exe is on port 7

#start=stepper_motor.exe#


name "stepper"

#make_bin#

steps_before_direction_change = 2h ; 1 (decimal)

jmp start

; ========= data ===============

; bin data for clock-wise
; half-step rotation:
datcw    db 0000_0110b
         db 0000_0100b
         db 0000_0011b
         db 0000_0010b

; bin data for counter-clock-wise
; half-step rotation:
datccw   db 0000_0011b
         db 0000_0001b
         db 0000_0110b
         db 0000_0010b


start:

read_inp:
in ax,0


move_inp:
mov dx,ax
out 1,al
check_val:
cmp dx,0

jne counter

clock:
mov bx, offset datcw ; start from clock-wise half-step.
mov si, 0
mov cx, 0 ; step counter


next_step:

; motor sets top bit when it's ready to accept new command
wait:   in al, 7
        test al, 10000000b
        jz wait

mov al, [bx][si]
out 7, al

inc si

cmp si, 4

jb next_step
mov si, 0

inc cx
cmp cx, steps_before_direction_change

jb  next_step

jmp read_inp

counter:
mov cx, 0
;add bx, 4 ; next bin data
mov bx, offset datccw ; return to clock-wise half-step.
jmp next_step

;exit:
;    MOV AH,4CH
;    INT 21H




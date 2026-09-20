li sp, 0x100
addi sp, sp, -28   # creates 8 boxes (4 bytes) x 7

addi x10, x0, 8     # g
sw x10, 0(sp)           # g here is stored in the 7th box
addi x11, x0, 4     # h   
sw x11, 4(sp)           # h here is stored in the 6th box
addi x12, x0, 2     # i
sw x12, 8(sp)           # i here is stored in the 5th box
addi x13, x0, 1     # j
sw x13, 12(sp)          # j here is tored in the 4th box

jal x1, leaf_example
lw x11, 16(sp)


addi x11, x11, 0
li x10, 1
ecall
j exit


leaf_example:
    addi x20, x0, 0
    sw x20, 16(sp)          # f here is stored in the 3rd box    
    add x18, x10, x11   # (g + h)
    sw x18, 20(sp)          # (g+h) is stored in the 2nd box

    add x19, x12, x13   # (i + j)
    sw x19, 24(sp)          # (i+j) stored in the 1st box

    sub x20, x18, x19   # updated f
    sw x20, 16(sp)          # stored in the 3rd box

    jalr x0, 0(x1)      # jump back to the function call

exit:
    add x1, x0, x0
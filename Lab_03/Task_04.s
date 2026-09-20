li x10, 0x100       # base address of array x
li x11, 0x200       # base address of array y

li x19, 0           # i = 0

jal x1, strcpy
addi x11, x11, 0
li x10, 1
ecall
j exit

strcpy:
    addi sp, sp, -8
    sw x19, 0(sp)

strcpy_main:
    lw x5, 0(sp)        # load the value of i from stack

    # since char is of 1 byte:

    add x20, x10, x5   # i-th address of array x (char)
    add x21, x11, x5   # i-th address of array y (char)

    lb x7, 0(x21)     # loading y[i] in x7
    sb x7, 0(x20)     # storing y[i] to address x[i] -- x[i] = y[i]

    bne x7, x0, jump_here

    addi sp, sp, 8     # finishing up the stack
    jalr x0, 0(x1)

jump_here:
    addi x19, x19, 1
    sw x19, 0(sp)       # updating i-value in stack
    jal x0, strcpy_main

exit:
    add x1, x0, x0
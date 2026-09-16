.text
.globl main

main:
    li x1, 0x200
    li x31, 10      # constant
    li x22, 0       # i = 0

    loop_1:
        slli x21, x22, 2
        add x10, x1, x21
        sw x22, 0(x10)
        addi x22, x22, 1
        blt x22, x31, loop_1

    addi x22, x0, 0     # i = 0
    addi x23, x0, 0     # sum = 0

    loop_2:
        slli x21, x22, 2
        add x10, x1, x21
        lw x29, 0(x10)
        add x23, x23, x29
        addi x22, x22, 1
        blt x22, x31, loop_2

end:
    j end

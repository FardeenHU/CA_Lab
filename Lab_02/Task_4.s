.text
.globl main

main:
    li x10, 0x200
    li x5, 2
    li x6, 2
    li x7, 0
    li x22, 0

    loop_1:
        bge x7, x5, exit_loop1
        addi x29, x0, 0

        loop_2:
            bge x29, x6, loop2_exit
            add x8, x7, x29
            slli x30, x29, 4
            add x30, x30, x10
            sw x8, 0(x30)
            addi x29, x29, 1
            beq x0, x0, loop_2

        loop2_exit:
            addi x7, x7, 1
            beq x0, x0, loop_1

    exit_loop1:


end:
    j end

.text
.globl main
main:
    li x10, 10
    li sp, 0x208
    jal x1, multiply_numbers_div_by_two
    jal exit

    multiply_numbers_div_by_two:
        addi sp, sp, -8 # adjust stack for 2 items
        sw x1, 4(sp) # save return address
        sw x10, 0(sp) # save argument n

        addi x5, x10, -2 # x5 = n - 2
        addi x31, x0, 2
        bge x5, x31, L1 # if (n - 2) >= 2, go to L1

        addi x10, x0, 2 # return 2
        addi sp, sp, 8 # pop stack
        jalr x0, 0(x1) # return

    L1:
        addi x10, x10, -2 # argument = n - 2
        jal x1, multiply_numbers_div_by_two # recursive call

        addi x6, x10, 0 # save result of multiply_numbers_div_by_two(n-2)
        lw x10, 0(sp) # restore original n
        lw x1, 4(sp) # restore return address
        addi sp, sp, 8 # pop stack

        mul x10, x10, x6 # n * multiply_numbers_div_by_two(n-2)
        jalr x0, 0(x1) # return
    
exit:
    add x1, x0, x0
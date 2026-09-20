addi x10, x0, 12
addi x11, x0, 12
jal x1, sum  # x1 = PC + 4

addi x11, x10, 0
li x10, 1
ecall
j exit

sum:
    add x10, x11, x10   # a = a + b
    jalr x0, 0(x1)

exit:
    add x11, x0, x0

.text
.globl main
main:
    li x10, 5       # n = 5
    li x1, 1        # acc = 1
    jal x2, fact

    add x11, x1, x0
    li x10, 1
    ecall       # prints x11 in the terminal
    jal exit    # exits program

    fact:
        beq x10, x0, exit_fact      # if (n-1) == 0: exit recursion 
        mul x1, x1, x10             # else:  n * (n-1)
        addi x10, x10, -1           # (n - 1) passed as argument
        beq x0, x0, fact            # unconditional branch

    exit_fact:
        jalr x0, 0(x2)

exit:
    add x21, x21, x0
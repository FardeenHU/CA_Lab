.text 
.globl main 

main:

    li x1, 5            # a = 5
    li x2, 0            # b = 0

    addi x1, x2, 32     # a = b + 32
    add x4, x1, x2      # d = (a + b) 
    addi x4, x4, -5     # d = (a + b) + (-5)

    sub x5, x1, x4      # e = (a - d)
    sub x6, x2, x1      # f = (b - a)
    add x5, x5, x6      # e = ((a - d) + (b - a))
    add x5, x5, x4      # e = (((a - d) + (b - a)) + d)

    add x7, x1, x2      # g = a + b
    add x8, x4, x5      # h = d + e
    add x5, x7, x8      # e = (a + b) + (d + e)


end:
    j end       # Infinite loop to halt program


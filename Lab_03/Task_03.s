li sp, 0x100

li x10, 0x108   # base address of v[]
li x11, 4       # k
li x12, 0       # temp

addi sp, sp, -12
sw x10, 0(sp)       # stores the base address of array v in the 3rd stack "box"
sw x11, 4(sp)       # stores k in the 2nd stack "box"
sw x12, 8(sp)       # stores temp in the 3rd stack "box"

jal x1, swap
addi x11, x11, 0
li x10, 1
ecall
j exit


swap:
    lw x10, 0(sp)       # base address of v
    lw x11, 4(sp)       # k

    slli x11, x11, 2    # k * 4
    add x11, x10, x11   # address of v[k]

    lw x5, 0(x11)          # v[k]
    lw x6, 4(x11)          # v[k+1]
    sw x5, 8(sp)          # stores v[k] in temp stack "box"

    sw x6, 0(x11)          # v[k] = v[k+1]
    
    lw x10, 8(sp)          # temp
    sw x10, 4(x11)         # v[k+1] = temp
    addi sp, sp, 12

    jalr x0, 0(x1)

    
exit:
    add x1, x0, x0
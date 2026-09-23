.text
.globl main


main:
    li x25, 0x100       # Base address of Array 'c'

    # Elements of the array
    li x11, 23
    li x12, 12
    li x13, 5
    li x14, 44
    li x15, 98
    li x16, 53
    li x17, 6
    li x18, 89
    li x19, 32
    li x20, 65


    # Storing the elements of the array
    sw x11, 0(x25)
    sw x12, 4(x25)
    sw x13, 8(x25)
    sw x14, 12(x25)
    sw x15, 16(x25)
    sw x16, 20(x25)
    sw x17, 24(x25)
    sw x18, 28(x25)
    sw x19, 32(x25)
    sw x20, 36(x25)


    #--------------Logic of Bubble Sort--------------
    li x1, 1                    # swapped variable
    li x31, 10                  # size of Array 'c'
    li x22, 1                   # initialized to check while condition
    li x26, 10                  # initialized to check for condition


    do:
        addi x1, x1, -1        # swapped = false (0)
        addi x30, x0, 1        # int i = 1


        do_loop:
            addi x3, x30, -1   #    i-1  
            slli x4, x3, 2     #    (i-1)*4 - byte addressing for int array
            slli x5, x30, 2    #    i*4
            add x6, x25, x4    #    address of c[i-1]
            add x7, x25, x5    #    address of c[i]


            lw x28, 0(x6)       # value at address c[i-1]
            lw x29, 0(x7)       # value at address c[i]


            blt x29, x28, perform_this_task     # if condition
            beq x0, x0, skip_if        


            perform_this_task:
                addi x10, x29, 0        # temp variable            
                sw x28, 0(x7)
                sw x10, 0(x6)


                addi x1, x0, 1          # swapped = true (1)


                skip_if:
                    addi x30, x30, 1        # i++
                    bne x30, x26, do_loop
                    beq x1, x22, do


end:
    j end

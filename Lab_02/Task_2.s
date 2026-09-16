.text
.globl main

main:
    li x20, 2       # x
    li x21, 4       # a
    li x22, 8       # b
    li x23, 16      # c

    li x1, 1
    li x2, 2
    li x3, 3
    li x4, 4

    beq x20, x1, case_1
    beq x20, x2, case_2
    beq x20, x3, case_3
    beq x20, x4, case_4
    default:
        add x21, x0, x0
        beq x0, x0, break

    case_1:
        add x21, x22, x23
        beq x0, x0, break
    case_2:
        sub x21, x22, x23
        beq x0, x0, break
    case_3:
        slli x21, x22, 1
        beq x0, x0, break
    case_4:
        srli x21, x22, 1
        beq x0, x0, break

break: 
end:
    j end

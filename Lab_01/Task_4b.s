.text 
.globl main 

main:

    lb x1, 0x100(x0)         # Array a (x1)
    lh x2, 0x200(x0)         # Array b (x2)     
    add x3, x1, x2
    sw x3, 0x300(x0)         # Array c (x3)

    lb x1, 0x101(x0)        
    lh x2, 0x202(x0)
    add x3, x1, x2             
    sw x3, 0x304(x0) 

    lb x1, 0x102(x0)        
    lh x2, 0x204(x0)
    add x3, x1, x2             
    sw x3, 0x308(x0) 

    lb x1, 0x103(x0)        
    lh x2, 0x206(x0)
    add x3, x1, x2             
    sw x3, 0x30C(x0) 

end:
    j end       # Infinite loop to halt program

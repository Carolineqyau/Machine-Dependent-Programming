.global _start

.data

#num1 is %ebx
num1:
    .long 10
    .long 10

#num2 is %ecx
num2:
    .long 10
    .long 10


.text

_start:
    movl num1, %ebx
    movl num2, %ecx
    addl %ebx, %edx
    addl %ecx, %edx     #upper 32 bits
    movl num1+4, %esi   #save lower
    movl num2+4, %edi
    addl %esi, %eax
    addl %edi, %eax     #lower 32 bits
    jc carry_label
    jnc done
    

carry_label:
    addl $1, %edx   #if the sum is greater than 9, add 1 to the carry
    
    
    
done:
    nop
    
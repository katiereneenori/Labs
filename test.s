.text
main: lw $t0,data1
lw $t1,data2
lw $t2,data3
mul $t3,$t0,$t1
mul $t3,$t3,$t2
move $a0,$t3
li $v0,1
syscall
li $v0,10
syscall
.data
data1: .word 17
data2: .word 29
data3: .word 56
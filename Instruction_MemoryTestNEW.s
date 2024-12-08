.text
addi $t1, $zero, 5      # $t1 = 5
addi $t2, $zero, 3      # $t2 = 3
addi $t3, $zero, 10     # $t3 = 10
addi $t4, $zero, 4      # $t4 = 4
addi $t5, $zero, 1      # $t5 = 1
add  $t0, $t1, $t2      # $t0 = $t1 + $t2 = 5 + 3 = 8
sub  $t0, $t3, $t4      # $t0 = $t3 - $t4 = 10 - 4 = 6
mul  $t0, $t1, $t2      # $t0 = $t1 * $t2 = 5 * 3 = 15
and  $t0, $t1, $t2      # $t0 = $t1 & $t2 = 5 & 3 = 1
or   $t0, $t1, $t2      # $t0 = $t1 | $t2 = 5 | 3 = 7
nor  $t0, $t1, $t2      # $t0 = ~(5 | 3) = -8 (0xFFFFFFF8)
xor  $t0, $t1, $t2      # $t0 = $t1 ^ $t2 = 5 ^ 3 = 6
sll  $t0, $t2, 2        # $t0 = $t2 << 2 = 3 << 2 = 12
srl  $t0, $t3, 1        # $t0 = $t3 >> 1 = 10 >> 1 = 5
slt  $t0, $t4, $t3      # $t0 = ($t4 < $t3) ? 1 : 0 = 1
addi $t6, $zero, 8      # Target address for BEQ
addi $t7, $zero, 12     # Target address for BNE
addi $t8, $zero, 16     # Target address for BGTZ
addi $t9, $zero, 20     # Target address for BLEZ
addi $s0, $zero, 24     # Target address for BLTZ
addi $s1, $zero, 28     # Target address for BGEZ
addi $s2, $zero, 32     # Target address for J
addi $s3, $zero, 36     # Target address for JAL
beq  $t0, $t1, $t6      # Branch if $t0 == $t1 (Check: $t0 = 5, $t1 = 5)
bne  $t2, $t3, $t7      # Branch if $t2 != $t3 (Check: $t2 = 4, $t3 = -1)
bgtz $t5, $t8           # Branch if $t5 > 0 (Check: $t5 = 10)
blez $t3, $t9           # Branch if $t3 <= 0 (Check: $t3 = -1)
bltz $t3, $s0           # Branch if $t3 < 0 (Check: $t3 = -1)
bgez $t4, $s1           # Branch if $t4 >= 0 (Check: $t4 = 0)
j    $s2                # Jump unconditionally (PC set to 32)
jal  $s3                # Jump and link (PC + 4 saved to $ra)
jr   $ra                # Jump to return address stored in $ra

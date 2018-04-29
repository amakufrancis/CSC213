.data
val1:.asciiz "\nA number should be entered for A):"
val2:.asciiz "\nA number should be entered for B):"
val3:.asciiz "\nA number should be entered for C):"
valerror:.asciiz "\nThat is a Complex root"
valans:.asciiz "\nYour Answers are\n...\\****"
valand:.asciiz "\nAnd\n...\\****"
valgoodbye:.asciiz "\nProgram has come to its end. Thank you"
valtwo: .float 2
valfour: .float 4

.text
main:
lwc1 $f1,valtwo                   #$f1 is 2
lwc1 $f2,valfour                  #$f2 is 4

la $a0,val1                      #User enter value for A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f4,$f0                       #$f4 is A

la $a0,val2                       #User enter value for A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f5,$f0                       #$f5 is B

la $a0,val3                       #User enter value for A
li $v0,4
syscall
li $v0,6
syscall
mov.s $f6,$f0                       #$f6 is C

#Discriminant solver d=b*b-4*a*c values for a,b,c,4 are 4=$f2, a=$f4, b=$f5, c=$f6

mul.s $f7,$f5,$f5                  #$f7 is b*b
mul.s $f8,$f2,$f4                  
mul.s $f8,$f8,$f6                  #$f8 is4*a*c
sub.s $f8,$f7,$f8                  #$f8 is d

mfc1 $t1,$f8                      #$f8 is $t1
blez $t1,error_label               #is d<=0 if yes,error label

sqrt.s $f10,$f8                    #$f10 is the square root d

#roots solver                      
neg.s $f9,$f5                      #$f9 is-b
add.s $f18,$f9,$f10                #$f18 is -b+sqrtd
sub.s $f20,$f9,$f10                #$f20 is -b-sqrtd
mul.s $f1,$f1,$f4                  #$f1 is 2*a
div.s $f21,$f18,$f1                #$f21 is -b+sqrtd/2*a
div.s $f22,$f20,$f1                #$f22 is -b-sqrtd/2*a
la $a0,valans
li $v0,4
syscall

#root printer
mov.s $f12,$f21                    #$f12 is -b+sqrtd/2*a
li $v0,2
syscall

la $a0,valand
li $v0,4
syscall

mov.s $f12,$f22                   #$f12 is -b-sqrtd/2*a
li $v0,2
syscall

b exit

error_label:
la $a0,valerror
li $v0,4
syscall

b exit

exit:
la $a0,valgoodbye         
li $v0,4
syscall
li $v0,10                    
syscall

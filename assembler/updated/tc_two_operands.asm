#this is a comment 
#all numbers are in hexadecimal
#the reset signal is raised before this code is executed and the flags and the registers are set to zeros.
.ORG 0 #this is the interrupt code
AND R3,R4
ADD R1,R4
OUT R4
RTI
.ORG 200 #this is the instructions code
IN R1                   #add 0005 in R1
IN R2                   #add 0019 in R2
IN R3                   #FFFF
IN R4                   #F320
MOV R3,R5               #R5= FFFF , flags no change
ADD R1,R4               #R4= F325 , C-->0, N-->1, Z-->0
SUB R5,R4               #R4= 0CDA , C-->0, N-->0,Z-->0 
AND R7,R4               #R4= 0000 , C-->no change, N-->0, Z-->1
OR R2, R1               #R1= 001D , C-->0, N-->0,Z-->0
SHL R1,4                #R1= 01D0 , C-->0, N-->0,Z-->0
SHR R1,4                #R1= 001D , C-->0, N-->0,Z-->0
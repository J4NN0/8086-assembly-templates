# 8086-assembly-templates
Some usefull templates in Assembly 8086

# I/O
Input/Output of character and string.

It shows how you can do an input or output operation of a character or a string. It contains also a procedure that you can use to do the I/O operation. 

# Procedure using the stack
An example of a procedure using the stack (Base Pointer and Stack Pointer). 

A usefull example to understand how to use in a good way the stack in a procedure. The parameters are passed and returned by the stack. 

# Menù
A menù with several choices.

An example of a menù that propose you different choices; the program will do different stuff based on your choice.

# Power
A procedure will calculate power of a number.

The procedure will use the stack; so in order to get the exact result, you have to push first the value and then the power. 

# Shift Bit
A procedure shifting bit and calculate the decimal value of the binary number.

The purpose is that given a binary number you want the respective decimal number. The procedure want the number of bit that have to shift: in this way you can split a number of 8 bits (for example) in two of 4 bits and so on. This kind of approach is usefull when you have more informations in a same binary number (i.e. 8 bits = 2 bits of info1, 2 bits of info2 and 4 of info3) and you want to divide this unformations.  

# Square root
Square root of a given number.

Given a number it will calculate its square root. 

# Average
Average of a series of numbers stored in an array of dim N.

Initialize DI with the offset of the array that contains the values of which you want to calculate the average and call the procedure, it will return the average of these values. 

# Maximum
Search max of an array of dim N.

Initialize SI with the offset of the array that contains the values of which you want to calculate the maximum value an put inside the value N the size of this array; then call the procedure and at the end of this you will have inside the value MAX the maximum value of the array.

# Minimum
Search min of an array of dim N.

Initialize SI with the offset of the array that contains the values of which you want to calculate the minimum value an put inside the value N the size of this array; then call the procedure and at the end of this you will have inside the value MIN the minimum value of the array.

# Float division
Float division between two numbers. 

This procedure assume a division between two 8 bit operands. If you want to use word operands you have to make sure no overflow condition will show up. It calculates at max 2 fractional digits for sake of simplicity.

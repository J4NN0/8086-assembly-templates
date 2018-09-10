#ex-1
8255 configured in mode 1, input for group A. Write the interrupt service routine for coping a sequence of ASCII characters read from group A of the 8255 in the array myWord. Only characters corresponding to lowercase and uppercase letters are copied, whereas the others are ignored. The variable count is used to memorize the number of copied characters.

#ex-2
8255 configured in mode 1, output for group A. Write the interrupt service routine for writing the variable myNumber on port A. myNumber is a doubleword variable and it should be written starting from the most significant byte. A software interrupt, by means of INT instruction, can be used for printing the first byte.
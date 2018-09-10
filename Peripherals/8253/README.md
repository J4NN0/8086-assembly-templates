#ex-1
A program with an infinite loop. The register AX is initialized to zero before entering the loop, then it is incremented at every iteration of the loop. Suppose that the frequency of the clock signal received by the 8253 is 1 KHz. After one minute, the 8253 raises an interrupt. The 8086 immediately checks if the value stored in AX is a prime number. If so, the variable isPrime is set to 1, otherwise it is set to 0.

#ex-2
Intel 8255 configured in mode 0 for group A, with port A in output. Realize a program that every 10 seconds writes a new value of the Fibonacci sequence on port A:
0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233
No more values are written after 233. Suppose that the clock frequency of the 8253 is 100 KHz.
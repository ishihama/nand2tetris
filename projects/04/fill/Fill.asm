// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(LOOP1)
    @i
    M=0
    @j
    M=0
    @24576
    D=M
    @LOOP2
    D;JNE
    @LOOP1
    0;JMP
(END1)
(LOOP2)
    @i
    D=M
    @SCREEN
    A=A+D
    M=!M
    @24576
    D=M
    @LOOP3
    D;JEQ
    @i
    M=M+1
    @LOOP2
    0;JMP
(END2)
(LOOP3)
    @j
    D=M
    @SCREEN
    A=A+D
    M=!M
    @24576
    D=M
    @LOOP1
    D;JNE

    // if i == j then jump loop1
    @i
    D=M
    @j
    D=D-M
    @LOOP1
    D;JEQ

    @j
    M=M+1
    @LOOP3
    0;JMP
(END3)
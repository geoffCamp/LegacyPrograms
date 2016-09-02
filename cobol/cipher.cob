*> cipher.cob - main component of Trithemius Cipher program
*> Geofferson Camp (0658817)
*> Mar 25, 2016

identification division.
program-id. cipher.

environment division.

input-output section.
file-control.
select infile assign to fileName
    organization is line sequential.

data division.
file section.
fd infile.
01 in-record pic x(2000).

working-storage section.
77 fileName pic x(100) value spaces. 
01 operation pic 9 value 0.
01 eof pic 9 value 0.
01 workingtext.
    05 wtext pic X occurs 2000 times.
01 all-letters. 
    05 letters pic X occurs 27 times.

procedure division.

    *>initialize primary program variables
    move "abcdefghijklmnopqrstuvwxyz" to all-letters
    move "" to workingtext

    *>request operation details from user
    display "Enter file name:"
    accept fileName
    perform until operation is equal to 1 or operation is equal to 2
        display "Choose encrypt(1) or decrypt(2):"
        accept operation
    end-perform

    *>read text from file
    open input infile
    perform until eof is equal to 1
        read infile into in-record
            at end move 1 to eof
        end-read
        if eof is not equal to 1
            string function trim(workingtext) function trim(in-record) into workingtext
        end-if 
    end-perform
    close infile.
    
    *>prepare string to be encrypted/decrypted
    move function lower-case(workingtext) to workingtext
    string function trim(workingtext) "#" into workingtext

    *>execute encryption or decryption
    if operation is equal to 1
        call "encrypt" using workingtext,all-letters
    else 
        call "decrypt" using workingtext,all-letters
    end-if

stop run.

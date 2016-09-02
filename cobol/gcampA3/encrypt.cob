*> encrypt.cob - encryption module of Trithemius Cipher program
*> Geofferson Camp (0658817)
*> Mar 25, 2016

identification division.
program-id. encrypt.

environment division.

data division.
working-storage section.
01 wcount pic 9(4) value 1.
01 wlength pic 9(4) value 0.
01 lcount pic 9(2).
01 tempcount pic 9(4).
01 newtext.
    05 ntext pic X occurs 2000 times.
01 ncount pic 9(4) value 1.

linkage section.
01 workingtext.
    05 wtext pic X occurs 2000 times.
*>01 all-letters pic x(27).
01 all-letters. 
    05 letters pic X occurs 27 times.

procedure division using workingtext,all-letters.

    inspect workingtext tallying wlength for characters before initial '#'.

    *> loop through each letter from the input string and search for a matching alphabet character
    perform varying wcount from 1 by 1 until wcount is greater than wlength   
        perform varying lcount from 1 by 1 until lcount is greater than 26 
            move lcount to tempcount
            *> if characters are equal add cipher char to output string
            if wtext(wcount) is equal to letters(lcount) then
                add ncount to tempcount
                divide tempcount by 26 giving tempcount remainder tempcount 
                if tempcount is equal to zero then
                    move 26 to tempcount
                end-if
                subtract 1 from tempcount
                if tempcount is equal to zero then
                    move 26 to tempcount
                end-if
                *> add corresponding alphabet char to the output string
                move letters(tempcount) to ntext(ncount)
                add 1 to ncount
                exit perform
            end-if
        end-perform
    end-perform

    display function trim(newtext)
    goback.

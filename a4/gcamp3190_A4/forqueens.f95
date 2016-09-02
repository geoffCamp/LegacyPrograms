program forqueens

!
!forqueens.f95 - Solving 8 queens problem in fortran
!CIS*3190 Assignment 4
!Geofferson Camp (0658817)
!April 8, 2016
!

integer :: i,err
logical,dimension(1:8) :: vCheck
logical,dimension(2:16) :: hCheck
logical,dimension(-7:7) :: dCheck
integer,dimension(1:8) :: solution

!sets up board
do i = 1,8
    vCheck(i) = .true.
enddo
do i = 2,16
    hCheck(i) = .true.
enddo
do i = -7,7
    dCheck(i) = .true.
enddo

!opens output file and initilizes main functionality
open(123,file="queensF.txt",status="old",action="write",access="stream",iostat=err)
if (err /= 0) then
    write (*,*) "output file could not be opened"
else
    call try(1,vCheck,hCheck,dCheck,solution)
    write (*,*) "Success! solutions printed to queensF.txt"
    close(123)
endif 

end program forqueens

!outputs solutions
subroutine printSol (solution)
    integer :: row,col,qPos
    integer,intent(in),dimension(1:8) :: solution
    character,dimension(1:8) :: line    

    do row = 1,8
        qPos = solution(row)
        do col = 1,8
            if (qPos == col) then
                line(col) = 'Q'
            else 
                line(col) = '.'
            endif
        enddo
        write (123) line(1:8)
        write (123) CHAR(13)//CHAR(10)
    enddo
    write (123) '-------'
    write (123) CHAR(13)//CHAR(10)

end subroutine printSol

!checks for non conflicting spaces and places queens
recursive subroutine try (row,vCheck,hCheck,dCheck,solution)
    integer :: col
    integer,intent(in) :: row
    logical,intent(inout),dimension(1:8) :: vCheck
    logical,intent(inout),dimension(2:16) :: hCheck
    logical,intent(inout),dimension(-7:7) :: dCheck
    integer,intent(inout),dimension(1:8) :: solution

    do col = 1,8
        if (vCheck(col) .and. hCheck(row+col) .and. dCheck(row-col)) then
            solution(row) = col
            vCheck(col) = .false.
            hCheck(row+col) = .false.
            dCheck(row-col) = .false.
            if (row < 8) then
                call try(row+1,vCheck,hCheck,dCheck,solution)
            else
                call printSol(solution)
            endif
            vCheck(col) = .true.
            hCheck(row+col) = .true.
            dCheck(row-col) = .true.   
        endif
    enddo

end subroutine try


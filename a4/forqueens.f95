program forqueens

!
!forqueens.f95 - Solving 8 queens problem in fortran
!Geofferson Camp (0658817)
!April 8, 2016
!

integer :: i,err
logical,dimension(1:8) :: a
logical,dimension(2:16) :: b
logical,dimension(-7:7) :: c
integer,dimension(1:8) :: solution

!sets up board
do i = 1,8
    a(i) = .true.
enddo
do i = 2,16
    b(i) = .true.
enddo
do i = -7,7
    c(i) = .true.
enddo

!opens output file and initilizes main functionality
open(123,file="queensF.txt",status="old",action="write",access="stream",iostat=err)
if (err /= 0) then
    write (*,*) "output file could not be opened"
else
    call try(1,a,b,c,solution)
    close(123)
endif 

end program forqueens

!outputs solutions
subroutine printSol (solution)
    integer :: k,k2,qPos
    integer,intent(in),dimension(1:8) :: solution
    character,dimension(1:8) :: line    

    do k = 1,8
        qPos = solution(k)
        do k2 = 1,8
            if (qPos == k2) then
                line(k2) = 'Q'
            else 
                line(k2) = '.'
            endif
        enddo
        write (123) line(1:8)
        write (123) CHAR(13)//CHAR(10)
    enddo
    write (123) '-------'
    write (123) CHAR(13)//CHAR(10)

end subroutine printSol

!checks for non conflicting spaces and places queens
recursive subroutine try (i,a,b,c,solution)
    integer :: j
    integer,intent(in) :: i
    logical,intent(inout),dimension(1:8) :: a
    logical,intent(inout),dimension(2:16) :: b
    logical,intent(inout),dimension(-7:7) :: c
    integer,intent(inout),dimension(1:8) :: solution

    do j = 1,8
        if (a(j) .and. b(i+j) .and. c(i-j)) then
            solution(i) = j
            a(j) = .false.
            b(i+j) = .false.
            c(i-j) = .false.
            if (i < 8) then
                call try(i+1,a,b,c,solution)
            else
                call printSol(solution)
            endif
            a(j) = .true.
            b(i+j) = .true.
            c(i-j) = .true.   
        endif
    enddo

end subroutine try



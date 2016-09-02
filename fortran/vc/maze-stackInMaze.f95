program maze

!
! Geofferson Camp
! 3190 A1 Maze
!
!input: columns,rows (arrays are opposite)

use stack

character(len=500) :: input 
integer :: width, height
character, dimension(:,:), allocatable :: x
character, dimension(:), allocatable :: stackM 
!character, dimension(100) :: stackM
character (len=500) :: buff
character :: holder
integer :: n,m,total

write (*,*) 'Enter file name:'
read (*,*) input

open(501,file="test.txt",status="old",action="read")
read (501,*), n,m

write(*,*) n,m

allocate(x(n,m))
total = n*m
stackSize = total
allocate(stackM(total))

do I=1,n
    write(*,*) I
    read (501,*), buff
    do J=1,m
        !write (*,*) 'one char:',buff(J:J)
        x(I,J) = buff(J:J)
    enddo
    !write (*,*), buff
    write (*,*), x(I,:)
    buff = ""
enddo

call push(stackM,'h')
call top(stackM,holder)

write (*,*) holder


   
end program maze

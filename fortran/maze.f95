program maze

!
! Geofferson Camp - 0658817
! 3190 A1 Maze
!
! Last updated Feb 5, 2016

use stack

character(len=500) :: input
character, dimension(:,:), allocatable :: grid 
character (len=500) :: buff
integer,dimension(2) :: holder
integer :: n,m,total,turnCount
Logical :: fileExists

!File input from user
write (*,*) 'Enter file name:'
read (*,*) input

!Check for file
INQUIRE(FILE=input, EXIST=fileExists)

if (.NOT.fileExists) then
    write (*,*) 'Maze file does not exist. Stopping program.'
    stop
end if

!Access maze file
open(501,file=input,status="old",action="read")
read (501,*) m,n

!Variable initialization
allocate(grid(n,m))
total = n*m
stackSize = total
allocate(stackC1(total))
allocate(stackC2(total))

!Maze array input
write (*,*) ''
write (*,*) 'Input:'
do I=1,n
    read (501,*), buff
    do J=1,m
        grid(I,J) = buff(J:J)
        if (grid(I,J) == 'o') then
            call push((/I,J/))
        end if
    enddo
    write (*,*), grid(I,:)
    buff = ""
enddo

turnCount = 1

!Maze traversal
do while (currTop <= stackSize .and. currTop > 0) 
    
    call top(holder)
    call pop()
    if (grid(holder(1),holder(2)) == 'e') then
        write (*,*) ''
        write (*,*) 'maze traversed'
        write (*,*) ''
        exit
    else if (grid(holder(1),holder(2)) == '.' .or. turnCount == 1) then
       grid(holder(1),holder(2)) = 'o'
       call push((/holder(1),holder(2)+1/)) !east
       call push((/holder(1),holder(2)-1/)) !west
       call push((/holder(1)-1,holder(2)/)) !north
       call push((/holder(1)+1,holder(2)/)) !south
    end if

    turnCount = turnCount + 1
end do

!Solution output
write (*,*) 'Solution:'
do k = 1,n
    write (*,*) grid(k,:)
end do
write (*,*) ''
write (*,*) 'walls: *'
write (*,*) 'open space: .'
write (*,*) 'path: o'
write (*,*) 'finish: e'
write (*,*) ''

!Clean up
call freeStack()
deallocate(grid)

end program maze

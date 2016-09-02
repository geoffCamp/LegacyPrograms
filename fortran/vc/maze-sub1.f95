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
character (len=500) :: buff
!integer,dimension(2) :: start
integer,dimension(2) :: holder
integer :: n,m,total,turnCount

write (*,*) 'Enter file name:'
read (*,*) input

open(501,file=input,status="old",action="read")
read (501,*) m,n

write(*,*) n,m

allocate(x(n,m))
total = n*m
stackSize = total
!allocate(stackM(2,total))
allocate(stackC1(total))
allocate(stackC2(total))

do I=1,n
    !write(*,*) I
    read (501,*), buff
    do J=1,m
        x(I,J) = buff(J:J)
        if (x(I,J) == 'o') then
            !write (*,*) 'found start'
            call push((/I,J/))
            !start = (/I,J/)
        end if
    enddo
    !write (*,*), buff
    write (*,*), x(I,:)
    buff = ""
enddo

call push((/1,1/))
call top(holder)
call pop()

write (*,*) holder, currTop, stackSize

turnCount = 1

do while (currTop <= stackSize .and. currTop > 0) 
    
    call top(holder)
    !write (*,*) holder, x(holder(1),holder(2))
    call pop()
    if (x(holder(1),holder(2)) == 'e') then
        write (*,*) 'maze traversed'
        exit
    else if (x(holder(1),holder(2)) == '.' .or. turnCount == 1) then
       x(holder(1),holder(2)) = 'o'
       !write (*,*) holder(1), ',', holder(2)
       
       call push((/holder(1),holder(2)+1/)) !east
       call push((/holder(1),holder(2)-1/)) !west
       call push((/holder(1)-1,holder(2)/)) !north
       call push((/holder(1)+1,holder(2)/)) !south

    end if

    turnCount = turnCount + 1
end do

!write (*,*) currTop, stackSize

do k = 1,n
    write (*,*) x(k,:)
end do

end program maze

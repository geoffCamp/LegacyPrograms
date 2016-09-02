module stack
    implicit none
    integer :: stackSize = 0
    integer :: currTop = 0
    !integer, dimension(:,:), allocatable :: stackM
    integer, dimension(:), allocatable :: stackC1
    integer, dimension(:), allocatable :: stackC2
contains

subroutine top(toTake)

    implicit none
    integer, dimension(2), intent(out) :: toTake 

    !toTake(1) = stackM(currTop,1)
    !toTake(2) = stackM(currTop,2)
    toTake(1) = stackC1(currTop)
    toTake(2) = stackC2(currTop)
        
end subroutine top

subroutine pop()

    implicit none
    
    currTop = currTop - 1

end subroutine pop

subroutine push(toPush)

    implicit none
    integer,dimension(2), intent(in) :: toPush

!call printStack()

    currTop = currTop + 1
   
    if (currTop > stackSize) then
        write(*,*) "stack full"
        !exit
    endif

    !stackM(currTop,1) = toPush(1)
    stackC1(currTop) = toPush(1)

    !stackM(currTop,2) = toPush(2) 
    stackC2(currTop) = toPush(2)

!call printStack
end subroutine push    

subroutine printStack ()

   implicit none
   integer :: I

    write (*,*) 'stack top'
    do I=currTop,1,-1
        write (*,*) stackC1(I),',',stackC2(I) 
    end do
    write (*,*) 'stack bottom'

end subroutine printStack

end module

module stack
    implicit none
    integer :: stackSize = 0
    integer :: currTop = 0
    integer, dimension(:,:), allocatable :: stackM
contains

subroutine top(toTake)

    implicit none
    integer, dimension(2), intent(out) :: toTake 

    toTake(1) = stackM(currTop,1)
    toTake(2) = stackM(currTop,2)
        
end subroutine top

subroutine pop()

    implicit none
    
    currTop = currTop - 1

end subroutine pop

subroutine push(toPush)

    implicit none
    integer,dimension(2), intent(in) :: toPush

    currTop = currTop + 1
   
    if (currTop > stackSize) then
        write(*,*) "stack full"
        !exit
    endif
 
    stackM(currTop,1) = toPush(1)
    stackM(currTop,2) = toPush(2) 

end subroutine push    

end module

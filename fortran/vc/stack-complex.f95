module stack
    implicit none
    integer :: stackSize = 0
    integer :: currTop = 0
    complex, dimension(:), allocatable :: stackM
    !integer,dimension(2) :: currTop = (/0,0/)
    !integer, dimension(:,:), allocatable :: stackM
contains

subroutine top(toTake)

    implicit none
    complex, intent(out) :: toTake
    !integer, dimension(2), intent(out) :: toTake 

    toTake = stackM(currTop)
    !toTake(1) = stackM()
    !toTake(2) = stackM()
        
end subroutine top

subroutine pop()

    implicit none
    
    currTop = currTop - 1

end subroutine pop

subroutine push(toPush)

    implicit none
    complex, intent(in) :: toPush
    !integer,dimension(2), intent(in) :: toPush

    currTop = currTop + 1
   
    if (currTop > stackSize) then
        write(*,*) "stack full"
        !exit
    endif
 
    stackM(currTop) = toPush 

end subroutine push    

end module

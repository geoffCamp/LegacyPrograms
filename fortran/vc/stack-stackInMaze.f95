module stack
    implicit none
    integer stackSize,currTop
    !allocatable :: stack
contains

subroutine top(stack,toTake)

    implicit none
    character, intent(in), dimension(stackSize) :: stack
    character, intent(out) :: toTake 

    toTake = stack(currTop)
        
end subroutine top

subroutine pop(stack)

    implicit none
    character, intent(in), dimension(stackSize) :: stack

    currTop = currTop - 1

end subroutine pop

subroutine push(stack,toPush)

    implicit none
    character, intent(inout), dimension(stackSize) :: stack
    character, intent(in) :: toPush

    currTop = currTop + 1
   
    if (currTop > stackSize) then
        write(*,*) "stack full"
        !exit
    endif
 
    stack(currTop) = toPush 

end subroutine push    

end module

!
! Geofferson Camp
! Stack Module
!
module stack
    implicit none
    integer :: stackSize = 0
    integer :: currTop = 0
    integer, dimension(:), allocatable :: stackC1
    integer, dimension(:), allocatable :: stackC2
contains

!Returns element at top of stack
subroutine top(toTake)

    implicit none
    integer, dimension(2), intent(out) :: toTake 

    toTake(1) = stackC1(currTop)
    toTake(2) = stackC2(currTop)
        
end subroutine top

!Removes element fromm top of stack
subroutine pop()

    implicit none
    
    currTop = currTop - 1

end subroutine pop

!Adds element to top of stack
subroutine push(toPush)

    implicit none
    integer,dimension(2), intent(in) :: toPush

    currTop = currTop + 1
   
    if (currTop > stackSize) then
        write(*,*) "stack full"
    endif

    stackC1(currTop) = toPush(1)
    stackC2(currTop) = toPush(2)

end subroutine push    

!Outputs stack for debugging
subroutine printStack ()

   implicit none
   integer :: I

    write (*,*) 'stack top'
    do I=currTop,1,-1
        write (*,*) stackC1(I),',',stackC2(I) 
    end do
    write (*,*) 'stack bottom'

end subroutine printStack

!Frees stack memory
subroutine freeStack()

    deallocate(stackC1)
    deallocate(stackC2)

end subroutine freeStack

end module

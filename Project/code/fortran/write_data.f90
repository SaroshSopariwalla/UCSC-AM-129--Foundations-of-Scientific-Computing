! File: write_data.f90
! Author: Sarosh Sopariwalla
! Purpose: Holds subroutines that prints matrices and vectors
!          onto the screen
module write_data
    implicit none
contains

subroutine PrintMatrix (A)
!Declare Variables
    real(8), allocatable,intent(IN)::A(:,:)
    integer, DIMENSION(2) :: ShapeOfArray
    integer :: Arow,i ! Dimensions of the arrays + loopers
!Executables
    ShapeOfArray=SHAPE(A)
    Arow = ShapeOfArray(1)
    do i=1,Arow
        print *, A(i,:)
    end do
end subroutine PrintMatrix

subroutine PrintVector (b)
    !Declare Variables
        real(8), allocatable,intent(IN)::b(:)
        integer, DIMENSION(1) :: ShapeOfArray
        integer :: brow,i ! Dimensions of the arrays + loopers
    !Executables
        ShapeOfArray=SHAPE(b)
        brow = ShapeOfArray(1)
        do i=1,brow
            print *, b(i)
        end do
    end subroutine PrintVector

end module write_data
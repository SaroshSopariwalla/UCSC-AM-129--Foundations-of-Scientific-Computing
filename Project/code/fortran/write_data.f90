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

subroutine WriteToFile (unitnumber, filename,x)
    !Declare Variables
    integer, intent(IN) :: unitnumber
    integer :: rownumbs,i
    integer, dimension(1)::ShapeOfArray
    character(len=*):: filename
    real(8), allocatable, intent(IN)::x(:)
    !Executables
    ShapeOfArray=SHAPE(x)
    rownumbs = ShapeOfArray(1)
    open(unitnumber, file= filename)
    do i=1,rownumbs
        write(unitnumber,*) x(i)
    enddo
    close(unitnumber)
end subroutine WriteToFile

end module write_data
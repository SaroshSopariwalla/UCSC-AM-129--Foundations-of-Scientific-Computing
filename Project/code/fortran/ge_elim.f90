! File: ge_elim.f90
! Author: Sarosh Sopariwalla
! Purpose: Holds the Gaussian elimination and
!          backsubstitution subroutines (both with and 
!          without pivoting.)

module ge_elim
    implicit none
contains


subroutine BasicGE (A,b)
    !Declare Variables
    real(8), allocatable, dimension(:,:), intent(INout) :: A
    integer, dimension(2) :: ShapeArray
    real(8), allocatable, dimension(:), intent(INout) :: b
    integer :: i,j,m
    real(8) :: factor
    !Executables
    ShapeArray=shape(A)
    m = ShapeArray(1)                  !A is a square matrix so both dimensions are equal
    do j=1,m-1                         !j iterates over columns
        if (A(j,j) == 0.0) THEN
            stop
        end if
        do i = j+1,m !i is rows        !i iterates over rows
            factor  = A(i,j) / A(j,j)
            A(i,:) = A(i,:) - (factor * A(j,:) )
            b(i) = b(i) - (b(j) * factor)
        end do
    enddo
  end subroutine BasicGE

subroutine PartialPivotGE (A,b)
    !Declare Variables
    real(8), allocatable, dimension(:,:), intent(INout) :: A
    integer, dimension(2) :: ShapeArray
    real(8), allocatable, dimension(:), intent(INout) :: b
    real(8), allocatable, dimension(:) :: OneColumn,SwapRow1,SwapRow2
    integer :: i,j,m,location
    real(8) :: factor,bswap1,bswap2
    !Executables
    ShapeArray=shape(A)
    m = ShapeArray(1)                  !A is a square matrix so both dimensions are equal
    allocate(SwapRow1(m))
    allocate(SwapRow2(m))
    allocate(OneColumn(m))
    do j=1,m-1                          !j iterates over columns
        OneColumn= A(:,j)
        location = MAXLOC(Abs(OneColumn),dim=1)
        if (location>j) THEN
            SwapRow1 = A(location,:)
            SwapRow2 = A(j,:)

            A(j,:) = SwapRow1
            A(location,:) = SwapRow2

            bswap1 = b(j)
            bswap2 =b(location)

            b(j)=bswap2
            b(location)=bswap1
        endif
        do i = j+1,m !i is rows        !i iterates over rows
            factor  = A(i,j) / A(j,j)
            A(i,:) = A(i,:) - (factor * A(j,:) )
            b(i) = b(i) - (b(j) * factor)
        end do
    enddo
  end subroutine PartialPivotGE

subroutine BackSubstitution (U,y,x)
    !Declare Variables
    real(8), allocatable, dimension(:,:), intent(INout) :: U
    real(8), allocatable, dimension(:), intent(INout) :: y
    real(8), allocatable, dimension(:), intent(out) :: x
    integer, dimension(2) :: ShapeArray
    integer :: i,k,m,looper
    real(8) :: sum
    !Executables
    ShapeArray=shape(U)
    m=ShapeArray(1)
    allocate(x(m))
    do looper=1,m
        if (U(m,m)==0.0) then
            print *, "U is singular"
            stop
        else
        x(m)=y(m)/U(m,m)
        end if
    end do
    do i=m-1,1,-1
        if (U(i,i)==0) then
            print *, "U is singular"
            stop
        endif
        sum = 0.0
        do k=(i+1),m 
            sum = sum + U(i,k) * x(k)
        enddo
        x(i)=(y(i)-sum)/U(i,i)
    enddo
end subroutine BackSubstitution

end module ge_elim
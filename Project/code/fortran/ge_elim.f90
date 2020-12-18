! File: ge_elim.f90
! Author: Sarosh Sopariwalla
! Purpose: Holds the Gaussian elimination and
!          backsubstitution subroutines (both with and 
!          without pivoting.)

module ge_elim
    implicit none
contains


subroutine BasicGE (A,b,Y)
    !Declare Variables
    real(8), allocatable, dimension(:,:), intent(INout) :: A
    integer, dimension(2) :: ShapeArray
    real(8), allocatable, dimension(:),intent(INout) :: b
    real(8), allocatable, dimension(:,:),intent(INout),optional :: Y
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
            if (present(Y)) then
            Y(i,:) = Y(i,:) - (factor * Y(j,:) )
            end if
        end do
    enddo
  end subroutine BasicGE

subroutine PartialPivotGE (A,b,Y)
    !Declare Variables
    real(8), allocatable, dimension(:,:), intent(INout) :: A
    real(8), allocatable, dimension(:,:), intent(INout),optional :: Y
    integer, dimension(2) :: ShapeArray
    real(8), allocatable, dimension(:), intent(INout) :: b
    real(8), allocatable, dimension(:) :: OneColumn,SwapRow1,SwapRow2
    integer :: i,j,m,location,looper
    real(8) :: factor,bswap1,bswap2
    !Executables
    ShapeArray=shape(A)
    m = ShapeArray(1)                  !A is a square matrix so both dimensions are equal
    allocate(SwapRow1(m))
    allocate(SwapRow2(m))
    allocate(OneColumn(m))
    do j=1,m-1                          !j iterates over columns
        OneColumn= A(:,j)
        do looper = 1,j-1
            OneColumn(looper)=0
        enddo
        location = MAXLOC(Abs(OneColumn),dim=1)
        if (location>j) THEN
            SwapRow1 = A(location,:)
            SwapRow2 = A(j,:)

            A(j,:) = SwapRow1
            A(location,:) = SwapRow2

            if (present(Y)) then
            SwapRow1 = Y(location,:)
            SwapRow2 = Y(j,:)

            
            Y(j,:) = SwapRow1
            Y(location,:) = SwapRow2
            end if



            bswap1 = b(j)
            bswap2 =b(location)

            b(j)=bswap2
            b(location)=bswap1
        endif
        do i = j+1,m !i is rows        !i iterates over rows
            factor  = A(i,j) / A(j,j)
            A(i,:) = A(i,:) - (factor * A(j,:) )
            b(i) = b(i) - (b(j) * factor)
            if (present(Y)) then
            Y(i,:) = Y(i,:) - (factor * Y(j,:) )
            end if
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

subroutine BackSubstitutionMatrix (A,Y)
    !Declare Variables
    real(8), allocatable, dimension(:,:), intent(INout) :: A,Y
    !real(8), allocatable, dimension(:), intent(out) :: x
    integer, dimension(2) :: ShapeArray
    integer :: i,m,j
    real(8) :: factor
    !Executables
    ShapeArray = Shape(A)
    m = ShapeArray(1)
    do i=m,1,-1 !i is rows
        factor = 1 / A(i,i)
        A(i,:) = A(i,:)*factor
        Y(i,:) = Y(i,:)*factor

            do j=1,i-1 !j is rows
                factor = 1/A(j,i)
                A(j,:) = factor*A(j,:) - A(i,:)
                Y(j,:) = factor*Y(j,:) - Y(i,:)
            end do

    end do


end subroutine BackSubstitutionMatrix

end module ge_elim
program gauss

  real, allocatable, dimension(:,:) :: A, ATr
  real, allocatable, dimension(:) :: b
  integer :: i

  ! Allocate Memory to A and b
allocate(A(3,3))
allocate(b(3))
  ! initialize matrix A and vector b
  A(:,:) = reshape((/2., 4.,7., 3.,7.,10., -1., 1.,-4./), (/3,3/))
  b = (/1., 3., 4./)
  


  ! print augmented matrix
  print *, "Augmented Matrix"
do i = 1, 3           ! i is row
     print *, A(i,:), "|", b(i)
end do

    
  print *, ""    ! print a blank line
  print *, "Gaussian elimination........"

    call gaussian_elimination(A,b)


  !print echelon form
  print *, "***********************"
do i = 1, 3           ! i is row
     print *, A(i,:), "|", b(i)
end do

  print *, ""    ! print a blank line
  print *, "back subs......"

  call backsubstitution(A,b)

  
  !print the results
  print *, "***********************"
  do i = 1, 3
     print *, A(i,:), "|", b(i)
  end do

  print *, ""
  print *, "The solution vector is;"
  do i = 1, 3
     print *, b(i)
  end do

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
print *, ""
print *, "***************************************"
print *, "Now we solve the transposed system...."
!Reinitialize A and b
A(:,:) = reshape((/2., 4.,7., 3.,7.,10., -1., 1.,-4./), (/3,3/))
b = (/1., 3., 4./)
!Find the Transpose of Matrix A
ATr = REAl(Transpose(A))
!Print A Transposed Matrix (b doesn't change)
print *, "Transposed System:"
do i = 1, 3           ! i is row
     print *, ATr(i,:), "|", b(i)
end do

    
  print *, ""    ! print a blank line
  print *, "Gaussian elimination........"

    call gaussian_elimination(ATr,b)


  !print echelon form of A Transpose
  print *, "***********************"
do i = 1, 3           ! i is row
     print *, ATr(i,:), "|", b(i)
end do

  print *, ""    ! print a blank line
  print *, "back subs......"

  call backsubstitution(ATr,b)

  
  !print the results
  print *, "***********************"
  do i = 1, 3
     print *, ATr(i,:), "|", b(i)
  end do

  print *, ""
  print *, "The solution vector is;"
  do i = 1, 3
     print *, b(i)
  end do
contains

subroutine gaussian_elimination (A,b)
  real, allocatable, dimension(:,:), intent(INout) :: A
  real, allocatable, dimension(:), intent(INout) :: b
  integer :: i,j

  ! gaussian elimination
  do j = 1, 2           ! j is column
     do i = j+1, 3       ! i is row
        factor = A(i,j)/A(j,j)
        A(i,:) = A(i,:) - factor*A(j,:)
        b(i) = b(i) - factor*b(j)
     end do
  end do
end subroutine gaussian_elimination


subroutine backsubstitution (A,b)


  real, allocatable, dimension(:,:), intent(INout) :: A
  real, allocatable, dimension(:), intent(INout) :: b
  integer :: i,j

  ! doing back substitution
  do j = 3, 2, -1            ! j is column
     do i = j-1,1, -1        ! i is row
        factor = A(i,j)/A(j,j)
        A(i,:) = A(i,:) - factor*A(j,:)
        b(i) = b(i) - factor*b(j)
     end do
  end do
  ! overwrite the solution vector to b
  do i = 1, 3
     b(i) = b(i)/A(i,i)
  end do
end subroutine backsubstitution

end program gauss




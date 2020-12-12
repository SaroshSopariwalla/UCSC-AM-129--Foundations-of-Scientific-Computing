! File: linear_solve.f90
! Author: Sarosh Sopariwalla
! Purpose: Hold main driver routine which calls
!          functions/subroutines from the remaining files.
program linear_solve
    use read_data
    use write_data
    use ge_elim
!Define Variables
    IMPLICIT NONE
    real(8), allocatable::A(:,:)
    real(8), allocatable::b(:)
    real(8), allocatable::x(:)
    integer, dimension(1) :: ShapeArray(2)
    integer :: m,i
!Executables

call ReadInMatrix(A,b)    !Matrices A and B are well defined
print *, "Matrix A:"
call PrintMatrix(A)       !Print them out to confirm they are correct
print *, "Vector b:"
call PrintVector(b)

ShapeArray = Shape(A)
m=ShapeArray(1)

print *, 'We have a', m,'-dimensional system.'

print *, "----------"
print *, "Our goal is to solve the system Ax=b, where x and b are vectors."
print *, "In general, we solve this system through gaussian elimination; there are two"
print *, "interesting algorithms we can use to reduce our matrix into upper triangular form."
print *, "These are with and without partial pivoting. We implement both methods below. :)"
print *, "----------"



print *, "Using regular gaussian elimination, we reduce A into the following upper triangular matrix:"
call BasicGE(A,b)
call PrintMatrix(A)
print *, "We can find the final solution to our system of equations using back substitution."
print *, "The answer is stored in the file x_nopiv.dat :)"
print *, "----------"
call BackSubstitution(A,b,x)
open(37, file="x_nopiv.dat")
do i=1,m
    write(37,*) x(i)
enddo
close(37)


call ReadInMatrix(A,b) 

print *, "We can also use partial pivoting, A reduces into the following upper triangular matrix:"
call PartialPivotGE(A,b)
call PrintMatrix(A)
print *, "We can find the final solution to our system of equations using back substitution."
print *, "The answer is stored in the file x_piv.dat :)"
call BackSubstitution(A,b,x)
open(35, file="x_piv.dat")
do i=1,m
    write(35,*) x(i)
enddo
close(35)

end program linear_solve




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
    integer :: eqnNumb
    CHARACTER(len=1) :: arg
    CHARACTER(len=10) :: filename2
    CHARACTER(len=12) :: filename1

!Executables
call get_command_argument(1,arg)
call ReadInMatrix(A,b)    !Matrices A and B are well defined
print *, "Matrix A:"
call PrintMatrix(A)       !Print them out to confirm they are correct
print *, "Vector b:"
call PrintVector(b)
print *, "----------"

print *, "Using regular gaussian elimination, we reduce A into the following upper triangular matrix:"
call BasicGE(A,b)
call PrintMatrix(A)
print *, "Using back substitution, we store our solution in x_nopiv",arg,".dat file"
call BackSubstitution(A,b,x)
filename1= "x_nopiv"//arg//".dat"
call WriteToFile(1,filename1,x)
print *, "----------"



call ReadInMatrix(A,b) 
print *, "We can also use partial pivoting, A reduces into the following upper triangular matrix:"
call PartialPivotGE(A,b)
call PrintMatrix(A)
print *, "Using back substitution, we store our solution in x_piv",arg,".dat file"
call BackSubstitution(A,b,x)
filename2= "x_piv"//arg//".dat"
call WriteToFile(1,filename2,x)



end program linear_solve




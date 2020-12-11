! File: linear_solve.f90
! Author: Sarosh Sopariwalla
! Purpose: Hold main driver routine which calls
!          functions/subroutines from the remaining files.
program linear_solve
    use read_data
    use write_data
!Define Variables
    IMPLICIT NONE
    real(8), allocatable::A(:,:)
    real(8), allocatable::b(:)
!Executables
call ReadInMatrix(A,b)    !Matrices A and B are well defined
print *, "Matrix A:"
call PrintMatrix(A)
print *, "Vector b:"
call PrintVector(b)
end program linear_solve




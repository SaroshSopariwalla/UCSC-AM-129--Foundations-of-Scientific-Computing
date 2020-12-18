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
    real(8), allocatable::A(:,:), Y(:,:)
    real(8), allocatable::b(:)
    real(8), allocatable::x(:)
    integer, dimension(2)::ShapeOfArray
    integer :: rownumbs,i
    CHARACTER(len=1) :: arg,arg2
    CHARACTER(len=10) :: filename2
    CHARACTER(len=12) :: filename1

!Executables
call get_command_argument(2,arg2)
IF (arg2 .eq. "5") THEN
    call ReadInMatrix(A,b)
    print *, "Here is matrix A_4:"
    call PrintMatrix(A)
    call ReadJointVectors (Y)
    print *, "Here is our matrix B:"
    call PrintMatrix(Y)
    print *, "________"
    print *, "Using regular gaussian elimination and back substitution we see X ="
    call BasicGE(A,b,Y) !Don't care about what happens to b
    call BackSubstitutionMatrix(A,Y)
    call PrintMatrix(Y)
    print *, "Clearly this a case where basic gaussian elimination fails us."
    print *, "Trying with partial pivoting and back substitution, X ="
    deallocate(Y)
    call ReadInMatrix(A,b)
    call ReadJointVectors (Y)
    call PartialPivotGE(A,b,Y)
    call BackSubstitutionMatrix(A,Y)
    call PrintMatrix(Y)
    print *, "As expected, partial pivoting fixed the issue :)"
    print *, "We save this solution to X.dat"
    ShapeOfArray=SHAPE(Y)
    rownumbs = ShapeOfArray(1)
    open(45, file= "X.dat")
    do i=1,rownumbs
        write(45,*) Y(i,:)
    enddo
    close(45)

ELSE

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
    print *, "We can also use partial pivoting to reduce A into the following upper triangular matrix:"
    call PartialPivotGE(A,b)
    call PrintMatrix(A)
    print *, "Using back substitution, we store our solution in x_piv",arg,".dat file"
    call BackSubstitution(A,b,x)
    filename2= "x_piv"//arg//".dat"
    call WriteToFile(1,filename2,x)
END IF


end program linear_solve




! File: read_data.f90
! Author: Sarosh Sopariwalla
! Purpose: Holds subroutines to read A and b in from data files.
module read_data
    implicit none
contains

subroutine ReadInMatrix (A,b)
!Declare Variables
    real(8), allocatable,intent(OUT)::A(:,:)
    real(8), allocatable,intent(OUT)::b(:)
    INTEGER :: i,j,numbrows,numbcols              ! Dimensions of the array + loopers
!Executables
    open(10,file='A.dat',status='old',action='read')
    read(10,*) numbrows, numbcols
    ALLOCATE (A(numbrows,numbcols))
    DO i=1,numbrows
        read (10,*) (A(i,j),j=1,numbcols)
    END DO
    CLOSE (10, STATUS='KEEP')

    open(11,file='b.dat',status='old',action='read')
    read(11,*) numbrows
    ALLOCATE (b(numbrows))
    DO i=1,numbrows
        read(11,*)b(i)
    END do
    CLOSE(11,STATUS='KEEP')
end subroutine ReadInMatrix

subroutine ReadJointVectors (Y)
!Declare Variables
    real(8), allocatable,intent(INOUT)::Y(:,:)
    INTEGER :: i,j,numbrows,numbcols              ! Dimensions of the array + loopers
!Executables
    open(12,file='Y.dat',status='old',action='read')
    read(12,*) numbrows, numbcols
    ALLOCATE (Y(numbrows,numbcols))
    DO i=1,numbrows
        read (12,*) (Y(i,j),j=1,numbcols)
    END DO
    CLOSE (12, STATUS='KEEP')
end subroutine ReadJointVectors


end module read_data
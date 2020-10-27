module dftmod

  use utility, only : dp, pi
  
  implicit none
  
contains

  !!! ==== Add your matvecprod function here ==== !!!
function matvecprod(A,x) result(y)
	implicit none
	!Define Variables
    REAL(DP), DIMENSION(2) :: ShapeOfArray
    Integer :: NumbOfCols, looper
	real (dp), intent(in) :: A(:,:)
	real (dp), intent(in) :: x(:)
	real (dp), dimension(size(A,1)) :: y
	!Executables
    ShapeOfArray = SHAPE(A)
    NumbOfCols = SHAPEOFARRAY(2)
    do looper = 1, NumbOfCols
        y(looper) = sum(A(looper,:) * x)
    end do
end function matvecprod

  
  ! subroutine: dft_TransMat
  ! purpose: Fill transformation matrix for a discrete Fourier transform
  !          on a given domain
  subroutine dft_TransMat(x,k,T)
    implicit none
    real (dp), intent(in)     :: x(:)
    real (dp), intent(out)    :: k(:)
    real (dp), intent(in out) :: T(:,:)
    ! Local variables
    REAL(DP), DIMENSION(2) :: ShapeOfT
    integer :: M, N, i, NumbOfRows
    real (dp) :: om, dx
    ! Set sizes and base wavenumber
    M=size(T,1)
    N=size(T,2)
    dx = x(2)-x(1)
    om = 2*pi/(N*dx)
    ! Set wavenumbers
    k(1) = 0.0_dp
    do i=2,M,2
      k(i) = i*om/2
      if (i+1<=M) then
        k(i+1) = k(i)
      end if
    end do
    !!! ==== Add your code to fill T here ==== !!!
    ShapeOfT = SHAPE(T)
    NumbOfRows = ShapeOfT(1)
    T(1,:)=1/20
    do i=2,NumbOfRows,2
       T(i,:) = 2*cos(k(i)*x)/N 
    end do
    do i=3,NumbOfRows,2
       T(i,:) = 2*sin(k(i)*x)/N
    end do
    
  end subroutine dft_TransMat
  !!! ==== Add your dft_InvTransMat subroutine here ==== !!!
  
subroutine dft_InvTransMat(x,k,Tinv)
    implicit none
    real (dp), intent(in)     :: x(:)
    real (dp), intent(in)    :: k(:)
    real (dp), intent(in out) :: Tinv(:,:)
    !Local Vars
    REAL(DP), DIMENSION(2) :: ShapeOfTinv
    integer :: j, NumbOfCols
    !Executables
    Tinv(:,1)=1
    ShapeOfTinv = SHAPE(Tinv)
    NumbOfCols = ShapeOfTinv(2)
    do j=2,NumbOfCols,2
       Tinv(:,j) = cos(k(j)*x) 
    end do
    do j=3,NumbOfCols,2
       Tinv(:,j) = sin(k(j)*x)
    end do

end subroutine dft_invtransmat
  

end module dftmod

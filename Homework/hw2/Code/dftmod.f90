module dftmod

  use utility, only : dp, pi
  
  implicit none
  
contains

  !!! ==== Add your matvecprod function here ==== !!!



  
  ! subroutine: dft_TransMat
  ! purpose: Fill transformation matrix for a discrete Fourier transform
  !          on a given domain
  subroutine dft_TransMat(x,k,T)
    implicit none
    real (dp), intent(in)     :: x(:)
    real (dp), intent(out)    :: k(:)
    real (dp), intent(in out) :: T(:,:)
    ! Local variables
    integer :: M, N, i
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
    
    
    
  end subroutine dft_TransMat

  
  !!! ==== Add your dft_InvTransMat subroutine here ==== !!!

  

end module dftmod

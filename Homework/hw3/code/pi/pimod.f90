module pimod
    implicit none
    integer, parameter :: dp = kind(0.d0)
  
  
contains

  subroutine ApproxPi(thresh,N_Max,pi_appx,diff,N)
    implicit none   
        real(dp), parameter :: pi_ref = acos(-1.0_dp)
        real (dp), intent(in)     :: thresh
        integer (dp), intent(in)  :: N_Max
        real (dp), intent(out) :: pi_appx, diff
        integer (dp), intent(out) :: N
    ! Local variables
        integer(dp) :: i
    ! Initialize pi_appx to 0, and diff to abs(pi_appx - pi_ref)
        pi_appx = 0
        N=0
        diff=abs(pi_appx-pi_ref)
    !Loop from 0 to N_Max. Each pass through the loop should add another term
    !from the series to pi_appx, update the error in diff, and exit if the error 
    !meets the tolerance thresh.
    do i=0,N_Max
        pi_appx= pi_appx + (  (16.**(-1.*i) )    * ( (4./(8.*i+1))  -(2./(8.*i+4))-(1./(8.*i+5)) - (1./(8.*i+6.))           ) )
        N = N+1
        diff=abs(pi_appx-pi_ref)
        if (diff <= thresh) then
           exit
        endif
    end do

  end subroutine ApproxPi
  
  
end module pimod


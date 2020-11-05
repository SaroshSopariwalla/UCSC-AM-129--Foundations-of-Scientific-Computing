! File: pi.f90
! Author: Sarosh Sopariwalla
! Purpose: Approximate pi using numerical methods.

program pi
  use pimod
implicit none

  ! Problem data
  integer(dp), parameter :: N_Max = 50           ! Max Summands=50
  real (dp) :: thresh,pi_appx,diff
  integer (dp):: N, j
  real(dp), dimension(4) :: Thresholds
  !Executables
  Thresholds=(/1.0d-4, 1.0d-8, 1.0d-12, 1.0d-16 /)  !We will loop through this array
  do j = 1, size(Thresholds)
    thresh = Thresholds(j)
    write(*,*) "For threshold of", thresh
    Call ApproxPi(thresh,N_Max,pi_appx,diff,N)
    write(*,*) "Approximate Pi: ", pi_appx          !Print Approx Pi, # Summands, and Error
    write(*,*) "Number of Summands: ", N            !for each threshold in our vector
    write(*,*) "Absolute Error: ", diff
    write(*,*) "-------------------------"
  end do
end program pi

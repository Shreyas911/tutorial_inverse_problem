program driver_forward
	
	use forward, n => nx, fp => forward_problem !! Alias to a local variable

	implicit none 

	real(8) :: M0, M1
	real(8) :: J=0.

	! opening the state file for reading
        open (99, file = 'state.txt', status = 'old')
	read(99,*) M0
	read(99,*) M1

	call fp(M0,M1,J)
        open (unit = 2, file = "loss_inexact_line_search.txt", action="write",status="replace")
        write(2,*) J
        close(2)
end program driver_forward


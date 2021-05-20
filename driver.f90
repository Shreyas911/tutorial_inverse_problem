program driver
	
	use forward_diff, n => nx, fp => forward_problem !! Alias to a local variable

	implicit none 

	real(8) :: M0, M1, M0b =0., M1b = 0.
	real(8) :: J=0., Jb = 1.

	! opening the state file for reading
        open (99, file = 'state.txt', status = 'old')
	read(99,*) M0
	read(99,*) M1

	call forward_problem_b(M0,M0b,M1,M1b,J,Jb)

	open (unit = 1, file = "gradient.txt", action="write",status="replace")
	write(1,*) M0b
	write(1,*) M1b
	close(1)

	call fp(M0,M1,J)
        open (unit = 2, file = "loss.txt", action="write",status="replace")
        write(2,*) J
        close(2)
end program driver


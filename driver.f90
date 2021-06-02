program driver
	
	use forward_diff, n => nx, fp => forward_problem !! Alias to a local variable

	implicit none 

	real(8), dimension(n+1) :: M, Mb =0., b, bb = 0.
	real(8) :: J=0., Jb = 1.
	integer :: i
	! opening the state file for reading
        open (99, file = 'state.txt', status = 'old')
	do i = 1, n+1
		read(99,*) M(i)
	end do
	do i = 1, n+1
		read(99,*) b(i)
	end do
	close(99)

	call forward_problem_b(M,Mb,b,bb,J,Jb)

	open (unit = 0, file = "gradient.txt", action="write",status="replace")
	open (unit = 2, file = "loss.txt", action="write",status="replace")

	do i = 1, n+1
		write(0,*) Mb(i)
	end do
	do i = 1, n+1
                write(0,*) bb(i)
        end do

	call fp(M,b,J)
        write(2,*) J

	close(0)
	close(1)
	close(2)
end program driver


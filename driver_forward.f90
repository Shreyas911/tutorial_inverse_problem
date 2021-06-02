program driver_forward
	
	use forward, n => nx, fp => forward_problem !! Alias to a local variable

	implicit none 

	real(8), dimension(n+1) :: M, b
	real(8) :: J=0.
	integer :: i

	! opening the state file for reading
        open (99, file = 'state.txt', status = 'old')
	do i = 1, n+1
		read(99,*) M(i)
	end do
	do i = 1, n+1
                read(99,*) b(i)
        end do

	call fp(M,b,J)
        open (unit = 2, file = "loss_inexact_line_search.txt", action="write",status="replace")
        write(2,*) J
        close(2)
end program driver_forward


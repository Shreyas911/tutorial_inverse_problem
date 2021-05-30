program driver_A
	
	use forward_tgt, n => nx, fp => forward_problem_hessian_action !! Alias to a local variable

	implicit none 

	real(8) :: M0, M1, M0d = 0., M1d = 0.
	real(8), dimension(n+1) :: h_capital_final = 0., h_capital_finald = 0.
	integer :: ii

	! opening the state file for reading
        open (99, file = 'state.txt', status = 'old')
	read(99,*) M0
	read(99,*) M1
	close(99)
        !! Tangent Linear Model


        open (100, file = 'direction_A_action.txt', status = 'old')
        read(100,*) M0d
        read(100,*) M1d
	close(100)
        !! TLM
        call forward_problem_hessian_action_d(M0,M0d,M1,M1d,h_capital_final,h_capital_finald)


	open (unit = 1, file = "A_action.txt", action="write",status="replace")      
        
	do ii = 1, n+1
	write(1,*) h_capital_finald(ii) 
	end do

	close(1)

end program driver_A


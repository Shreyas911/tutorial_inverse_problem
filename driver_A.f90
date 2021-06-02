program driver_A
	
	use forward_tgt, n => nx, fp => forward_problem_hessian_action !! Alias to a local variable

	implicit none 

	real(8), dimension(n+1) :: M, b, Md = 0., bd = 0.
	real(8), dimension(n+1) :: h_capital_final = 0., h_capital_finald = 0.
	integer :: ii

	! opening the state file for reading
        open (99, file = 'state.txt', status = 'old')
	do ii = 1, n+1
		read(99,*) M(ii)
	end do
	do ii = 1, n+1
		read(99,*) b(ii)
	end do

	close(99)
	
        !! Tangent Linear Model


        open (100, file = 'direction_A_action.txt', status = 'old')
        
	do ii = 1, n+1
		read(100,*) Md(ii)
	end do

	do ii = 1, n+1
        	read(100,*) bd(ii)
	end do
	close(100)
	
        !! TLM
        call forward_problem_hessian_action_d(M,Md,b,bd,h_capital_final,h_capital_finald)


	open (unit = 1, file = "A_action.txt", action="write",status="replace")      
        
	do ii = 1, n+1
	write(1,*) h_capital_finald(ii) 
	end do

	close(1)

end program driver_A


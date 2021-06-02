program driver_AT
	
	use forward_diff, n => nx, fp => forward_problem_hessian_action !! Alias to a local variable

	implicit none 

	real(8), dimension(n+1) :: M, Mb = 0., b, bb = 0.
	real(8), dimension(n+1) :: h_capital_final = 0., h_capital_finalb = 0.
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
        

	!! Adjoint model


        open (100, file = 'direction_AT_action.txt', status = 'old')
        do ii = 1, n+1
		read(100, *) h_capital_finalb(ii) 
	end do
	close(100)
        !! TLM
        call forward_problem_hessian_action_b(M,Mb,b,bb,h_capital_final,h_capital_finalb)


	open (unit = 1, file = "AT_action.txt", action="write",status="replace")      
        
	do ii = 1, n+1
		write(1,*) Mb(ii)
	end do
	do ii = 1, n+1
		write(1,*) bb(ii)
        end do

	close(1)

end program driver_AT


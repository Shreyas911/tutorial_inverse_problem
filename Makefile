EXEC := adjoint
SRC  := $(wildcard *.f90)
OBJ  := $(patsubst %.f90, %.o, $(SRC))
# NOTE - OBJ will not have the object files of c codes in it, this needs to be improved upon.
# Options	
F90 	:= gfortran
CC 		:= gcc
POP_PUSH:= ./pop_push

# Rules

$(EXEC): adStack.o forward_b.o driver.o
		$(F90) -o $@ $^

%.o: %.f90 
		$(F90) -c $<

driver.o: forward_b.f90 forward_diff.mod
forward_diff.mod: forward_b.o 

adStack.o : 
		$(CC) -c $(POP_PUSH)/adStack.c

forward_b.f90: forward.f90 forward.o
		tapenade -reverse -head "forward_problem(J)/(M0, M1)" forward.f90
# Useful phony targets

.PHONY: clean

clean:
	$(RM) $(EXEC) *.o $(MOD) $(MSG) *.msg *.mod *_db.f90 *_b.f90 *_d.f90 *~

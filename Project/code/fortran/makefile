FC = gfortran 
FFLAGS = -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=1 -g3 -fcheck=all -fbacktrace -fdefault-real-8 -fdefault-double-8

OBJ = linear_solve.o read_data.o write_data.o ge_elim.o

linear_solve: $(OBJ)
	$(FC) -o $@ $^ $(FFLAGS)

%.o: %.f90
	$(FC) -c $< $(FFLAGS)

.PHONY: clean

clean:
	rm -f *.o *.mod *~

OBJECTS = ge_elim.o\
	read_data.o\
	write_data.o\
	linear_solve.o

MODULES = ge_elim.mod\
 read_data.mod\
  write_data.mod

.PHONY: clean

linear_solve: $(OBJECTS)
	gfortran $(OBJECTS) -o linear_solve
%.o: %.f90
	gfortran -c $<
%.mod: %.f90
	gfortran -c $<
clean:
	@rm -f $(OBJECTS) $(MODULES) linear_solve
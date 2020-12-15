import os
import numpy as np
import matplotlib.pyplot as plt

print ("Welcome! We will now solve equations (1)-(5) using some Fortran code.")

#Functions
def generate_input(MatrixFile,VectorFile):
    os.chdir("../fortran/")
    if os.path.exists("A.dat"):
        os.remove("A.dat")
    if os.path.exists("b.dat"):
        os.remove("B.dat")
    os.system("cp {} A.dat".format(MatrixFile))
    os.system("cp {} b.dat".format(VectorFile))

#Executables
print ("We will now solve the five cases in equations (1)-(5)")
print ("First we solve case(1)")
generate_input("A_1.dat","b_1.dat")
os.system("./linear_solve 1")

print ("Now, we solve case(2)")
generate_input("A_2.dat","b_2.dat")
os.system("./linear_solve 2")


print ("Now, we solve case(3)")
generate_input("A_3.dat","b_3.dat")
os.system("./linear_solve 3")


print ("Now, we solve case(4)")
generate_input("A_4.dat","b_4.dat")
os.system("./linear_solve 4")




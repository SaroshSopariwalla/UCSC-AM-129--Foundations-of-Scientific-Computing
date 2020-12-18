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
        os.remove("b.dat")
    os.system("cp {} A.dat".format(MatrixFile))
    os.system("cp {} b.dat".format(VectorFile))

#Executables
##Section 1
print ("We will now solve the five cases in equations (1)-(5)")
for i in range(1,5):
    print("We solve case({})".format(i))
    generate_input("A_{}.dat".format(i),"b_{}.dat".format(i))
    os.system("make --silent")
    os.system("./linear_solve {} 1".format(i))
    os.system("make clean")
    print("*************************************************")

print ("We solve the final unique case (5) where A_4 X = B")
#We use the fact that A_4.dat is already stored in A.dat from last case
os.system("make --silent")
os.system("./linear_solve 4 5")
os.system("make clean")
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

## Section 2
print("*************************************************")
print ("We now check the accuracy of our results")
for i in range(1,5):
    print("Case {}".format(i))
    A = np.loadtxt("A_{}.dat".format(i),skiprows=1)
    b = np.loadtxt("b_{}.dat".format(i),skiprows=1)
    x = np.linalg.solve(A,b) #Proper Solution
    xpiv = np.loadtxt("x_piv{}.dat".format(i))
    xnopiv = np.loadtxt("x_nopiv{}.dat".format(i))
    if np.allclose(x,xpiv):
        print("PASS (METHOD: PIVOT)")
    else:
        print("FAIL (METHOD: PIVOT")
    if np.allclose(x,xnopiv):
        print("PASS (METHOD: REGULAR) ")
    else:
        print("FAIL (METHOD: REGULAR)")
    print("---------------------------------")

print("Special Case: Case 5")
print("We have already seen regular gaussian elimination fails so we only compare the result from partial pivoting.")
FortranSol=np.loadtxt("X.dat")
RHS = np.loadtxt("Y.dat",skiprows=1)
NPSol = np.linalg.solve(A,RHS)
np.allclose(FortranSol,NPSol)
if np.allclose(FortranSol,NPSol):
    print("PASS (METHOD: PIVOT)")
else:
    print("FAIL (METHOD: PIVOT)")

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

## Section 3
for i in range(1,4):
    os.chdir("../fortran")
    A = np.loadtxt("A_{}.dat".format(i),skiprows=1)
    A = np.matrix(A)
    plt.matshow(A)
    os.chdir("../pyRun")
    plt.title("Matrix Plot of A_{}".format(i))
    plt.savefig("Matrix A_{} Plot.jpg".format(i))

    os.chdir("../fortran")
    b = np.loadtxt("b_{}.dat".format(i),skiprows=1)
    b = np.matrix(b)

    x = np.loadtxt("x_piv{}.dat".format(i))
    x = np.matrix(x)

    os.chdir("../pyRun")

    fig = plt.figure()
    ax1 = fig.add_subplot(121)
    ax2 = fig.add_subplot(122)
    ax1.title.set_text('b_{} vector'.format(i))
    ax2.title.set_text('x_{} vector'.format(i))

    ax1.matshow(b)
    ax2.matshow(x)
    plt.savefig("x_{} and b_{} Plot.jpg".format(i,i))
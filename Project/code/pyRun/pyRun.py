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
os.system("make --silent")
os.system("./linear_solve 1 1")
os.system("make clean")

print("*************************************************")

print ("Now, we solve case(2)")
generate_input("A_2.dat","b_2.dat")
os.system("make --silent")
os.system("./linear_solve 2 1")
os.system("make clean")

print("*************************************************")

print ("Now, we solve case(3)")
os.system("make --silent")
generate_input("A_3.dat","b_3.dat")
os.system("./linear_solve 3 1")
os.system("make clean")

print("*************************************************")

print ("Now, we solve case(4)")
generate_input("A_4.dat","b_4.dat")
os.system("make --silent")
os.system("./linear_solve 4 1")
os.system("make clean")

print("*************************************************")

print ("We solve the final unique case (5) where A_4 X = B")
#We use the fact that A_4.dat is already stored in A.dat from last case
os.system("make --silent")
os.system("./linear_solve 4 5")
os.system("make clean")

print("*************************************************")
print ("We now check the accuracy of our results")
print("Case 1")
os.chdir("../fortran/")
A = np.loadtxt("A_1.dat",skiprows=1)
b = np.loadtxt("b_1.dat",skiprows=1)
x = np.linalg.solve(A,b) #Proper Solution
xpiv = np.loadtxt("x_piv1.dat")
xnopiv = np.loadtxt("x_nopiv1.dat")
if np.allclose(x,xpiv):
    print("PASS (METHOD: PIVOT)")
else:
    print("FAIL (METHOD: PIVOT")
if np.allclose(x,xnopiv):
    print("PASS (METHOD: REGULAR) ")
else:
    print("FAIL (METHOD: REGULAR)")
print("---------------------------------")
print("Case 2")
os.chdir("../fortran/")
A = np.loadtxt("A_2.dat",skiprows=1)
b = np.loadtxt("b_2.dat",skiprows=1)
x = np.linalg.solve(A,b) #Proper Solution
xpiv = np.loadtxt("x_piv2.dat")
xnopiv = np.loadtxt("x_nopiv2.dat")
if np.allclose(x,xpiv):
    print("PASS (METHOD: PIVOT)")
else:
    print("FAIL (METHOD: PIVOT")
if np.allclose(x,xnopiv):
    print("PASS (METHOD: REGULAR) ")
else:
    print("FAIL (METHOD: REGULAR)")
print("---------------------------------")
print("Case 3")
A = np.loadtxt("A_3.dat",skiprows=1)
b = np.loadtxt("b_3.dat",skiprows=1)
x = np.linalg.solve(A,b) #Proper Solution
xpiv = np.loadtxt("x_piv3.dat")
xnopiv = np.loadtxt("x_nopiv3.dat")
if np.allclose(x,xpiv):
    print("PASS (METHOD: PIVOT)")
else:
    print("FAIL (METHOD: PIVOT")
if np.allclose(x,xnopiv):
    print("PASS (METHOD: REGULAR) ")
else:
    print("FAIL (METHOD: REGULAR)")
print("---------------------------------")
print("Case 4")
A = np.loadtxt("A_4.dat",skiprows=1)
b = np.loadtxt("b_4.dat",skiprows=1)
x = np.linalg.solve(A,b) #Proper Solution
xpiv = np.loadtxt("x_piv4.dat")
xnopiv = np.loadtxt("x_nopiv4.dat")
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


os.chdir("../fortran")
A1 = np.loadtxt("A_1.dat",skiprows=1)
A1 = np.matrix(A1)
plt.matshow(A1)
os.chdir("../pyRun")
plt.title("Matrix Plot of A_1")
plt.savefig("A_1 Plot.png")
os.chdir("../fortran")
b1 = np.loadtxt("b_1.dat",skiprows=1)
b1 = np.matrix(b1)
x1 = np.loadtxt("x_piv1.dat")
x1 = np.matrix(x1)
os.chdir("../pyRun")


fig=plt.figure()
ax1 = fig.add_subplot(121)
ax2 = fig.add_subplot(122)
ax1.title.set_text('b_1 vector')
ax2.title.set_text('x_1 vector')
ax1.matshow(b1)
ax2.matshow(x1)
plt.savefig("x_1 and b_1 Plot.png")


os.chdir("../fortran")
A2 = np.loadtxt("A_2.dat",skiprows=1)
A2 = np.matrix(A2)
plt.matshow(A2)
os.chdir("../pyRun")
plt.title("Matrix Plot of A_2")
plt.savefig("A_2 Plot.png")
os.chdir("../fortran")
b2 = np.loadtxt("b_2.dat",skiprows=1)
b2 = np.matrix(b2)
x2 = np.loadtxt("x_piv2.dat")
x2 = np.matrix(x1)
os.chdir("../pyRun")


fig=plt.figure()
ax1 = fig.add_subplot(121)
ax2 = fig.add_subplot(122)
ax1.title.set_text('b_2 vector')
ax2.title.set_text('x_2 vector')
ax1.matshow(b2)
ax2.matshow(x2)
plt.savefig("x_2 and b_2 plot.png")

os.chdir("../fortran")
A3 = np.loadtxt("A_3.dat",skiprows=1)
A3 = np.matrix(A3)
plt.matshow(A3)
os.chdir("../pyRun")
plt.title("Matrix Plot of A_3")
plt.savefig("A_3 Plot.png")
os.chdir("../fortran")
b3 = np.loadtxt("b_3.dat",skiprows=1)
b3 = np.matrix(b3)
x3 = np.loadtxt("x_piv3.dat")
x3 = np.matrix(x3)
os.chdir("../pyRun")


fig=plt.figure()
ax1 = fig.add_subplot(121)
ax2 = fig.add_subplot(122)
ax1.title.set_text('b_3 vector')
ax2.title.set_text('x_3 vector')
ax1.matshow(b3)
ax2.matshow(x3)
plt.savefig("x_3 and b_3 plot.png")



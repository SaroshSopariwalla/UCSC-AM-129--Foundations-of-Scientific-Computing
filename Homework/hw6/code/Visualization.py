import matplotlib.pyplot as plt
import numpy as np
Data = np.loadtxt('dist.dat')
xValues = []
ProbabilityValues=[]
for entry in Data:
    xValues.append(entry[0])
    ProbabilityValues.append(entry[1])

def S(x):
    ps = 0.75*np.exp(-np.abs(x-0.25))
    return ps/np.sum(ps)


plt.figure(figsize=(12,8))
plt.plot(xValues,ProbabilityValues,'k-', label="$P_{Part}(x)$")
plt.grid()
plt.title("Stationary PMF of Particle Position (N=200, BIAS=0.001)")
plt.xlabel("x")
plt.ylabel("Probability")
plt.plot(xValues,S(np.array(xValues)),'r--',label="$S(x)$")
plt.legend(loc='upper right');
plt.savefig('PMF Graph')






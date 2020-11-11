#!/usr/bin/env python
# coding: utf-8

# # Plotting the Codon Histogram

# ## Step 1

# In[1]:


def SubStringCounter (string):            #Input must be a string
    CounterDictionary={}                  #Initialize an empty dictionary
    for i in range(len(string)-2):        #Loop through string; stop when at third to last letter
        piece=string[i:i+3]               #Select the group of three letters
        if piece in CounterDictionary:
            CounterDictionary[piece]=CounterDictionary[piece]+1  #If piece in Dictionary Increase Count by 1
        else:
            CounterDictionary[piece]=1                           #If piece not in Dictionary Define it and call the count 1
    return CounterDictionary              #Return the Dictionary
    
    


# ## Step 2

# In[2]:


if __name__=="__main__":                                    #Open the gene sequence and store it into the string geneStr
    # Open genome
    with open('sarsCov2Sequence.txt','r') as geneFile:
        geneStr = geneFile.readline()


# ## Steps 3,4

# In[3]:


CodonDictionary = SubStringCounter(geneStr)


# In[4]:


import numpy as np
import matplotlib.pyplot as plt
plt.rcParams.update({'font.size': 22})

keys = CodonDictionary.keys()
values = CodonDictionary.values()

plt.figure(figsize=(25,15))
plt.bar(keys, values);
plt.grid()
plt.xlabel("Codon");
plt.ylabel("Frequency");
plt.title("Codon Frequency in SARS-CoV-2");
plt.xticks(rotation=90);
plt.savefig('histogram.png')
plt.show()


# # Plotting the Base Pair Density

# In[5]:


def baseDensity(geneStr, nWind=200):
    a = np.zeros(len(geneStr)-nWind)
    t = np.zeros(len(geneStr)-nWind)
    c = np.zeros(len(geneStr)-nWind)
    g = np.zeros(len(geneStr)-nWind)
    for i in range(len(geneStr)-nWind):
        a[i]=(geneStr[i:i+nWind].count('a') ) / (nWind)
        t[i]=(geneStr[i:i+nWind].count('t') ) / (nWind)
        c[i]=(geneStr[i:i+nWind].count('c') ) / (nWind)
        g[i]=(geneStr[i:i+nWind].count('g') ) / (nWind)
    return a,t,c,g


# In[6]:


a,t,c,g = baseDensity(geneStr)


# In[7]:


plt.figure(figsize=(25,15))
plt.plot(a)
plt.plot(t)
plt.plot(c)
plt.plot(g)
plt.grid()
plt.xlabel("Sequence Position");
plt.ylabel("Fraction per Window");
plt.title("Density of Base Pairs Through Gene Sequence");
plt.legend(['A','T','C','G'])
plt.savefig('density.png')
plt.show()


# In[ ]:





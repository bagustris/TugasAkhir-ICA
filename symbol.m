source : ftp://ftp.cnl.salk.edu/pub/tony/sep96.public

sweep:    how many times you've gone thru the data
P:        how many timepoints in the data
N:        how many input (mixed) sources there are
M:        how many outputs you have
L:        learning rate
B:        batch-block size (ie: how many presentations per weight update.)
t:        time index of data
sources:  NxP matrix of the N sources you read in
x:        NxP matrix of mixtures
u:        MxP matrix of hopefully unmixed sources
a:        NxN mixing matrix
w:        MxN unmixing matrix (actually w*wz is the full unmixing matrix
          in this case)
wz:       zero-phase whitening: a matrix used to remove 
          correlations from between the mixtures x. Useful as a 
          preprocessing step.
noblocks: how many blocks in a sweep;
oldw:     value of w before the last sweep
delta:    w-oldw
olddelta: value of delta before the last sweep
angle:    angle in degrees between delta and olddelta
change:   squared length of delta vector 
Id:       an identity matrix
permute:  a vector of length P used to scramble the time order of the
          sources for stationarity during learning.

INITIAL w ADVICE: identity matrix is a good choice, since, for prewhitened
data, there will be no distracting initial correlations, and the output
variances will be nicely scaled so <uu^T>=4I, right size to fit the 
logistic fn (more or less).

LEARNING RATE ADVICE: 
N=2: L=0.01 works
N=8-10: L=0.001 is stable. Run this till the 'change' report settles
down, then anneal a little. L=0.0005,0.0002,0.0001 etc, a few passes
(= a few 10,000's of data vectors) each pass.
N>100: L=0.001 works well on sphered image data.

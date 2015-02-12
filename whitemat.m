% WHITEMAT - takes an NxP signal, s, and calculates the mean
%   vector, mx, and the whitening matrix, wz, of size N*m, from 
%   p randomly chosen examples.
%   Used to do spatio-temporal whitening, N signals, m time points.

function [wz,mx]=whitemat(s,m,p)
  N=size(s,1); P=size(s,2);
  perm=randperm(P-m);
  start=perm(1:p);   % p random starting points
  xx=zeros(N*m,p);
  fprintf('reshaping\n');
  for t=1:p,
    xx(:,t)=reshape(s(:,start(t):start(t)+m-1)',N*m,1);
  end;
  fprintf('sphereing\n');
  mx=mean(xx');
  xx=xx-(ones(p,1)*mx)';
  c=cov(xx');
  wz=2*inv(sqrtm(c));


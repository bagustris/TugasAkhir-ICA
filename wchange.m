% wchange.m : a funtion to calculate the change of weighting in training
% source : tp://ftp.cnl.salk.edu/pub/tony/sep96.public

function [change,delta,angle]=wchange(w,oldw,olddelta)
  [M,N]=size(w); delta=reshape(oldw-w,1,M*N);
  change=delta*delta';
  angle=acos((delta*olddelta')/sqrt((delta*delta')*(olddelta*olddelta')));

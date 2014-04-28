clear all; close all; clc;
y=wavread('bearing');
x=wavread('unbalance');
%z=
%v=wavread
subplot(211); plot(y(1:50000));
subplot(212); plot(x(1:50000));
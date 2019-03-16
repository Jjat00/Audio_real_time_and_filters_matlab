function [a,b]=getbutter(n,fc,fs,tx)
[z,p,k] = butter(n,fc*2/fs,tx);
[b,a] = tfdata(zpk(z,p,k,1/fs),'v');
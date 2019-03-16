function hw=pasabanda(n,f1,f2,fs)
d1=floor(n*f1/fs);
d2=floor(n*(f2-f1)/fs);
if d1<1
    d1=1;
    hw=[zeros(1,d1),ones(1,d2),zeros(1,n-d2-d1)];
end

hw=[zeros(1,d1),ones(1,d2),zeros(1,n-d2-d1)];

hw=hw+flip(hw);
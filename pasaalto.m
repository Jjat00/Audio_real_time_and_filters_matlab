function hw=pasaalto(n,fc,fs)
nfc=floor(n*fc/fs);
hw=[ones(1,nfc+1),zeros(1,n-nfc-1)];
hw=hw+flip(hw);
hw=xor(hw,ones(1,n));
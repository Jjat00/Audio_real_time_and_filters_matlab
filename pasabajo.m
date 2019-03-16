function hw=pasabajo(n,fc,fs)
nfc=floor(n*fc/fs);
hw=[ones(1,nfc),zeros(1,n-nfc)];
hw=hw+flip(hw);
function [f0,Am,f,m,fase]=getFrec(y,fs)
    L = length(y);
    nfft = 2.^nextpow2(L);
    Y = fft(y,nfft)./nfft;
    [~,i]=max(Y);
    f = fs*(0:1:nfft/2-1)/nfft;
    Am1 =abs(Y(1:nfft/2));
    Am1(2:end)=2*Am1(2:end);
    if i < 513
        f0 = f(i);
        Am =(max(y)-min(y))/2;
    else
        f0 = 0;
        Am = 0;
       
    end
     fase = angle(Y(1:nfft/2)/nfft)*180/pi;
    m =Am1;
    
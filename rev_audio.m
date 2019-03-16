file = uigetfile
info = audioinfo(file);
[y,Fs] = audioread(file);

f = waitbar(0.1,'Please wait...');
waitbar(.33,f,'Loading your data');
pause(1);
waitbar(.44,f,'Processing your data');
rev =  flipud(y)
waitbar(.67,f,'Processing your data');
pause(1);
waitbar(1,f,'Finishing');
close(f)
st = 0;
player = audioplayer(rev,Fs);
tic;
while toc < info.Duration
    play(player);
    st = app.s
end


info = audioinfo('En La Ciudad De La Furia.mp3')
[y,Fs] = audioread('En La Ciudad De La Furia.mp3');
yMono = sum(y, 2) / size(y, 2);

player = audioplayer(yMono,Fs);
player1 = audioplayer(y,Fs);
play(player);
pause(50);
pause(player);
play(player1);
pause(50);
pause(player1);

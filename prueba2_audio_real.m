%    ||||||||   || |||||| ||||||
%       ||      || ||  ||   ||
%       ||      || ||||||   ||
%    |||||   ||||| ||  ||   ||
%  Author: Jaime Jjat 
%  Date: marzo de 2019
%  e-mail: userjjat00@gmail.edu.co 
%  Youtube: https://www.youtube.com/channel/UC_SdV1G11_uYdfCDWrbLVWg/videos?view_as=subscriber

%% Create input and output objects
deviceReader = audioDeviceReader;
deviceWriter = audioDeviceWriter('SampleRate',deviceReader.SampleRate);
%% Code for stream processing
disp('Begin Signal Input...')
tic;
stop = 0;
scope = dsp.TimeScope(2,...
    'SampleRate',deviceReader.SampleRate,...
    'TimeSpan',1,...
    'BufferLength',1.5e6,...
    'YLimits',[-0.3,0.3]);

app.UIAxes.XLim = [0 deviceReader.SampleRate*0.15];
app.UIAxes.YLim = [0 0.05];
app.UIAxes.BackgroundColor = [0.15 0.15 0.15];
app.UIAxes.XColor = [1 1 1];   
app.UIAxes2.XLim = [0 deviceReader.SampleRate*0.1];
app.UIAxes2.BackgroundColor = [0.15 0.15 0.15];
app.UIAxes2.XColor = [1 1 1];
app.UIAxes2.YLim = [-180 180];
while stop ~= 1 
    stop = app.s
    modo = app.m
    mySignal = deviceReader();
        switch app.g
            case 'No Graphic'
                 [f0,Am,f,m,fase]=getFrec(mySignal,deviceReader.SampleRate);
                 app.Gauge.Value = app.v*Am;
                 if f0 ~= 0              
                            Amplitud = num2str(Am);
                            app.Label_2.Text = Amplitud;
                            Frecuencia = num2str(f0);
                            app.Label.Text = Frecuencia;
                 end                

        end

    switch app.f
       case 'Eq. Dif'
          %switch app.m
         if app.low == 1 
              [A,B] = getbutter(4,500,deviceReader.SampleRate,'low'); 
         elseif app.band == 1
              B = [0.0675	0 -0.1349 0	0.0675];
              A = [1	-1.9425	2.1192	-1.2167	0.4128];
         elseif app.high == 1
              B = [0.2569	-0.7707	0.7707	-0.2569];
              A = [1 -0.5772 0.4218 -0.0563];
         else
              A = [str2num(app.a)];
              B = [str2num(app.b)]; 
          end  
          [myProcessedSignal1,A,B] = IR(mySignal,A,B);              
          deviceWriter(app.v*myProcessedSignal1');
          switch app.g
                case 'Magnitude'
                    [f0,Am,f,m,fase]=getFrec(myProcessedSignal1',deviceReader.SampleRate);   
                    app.Gauge.Value = app.v*Am;
                    if f0 ~= 0              
                        stem(app.UIAxes,f,m,'.','Color',[0.9 0.132 0.356]); 
                    end
                 case 'Phase'
                     app.Gauge.Value = app.v*Am;
                    [f0,Am,f,m,fase]=getFrec(myProcessedSignal1',deviceReader.SampleRate);
                    plot(app.UIAxes2,f',fase); 
           end
               scope(app.v*mySignal(:,1),app.v*myProcessedSignal1');
       case 'Res. Frec'
          s=fft(mySignal(:,1));
          if app.low == 1 
              hw=pasabajo(length(s),800,deviceReader.SampleRate);    
          elseif app.band == 1
              hw=pasabanda(length(s),800,3500,deviceReader.SampleRate);
          elseif app.high == 1
              hw=pasaalto(length(s),3500,deviceReader.SampleRate);         
          else 
             hw=pasabajo(length(s),500,deviceReader.SampleRate);   
          end            
          w=s.*hw';
          y2= real(ifft(w))+imag(ifft(w));
          deviceWriter(app.v*y2);
          scope(app.v*mySignal(:,1),app.v*y2);
          switch app.g
                case 'Magnitude'
                [f0,Am,f,m,fase]=getFrec(y2,deviceReader.SampleRate);   
                app.Gauge.Value = app.v*Am;
                    if f0 ~= 0              
                        stem(app.UIAxes,f,m,'.','Color',[0.9 0.132 0.356]); 
                    end
                 case 'Phase'
                     app.Gauge.Value = app.v*Am;
                    [f0,Am,f,m,fase]=getFrec(y2,deviceReader.SampleRate);
                    plot(app.UIAxes2,f',fase);
           end
       case 'No filter'
          switch app.m 
              case 'Estereo'
                deviceWriter(app.v*mySignal);
              case 'Mono'
                deviceWriter(app.v*mySignal(:,1));              
          end
           switch app.g
                case 'Magnitude'
                [f0,Am,f,m,fase]=getFrec(mySignal,deviceReader.SampleRate);   
                app.Gauge.Value = app.v*Am;
                    if f0 ~= 0              
                        stem(app.UIAxes,f,m,'.','Color',[0.9 0.132 0.356]); 
                    end
                 case 'Phase'
                    [f0,Am,f,m,fase]=getFrec(mySignal,deviceReader.SampleRate);
                    app.Gauge.Value = app.v*Am;
                    plot(app.UIAxes2,f',fase);
           end 
          scope(app.v*mySignal(:,1),app.v*mySignal);            
    end
    
end
disp('End Signal Input');

release(deviceReader);
release(deviceWriter);
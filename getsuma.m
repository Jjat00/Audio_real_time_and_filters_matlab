function Y=getsuma(y1,y2)
ny1=length(y1);
ny2=length(y2);
if ny1>ny2
    y2=[y2,zeros(1,ny1-ny2)];
else
    y1=[y1,zeros(1,ny2-ny1)];
end
Y=y1+y2;
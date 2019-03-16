function [y,A,B]=getY(x,A,B)

    for i = 1:length(x)
    
        B(2,1:end)=[x(i),B(2,1:end-1)];
        y1=sum(A(1,2:end).*A(2,1:end-1),2)/A(1);
        x1=sum(B(1,1:end).*B(2,1:end),2)/A(1);
        y=-y1+x1;
        A(2,1:end)=[y,A(2,1:end-1)];
        
    end
function [y,A,B]=IR(x,A,B)
na=size(A);
nb=size(B);
y=zeros(1,length(x));
if(na(1)~=2 || nb(1)~=2)
    A=[A;zeros(1,na(2))];
    B=[B;zeros(1,nb(2))];
   
end
for i=x'

B(2,1:end)=[i,B(2,1:end-1)];

y1=sum(A(1,2:end).*A(2,1:end-1),2)/A(1);
x1=sum(B(1,1:end).*B(2,1:end),2)/A(1);
y=[y(2:end),-y1+x1];
A(2,1:end)=[y(end),A(2,1:end-1)];

end
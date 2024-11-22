function X=bin2frac(b,N,Nint)
% ba=b(1:Nint);
% bf=b(Nint+1:end);
s=1;%% sign
if (b(1)==logical(1))
    s=-1;
    b(2:end)=not( b(2:end));
end
b(2:Nint+1);
b(2:Nint+1).*2.^[Nint-1:-1:0];
a=sum(b(2:Nint+1).*2.^[Nint-1:-1:0]);
% disp('----------------------');
b(Nint+2:end);
b(Nint+2:end).*2.^(-[1:N-Nint-1]);
b=sum(b(Nint+2:end).*2.^(-[1:N-Nint-1]));
X=s*(a+b);
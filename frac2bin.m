function [ai,fi,ba,bf,baf,baf_2Comp]=frac2bin(X,N,Nint)
a=abs(fix(X)); ai=a;
f=abs(X)-a; fi=f;
Nsign=1;
if X<0.0
    bs=logical(1);
else
    bs=logical(0);
end
ba=logical(ones(1,Nint));
bf=logical(ones(1,N-Nint-Nsign));
for i=Nint-1:-1:0
    if (a>=2^i)
        ba(i+1)=logical(1);
        a=a-2^i;
    else
        ba(i+1)=logical(0);
    end
end
ba=ba(end:-1:1);
for i=1:N-Nint-Nsign
    if (f>=2^-i)
        bf(i)=logical(1);
        f=f-2^-i;
    else
        bf(i)=logical(0);
    end
end
bx=[ba bf];
bx_2Comp=bx;
if X<0.0
    i=N-1; T=true;
   while i<=N-1 && T
        if (bx(i)==1)
            T=false;
            bx_2Comp(1:i-1)=not(bx_2Comp(1:i-1));
        end
        i=i-1;
   end
            
    

end
baf=[bs bx];
 baf_2Comp=[bs  bx_2Comp];    
end

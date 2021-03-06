function [A,Gos] = Erlang_Bino_Part1(N,K,Y,H)
Au = (H * Y)/60 ;
A = K * Au ;
if(K>N)
    if(Au > 1)
        Gos = 100;
    else

index = 1;
Compute=zeros(1,K-N-1);
for i=N:K-1
    Compute(index)= nchoosek(K-1,i);
    index = index+1;
end
disp(Compute);
Y=Compute.*Au.^([N:K-1]).*(1-Au).^(K-1.-[N:K-1]);
disp(Y);
ErlangBino = @(Au)(sum(Compute.*Au.^([N:K-1]).*(1-Au).^(K-1.-[N:K-1]))); %% Erlang Bino equation
Gos = ErlangBino(Au);
Gos = Gos*100;
    end
else
    Gos =0;
end
end
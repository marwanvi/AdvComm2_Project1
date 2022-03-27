function [A] = Erlang_Binomial_Part2(N,Gos,K)
Gos=Gos/100;
if(K>N)
Compute=zeros(1,K-N-1);
index= 1;
for i=N:K-1
    Compute(index)= nchoosek(K-1,i);
    index = index+1;
end
ErlangBino = @(Au)(sum(Compute.*Au.^([N:K-1]).*(1-Au).^(K-1.-[N:K-1]))); %% Erlang Bino equation
itterator=Erlang_B_Part2(N,Gos*100)/K;
Au = fsolve(@(Au) ErlangBino(Au)-Gos, itterator);
while(Au < 0)
    itterator=itterator/2;
    Au = fsolve(@(Au) ErlangBino(Au)-Gos,itterator);
end    
disp(Au);
A = Au*K;
disp(A);
end
end
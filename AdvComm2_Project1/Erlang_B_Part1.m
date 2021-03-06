function [A,Gos] = Erlang_B_Part1(N,K,Y,H)
if(K>N)
Au = (H * Y)/60 ;
A = K * Au ;
ErlangB = @(A) (A^N/factorial(N))/sum(A.^([0:N])./cumprod([0,0:N-1]+1)); % ErlangB equation
Gos = ErlangB(A);
Gos = Gos * 100;
else
    Gos = 0;
    Au = (H * Y)/60 ;
    A = K * Au ;
end
    
end
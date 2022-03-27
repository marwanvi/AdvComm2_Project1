function [A,Gos] = Erlang_C_Part1(N,K,Y,H)
Au = (H * Y)/60 ;
A = K * Au ;
if(K>N)
ErlangC = @(A)((N*A^(N)/(factorial(N)*(N-A)))/((N*A^(N)/(factorial(N)*(N-A)))+sum(A.^([0:N-1])./cumprod([0,0:N-2]+1))));
Gos = ErlangC(A);
Gos = Gos * 100;
else
    Gos =0;
end
end
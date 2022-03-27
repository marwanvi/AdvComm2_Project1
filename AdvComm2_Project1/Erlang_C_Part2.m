function [A] = Erlang_C_Part2(N,Gos)
Gos = Gos/100;
ErlangC = @(A)((N*A^(N)/(factorial(N)*(N-A)))/((N*A^(N)/(factorial(N)*(N-A)))+sum(A.^([0:N-1])./cumprod([0,0:N-2]+1)))); %% Erlang C equation
A = fsolve(@(A) ErlangC(A)-Gos, N+1);
disp(A);
end
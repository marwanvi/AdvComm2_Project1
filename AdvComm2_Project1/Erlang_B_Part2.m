function [A] = Erlang_B_Part2(N,Gos)
Gos = Gos/100;
ErlangB = @(A) (A^N/factorial(N))/sum(A.^([0:N])./cumprod([0,0:N-1]+1)); % ErlangB equation
A = fsolve(@(A) ErlangB(A)-Gos, N);
disp(A);
end
function [A] = Erlang_Binomial_Part2_Initial_guess(N,Gos,K)
Gos=Gos/100;   
%disp(Au);
syms I Au
ACell = solve( Gos == symsum(nchoosek(K-1,I) * Au^I * (1-Au)^(K-1-I),I,N,K-1) , Au);
Ar = real(double(ACell));
Au = Ar(1);
if Au < 0
    Au = Ar(2);
end
A = Au * K;
end

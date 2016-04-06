function [ B, nextmove, j ] = iset( A, nextmove, m, i )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
L = length(A);
perm = oneperm(L, i);
indices = find(perm<=m);
indices
[j, p] = min(nextmove);
nextmove(p) = nextmove(p) + factorial(L - indices(p));
nextmove = min(nextmove, i + factorial(L - indices));
B = A(indices);
end


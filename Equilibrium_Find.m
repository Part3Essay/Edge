function [ p, q ] = Equilibrium_Find( S, e )
%Takes the set of dominating losing sets S and finds the
%Nash equilibrium strategies p and q for the Hider and
%Searcher. p is over losing sets, q is over edges.
%Create payoff matrix
A = ones(e, numel(S));
for i = 1:numel(S)
    set = S{i};
    for j = set
        A(j, i) = 0;
    end
end
%solve the Searcher's optimisation problem and use the
%Lagrange multipliers to find Hider strategy
[u, value] = linprog(ones(1, numel(S)), -A, -ones(e, 1), [], [], zeros(1, numel(S)), [], [], optimset('Display', 'off'));
v = linprog(-ones(1, e), A', ones(numel(S), 1), [], [], zeros(1, e), [], [], optimset('Display', 'off'));
p = u/value;
q = v/value;
end
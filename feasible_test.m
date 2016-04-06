function [ w, weight ] = feasible_test( B, h, e, n, ignore )
%Maximises the weight on the graph such that the losing edges
%are exactly those in 'set'. Outputs the associated weighting and the
%weight attained.
%Problem is minimise -1'w subject to Bw <= 1

%set only has numbered edges, need the adjacent vertices
H(1:n) = h;
J(1:e) = h-1;
f = -ones(1, n);
f(ignore) = 0;
[w, weight] = linprog(f, B, J, [], [], zeros(1, n), H, [], optimset('Display', 'off'));
weight = -weight;
end


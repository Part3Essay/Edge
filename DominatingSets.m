function [ S, W ] = DominatingSets( M, h, ignore )
%Takes M the adjacency matrix and finds the dominating winning
%sets of edges
S = {};
W = {};
%simplify M
M = reduce(M, length(M(1, :)));
%count number of edges and vertices
e = length(find(M))/2;
n = length(M(1, :));
%list of edges we need to consider, will update
F = 1:e;
%define the contraint matrix used later
A = zeros(e, n);
N = tril(M);
Indices = find(N);
for k = 1:e
    index = Indices(k);
    i = mod(index, n);
    if i == 0;
        i = n;
    end
    j = ceil(index/n);
    A(k, i) = 1;
    A(k, j) = 1;
end
%first check if can guarantee win
[w, weight] = feasible_test(A, h, e, n, ignore);
if weight >= h-0.0001
    S = {[]};
    W = {w};
else
    for i = 1:e
        f = length(F);
        c = nchoosek(f, i);
        %create smallest number with exactly i 1s in binary expansion
        num = 2^i - 1;
        temp = [];
        for k = 1:c
            dom = 0;
            set = F(find(dec2bin(num, f) - '0'));
            for r = 1:numel(S)
                s = S{r};
                if all(ismember(set, s)) == 1
                    dom = 1;
                    break
                end
            end
            if dom == 0
                B = A;
                B(set, :) = zeros(length(set), n);
                [w, weight] = feasible_test(B, h, e, n, ignore);
                if weight >= h-0.0001
                    S = {S{:}, set};
                    W = {W{:}, w};
                else
                    temp = union(temp, set);
                end
            end
            num = next_num(num, f);
        end
        F = temp;
        if length(F) <= i
            break
        end
    end
end
end


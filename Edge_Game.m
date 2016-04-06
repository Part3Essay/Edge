function [ S, Weightings, wprob, Edges, eprob ] = Edge_Game( M, h )
%Outputs equilibrium strategies of the Hider and Searcher
%played on the graph with adjacency matrix M and total
%amount of material h.
n = length(M(1, :));
[N, ignore] = reduce(M, n);
N = tril(N);
e = length(find(N));
[S, W] = DominatingSets(M, h, ignore);
[wprob, eprob] = Equilibrium_Find(S, e);
Indices1 = zeros(1, length(wprob));
Weightings = {};
for k = 1:length(wprob)
    if wprob(k) >= 0.0001
        Indices1(k) = 1;
        Weightings = {Weightings{:}, W{k}};
    end
end
Weightings = Weightings_Transform(N, Weightings, S, h, ignore);
wprob = wprob(find(Indices1));
Edges = zeros(e, 2);
Indices2 = find(N);
for k = 1:e
    index = Indices2(k);
    i = mod(index, n);
    if i == 0;
        i = n;
    end
    j = ceil(index/n);
    if i < j
        Edges(k, 1) = i;
        Edges(k, 2) = j;
    else
        Edges(k, 1) = j;
        Edges(k, 2) = i;
    end
end
end


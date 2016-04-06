function [ Weightings ] = Weightings_Transform( N, Weightings, S, h, ignore )
%Transforms weightings into form where either all weight
%is at a single vertex or there are at most 2 non-zero
%values with one twice the other
n = length(Weightings{1});
Indices = find(N);
for i = 1:numel(Weightings)
    w = Weightings{i};
    if max(w) > h-1+0.0001
        index = find(w>h-1+0.0001, 1);
        new = zeros(1, length(w));
        new(index) = h;
        Weightings{i} = new;
    else
        C = ignore;
        D = setxor(1:length(Indices), S{i});
        for j = 1:length(D)
            k = D(j);
            index = Indices(k);
            a = mod(index, n);
            if a == 0;
                a = n;
            end
            b = ceil(index/n);
            C = union(C, [a, b]);
        end
        remove = setxor(1:n, C);
        w(remove) = h-1;
        Weightings{i} = w;
    end
    Weightings{i} = Weightings{i}*h/sum(Weightings{i});
end
        
        
end


function [ M, ignore ] = reduce( M, n )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
Mnew = M;
%vertices at which the Hider can always play 0 for same losing set
ignore = [];
while true
    for i = 1:n
        if sum(Mnew(i, :)) == 1
            j = find(Mnew(i, :));
            if sum(Mnew(:, j)) > 1
                ignore = union(ignore, j);
            end
            for k = 1:n
                if sum(Mnew(:, k)) > 1
                    Mnew(j, k) = 0;
                    Mnew(k, j) = 0;
                end
            end
        end
    end
    if Mnew == M
        break
    else
        M = Mnew;
    end
end



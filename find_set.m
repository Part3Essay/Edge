function [ set ] = find_set( F, num )
%Uses binary rep of num and selects elements of F
%according to indices of 1s
set = F(find(num));
end


function [ w ] = next_num( v, f )
t = bitor(v, v-1) + 1;
w = bitor(t, bitshift((bitand(t, bitxor(t, 2^f-1) + 1)/bitand(v, bitxor(v, 2^f-1) + 1)), -1)) -1;
end
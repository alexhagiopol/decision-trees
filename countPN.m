function [p,n] = countPN(data)
p = 0;
n = 0;
[r,c] = size(data);
for i = 1:r
    if data(i,c) == 0;
        n = n + 1;
    else
        p = p + 1;
    end
end
end
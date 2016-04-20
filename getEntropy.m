function entropy = getEntropy(p, n) %entropy as determined on page 704 of R&N
if p == 0 || n == 0 %avoids numerical instability when matlab computes log2(0) = -inf;
    entropy = 0;
else
    p1 = p / (p + n);
    p2 = n / (p + n);
    entropy = -1*p1*log2(p1) - p2*log2(p2);
end
end
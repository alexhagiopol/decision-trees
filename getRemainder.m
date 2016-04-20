function remainder = getRemainder(pk1, nk1, pk2, nk2) %again from page 704
p1 = (pk1 + nk1) / (pk1 + nk1 + pk2 + nk2);
p2 = (pk2 + nk2) / (pk1 + nk1 + pk2 + nk2);
remainder = p1*getEntropy(pk1,nk1) + p2*getEntropy(pk2,nk2);
end
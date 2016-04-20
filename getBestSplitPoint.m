function [bestSplit, bestGain, bestIndex] = getBestSplitPoint(attributeNum, data)
[rows, cols] = size(data);
bestGain = -9999;
[bestP, bestN] = countPN(data); %number of positive and negative outcomes in the whole example set
pk1 = 0;          %pk1 = number of positive outcomes left of the split 
nk1 = 0;          %nk1 = number of negative outcomes left of the split
pk2 = bestP;      %pk2 = number of positive outcomes right of the split 
nk2 = bestN;      %nk2 = number of negative outcomes right of the split 

[sortedData, I] = sortrows(data, attributeNum);
bestSplit = 0;
bestIndex = 0;
for i = 1:rows - 1 %implement instructions for finding split points on page 707 of Russel and Norvig
    if sortedData(i,cols) == 0 %increment the number of positive and negative outcomes on both sides of the potential split; avoid repeated use of countPN
        nk1 = nk1 + 1;
        nk2 = nk2 - 1;
    else
        pk1 = pk1 + 1;
        pk2 = pk2 - 1;
    end
    if (sortedData(i,cols) ~= sortedData(i+1,cols)) && (sortedData(i,attributeNum) ~= sortedData(i+1,attributeNum)) %check if 2 consecutive outcomes do not match AND 2 consecutive att vals do not match
        gain = getEntropy(bestP,bestN) - getRemainder(pk1, nk1, pk2, nk2); %compute info gain
        if gain > bestGain
            bestGain = gain;
            bestSplit = (sortedData(i,attributeNum) + sortedData(i + 1, attributeNum))/2; %compute best split point
            bestIndex = I(i); %retrieve index in unsorted data of best split location. Technically, "split point" is slightly higher than number at this index.
        end
    end
end

end


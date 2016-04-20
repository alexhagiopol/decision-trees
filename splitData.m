function [childDataLeft, childDataRight] = splitData(data, attributeNum, splitPoint)
[r,c] = size(data);
childDataLeft = [];
childDataRight = [];
for i = 1:r
    if data(i,attributeNum) < splitPoint
        childDataLeft = [childDataLeft; data(i,1:c)];
    else
        childDataRight = [childDataRight; data(i,1:c)];
    end
end
end
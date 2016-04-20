function [attributeNum, splitPoint, splitIndex] = getHighestImportanceAttribute(data, attributes) %pass attributes as a row vector e.g [1,2,3,4]
    numAttributes = length(attributes);
    splits = zeros(numAttributes,1);
    indices = zeros(numAttributes,1);
    gains = zeros(numAttributes,1);
    for j = 1:length(attributes) %check all attributes for best gain. The return the attribute along with its splitPoint and splitIndex. The splitPoint is the attribute value at which we split. The splitIndex is the index *ON THE ORGINAL DATA* *RIGHT BEFORE* the split point (not sure if this is as useful as I thought)
        att = attributes(j);
        
        [bestSplit, bestGain, bestIndex] = getBestSplitPoint(att, data); %get the gain and split info for each attribute
        splits(j) = bestSplit;
        indices(j) = bestIndex;
        gains(j) = bestGain;
    end
    resultsMatrix = [attributes', splits, indices, gains];
    [sortedResults, I] = sortrows(resultsMatrix, 4); %sort results in ascending order by gain value
    % the bottom row must have the highest gain; return that attribute number and split info
    attributeNum = sortedResults(numAttributes,1);
    splitPoint = sortedResults(numAttributes,2);
    splitIndex = sortedResults(numAttributes,3);
    %attributeNum
    %splitPoint
end 
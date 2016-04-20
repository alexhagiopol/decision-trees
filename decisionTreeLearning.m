function tree = decisionTreeLearning(data, parentData, attributes) %pass attributes as a row vector e.g. [1,2,3,4]

tree = cell(6,1);
%TREE CELL ARRAY EXPLANATION:
%1 {'END_TREE'   || 'HAS_CHILD'}
%2 {finalOutcome || childTreeLeft}
%3 {0            || childTreeRight}
%4 {0            || attributeNum} 
%5 {0            || splitPoint}
%6 {0            || splitIndex}

[p,n] = countPN(data);
if isempty(data)           %First line of algorithm on page 702 of Russel & Norvig 
    [pp,pn] = countPN(parentData); %perform "plurality" test in line 
    if pp >= pn   %assume final outcome is positive; break ties assuming positive outcome
        tree{1} = 'END_TREE';
        tree{2} = 1;
        tree(3:6) ={0};
        %tree
        
    else %assume final outcome is negative
        tree{1} = 'END_TREE';
        tree{2} = 0;
        tree(3:6) = {0};
        %tree
    end    
elseif p == 0 %all outcomes are negative  Line 3 of algorithm
    tree{1} = 'END_TREE';
    tree{2} = 0;
    tree(3:6) = {0};
    %tree
elseif n == 0 %all outcomes are positive
    tree{1} = 'END_TREE';
    tree{2} = 1;
    tree(3:6) = {0};
    %tree
else
    %18.9 Modification. Search for missing data and act according to problem 18.9    
    [rows,cols] = size(data);  
    editedData = data;
    for j = attributes
        newAttDataSet = [];
        emptyIndices = [];
        for i = 1:rows        
            if ~isnan(data(i,j)) %check if slot was deleted
                newAttDataSet = [newAttDataSet, data(i,j)];
            else
                emptyIndices = [emptyIndices; i];
            end
        end
        if ~isempty(emptyIndices)
            if isempty(newAttDataSet)
                valueAssigned = 0; %if all the numbers in a data set are NaN, assign 0 because it's always safe
            else
                %[N,X] = hist(newAttDataSet,length(newAttDataSet));% Determine frequency distribution of other data
                valueAssigned = mean(newAttDataSet);  %Assign weighted value as described in 18.9 
                
            end
            %valueAssigned
            
            editedData(emptyIndices,j) = valueAssigned;
        end
    end      
    %End 18.9 Modification.
    
    [attributeNum, splitPoint, splitIndex] = getHighestImportanceAttribute(editedData, attributes); %Line 5 of algorithm on page 702
    [leftChildData, rightChildData] = splitData(data, attributeNum, splitPoint);
    %attributeNum
    %splitPoint
    %splitIndex
    %leftChildData
    %rightChildData    
    tree{1} = 'HAS_CHILD';
    tree{2} = decisionTreeLearning(leftChildData, data, attributes); %don't pass edited data 
    tree{3} = decisionTreeLearning(rightChildData, data, attributes); %don't pass edited data
    tree{4} = attributeNum;
    tree{5} = splitPoint;
    tree{6} = splitIndex;
end

end
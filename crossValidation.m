function confusionMatrix = crossValidation(data, attributes)
confusionMatrix = zeros(2,2);
%{                    
predicted values
                       0        1 
actual values  0       X        X 
               1       X        X           
%}
for i = 1:10 %10 fold cross validation
    %split data into training data and test data. Test data is 10% of training data.
    [r,c] = size(data);
    numTestItems = round(r/10); %10% of data will be used as test data
    numTrainingItems = r - numTestItems;
    testDataIndices = randperm(r, numTestItems)'; %randomly select test data from full data
    testData = data(testDataIndices,:); 
    trainingData = [];
    trainingDataTemp = data;
    trainingDataTemp(testDataIndices,:) = -1;
    for j = 1:r
        if trainingDataTemp(j,5) ~= -1
            trainingData = [trainingData; trainingDataTemp(j,:)]; %add example to training data set only if example is not in test data set
        end       
    end
    
    %testData
    %trainingData
    
    tree = decisionTreeLearning(trainingData, [], attributes); %create a decision tree based on the training data
    [r,c] = size(testData);
    resultsComparisonMatrix = [testData(:,5),zeros(r,1)]; %test the decisions made by the tree for the test data
    for j = 1:r
        resultsComparisonMatrix(j,2) = showDecision(testData(j,1:4), tree); %place the results in a results comparison matrix
        if resultsComparisonMatrix(j,1) == resultsComparisonMatrix(j,2) %if results match, increment relevant items received
            if resultsComparisonMatrix(j,1) == 0 %increment predicted and actual values received in matrix cells that match
                confusionMatrix(1,1) = confusionMatrix(1,1) + 1; %if actual value is zero, increment predicted value zero
            else
                confusionMatrix(2,2) = confusionMatrix(2,2) + 1; %if actual value is 1 increment predicted value 1
            end
        else
            if resultsComparisonMatrix(j,1) == 0 %increment predicted and actual values received in matrix cells that match
                confusionMatrix(1,2) = confusionMatrix(1,2) + 1; %if actual value is zero, increment predicted value 1
            else
                confusionMatrix(2,1) = confusionMatrix(2,1) + 1; %if actual value is one increment predicted value zero
            end
        end
    end    
end
end
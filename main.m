clear
clc
close all
data = csvread('data_banknote_authentication.csv');
%variance, skewness, curtosis, entropy, class
%1,        2,        3,        4,       5


%*******************************No attributes deleted with decision tree***********************************
attributes = [1,2,3,4];
k = 100; %number of trees generated
confusionMatrix = zeros(2,2);
parfor i = 1:k
    confusionMatrix = confusionMatrix + crossValidation(data, attributes);
end
disp('K DECISION TREES W/ NO ATTRIBUTES DELETED');
disp('k=');
disp(k);
disp('confusion matrix');
disp(confusionMatrix);
truePositives = confusionMatrix(2,2);
trueNegatives = confusionMatrix(1,1);
falsePositives = confusionMatrix(1,2);
falseNegatives = confusionMatrix(2,1);
disp('precision');
disp(truePositives / (truePositives + falsePositives));
disp('recall');
disp(truePositives / (truePositives + falseNegatives));

%%
%*******************************No attributes deleted with random forest***********************************
k = 1000; %number of trees generated
n = 1000; %number of data points sampled from 1372 total points
m = 3; %number of attributes sampled from 4 total attributes
confusionMatrix = zeros(2,2);
parfor i = 1:k
    attributeIndices = randperm(4,m);
    dataIndices = randperm(1372,n);
    confusionMatrix = confusionMatrix + crossValidation(data(dataIndices,:), attributes(attributeIndices));
end
disp('RANDOM FOREST OF K TREES W/ N EXAMPLES W/ N ATTRIBUTES W/ NO ATTRIBUTES DELETED ');
disp('k=');
disp(k);
disp('n=');
disp(n);
disp('m=')
disp(m);
disp('confusion matrix');
disp(confusionMatrix);
truePositives = confusionMatrix(2,2);
trueNegatives = confusionMatrix(1,1);
falsePositives = confusionMatrix(1,2);
falseNegatives = confusionMatrix(2,1);
disp('precision');
disp(truePositives / (truePositives + falsePositives));
disp('recall');
disp(truePositives / (truePositives + falseNegatives));


%%
%*******************************Some (10%) attributes deleted with decision tree***********************************
attributes = [1,2,3,4];
k = 1; %number of trees generated
confusionMatrix = zeros(2,2);
parfor i = 1:k
    confusionMatrix = confusionMatrix + crossValidationWithDeletion(data, attributes);
end
disp('K DECISION TREES W/ 10% ATTRIBUTES DELETED');
disp('k=');
disp(k);
disp('confusion matrix');
disp(confusionMatrix);
truePositives = confusionMatrix(2,2);
trueNegatives = confusionMatrix(1,1);
falsePositives = confusionMatrix(1,2);
falseNegatives = confusionMatrix(2,1);
disp('precision');
disp(truePositives / (truePositives + falsePositives));
disp('recall');
disp(truePositives / (truePositives + falseNegatives));

%%
%*******************************Some (10%) attributes deleted with random forest***********************************
k = 10; %number of trees generated
n = 1000; %number of data points sampled from 1372 total points
m = 3; %number of attributes sampled from 4 total attributes
confusionMatrix = zeros(2,2);
parfor i = 1:k
    attributeIndices = randperm(4,m);
    dataIndices = randperm(1372,n);
    confusionMatrix = confusionMatrix + crossValidation(data(dataIndices,:), attributes(attributeIndices));
end
disp('RANDOM FOREST OF K TREES W/ N EXAMPLES W/ N ATTRIBUTES W/ 10% ATTRIBUTES DELETED ');
disp('k=');
disp(k);
disp('n=');
disp(n);
disp('m=')
disp(m);
disp('confusion matrix');
disp(confusionMatrix);
truePositives = confusionMatrix(2,2);
trueNegatives = confusionMatrix(1,1);
falsePositives = confusionMatrix(1,2);
falseNegatives = confusionMatrix(2,1);
disp('precision');
disp(truePositives / (truePositives + falsePositives));
disp('recall');
disp(truePositives / (truePositives + falseNegatives));




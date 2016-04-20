function decision = showDecision(example, tree) 
    if strcmp(tree{1},'END_TREE')    %If this is a final node in the tree, simply return the outcome value sotred in tree{2}
        decision = tree{2};
    else
        if example(tree{4}) < tree{5}  %if the corresponding attribute value of the example is less than the split value of the attribute in the tree, go to left tree
            decision = showDecision(example, tree{2});
        else %vice versa
            decision = showDecision(example, tree{3});
        end
    end
end
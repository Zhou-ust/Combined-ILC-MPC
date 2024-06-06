function [ Qfun] = computeCost(X,U)

% Need to start from the end
for i = 1:(size(X,2))
    Index = size(X,2)-i+1;
    if i == 1
        Cost(Index) = terminalcost(Index, X(:,Index));
    else
        Cost(Index) = Cost(Index+1) + runningcost(Index, X(:,Index), U(:,Index));
    end
end
Qfun = Cost;
end


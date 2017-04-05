function [ feats] = SWP_topK_Lazy_Greedy( X, k, prevFeats, forbidFeats )



% Initialization
feats = [];

num_features = size(X,2);

ind = setxor(1:num_features, forbidFeats);
sumX = sum(X,1);
zeroX = find(sumX == 0);
ind = setdiff(ind, zeroX);

k = min(k, numel(ind));
if ( k == 0 )
    return;
end
% Filling in the heap
pq = PriorityQueue();
for i=1:numel(ind)
    pq.push(ind(i), addValue(prevFeats, ind(i), X));
end

% Take out the first feature
feats = pq.pop();

for iteration=2:k
    cursz = pq.size();
    if (cursz == 1)
        feats = [feats pq.pop()];
        break;
    end
    for j=1:cursz+1
        top = pq.pop();
        newScore = addValue([prevFeats feats], top, X);
        [~, nextScore] = pq.top();

        if (nextScore <= newScore)
            % No need to check the rest
            feats = [feats top];
            break;
        else
            % We have to put the top element back in with new value
            pq.push(top, newScore);
        end
    end
end

total_score = sfo_amen_l2_score(X, feats);
    
end

function [ score ] = addValue( feats, newFeat, X )

oldScore = sfo_amen_l2_score(X, feats);
newScore = sfo_amen_l2_score(X, [feats newFeat]);

score = newScore - oldScore;

end




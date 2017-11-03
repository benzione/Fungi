function histog = NN(SIFT,Dict)
distances = zeros(size(SIFT, 1), size(Dict, 1));
K = size(Dict, 1);
for k = 1:K
    distances(:, k) = sum((SIFT - repmat(Dict(k, :), [size(SIFT, 1), 1])).^2, 2);
end
[minDist, minDistIndex] = min(distances, [], 2);
histog = accumarray(minDistIndex, ones(size(minDistIndex)));
diffrence = size(Dict,1) - length(histog);
if diffrence > 0
    histog = ([histog; zeros(diffrence, 1)])';
end
function HistogramMatrix = prepare(TrainData, Dict, iSize, iStep)
N = size(TrainData,3);
HistogramMatrix = zeros(N, size(Dict,1));
for i = 1:N
    SIFT = getSifts(im2single(TrainData(:,:,i)), iSize, iStep);
    SIFT = im2double(SIFT);
    HistogramMatrix(i, :) = NN((SIFT)', Dict);
    if mod(i, 10) == 0
        fprintf('histogramed image number %g of %g images \n' , i, N);
    end
end
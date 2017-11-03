clear all;
close all;
clc;

% tic
addpath(genpath(strcat(pwd, '\liblinear-2.11\windows')))
run(strcat(pwd, '\vlfeat-0.9.20\toolbox\vl_setup'))
Params.NumOfWords = 500;
Params.Size = 13;
Params.Step = 6;
Params.patchStride = Params.Size * 2;
Params.testFileName = '7e.jpg';

monPos = readFolderImages('pos',1);
Params.mH = size(monPos, 1);
Params.mW = size(monPos, 2);
labelsPos = ones(1, size(monPos, 3));

monNeg = readFolderImages('neg2',1);
labelsNeg = ones(1, size(monNeg, 3)) * 2;
data = cat(3, monPos, monNeg);

labels = [labelsPos, labelsNeg];

% %create dictonery
SIFTForVocabilary = CreateSIFTS(data, Params.Size, Params.Step);
fprintf('Create dictonery \n');
[Dict, assignments] = vl_kmeans((SIFTForVocabilary)', Params.NumOfWords);
Dict=Dict';

%train
TrainHistogramMatrix = prepare(data, Dict, Params.Size, Params.Step);
tmpmax = max(TrainHistogramMatrix);
for i = 1:size(TrainHistogramMatrix, 2)
    TrainHistogramMatrix(:, i) = TrainHistogramMatrix(:, i) / tmpmax(i);
end
sparseTrainData = sparse(TrainHistogramMatrix);

save('tmp1','sparseTrainData', 'Dict', 'Params', 'labels')
% load('tmp1');
model = MClassSVM_Train(sparseTrainData, labels);

%test
test = createTest(Params);
TestHistogramMatrix = prepare(test, Dict, Params.Size, Params.Step);
tmpmax = max(TestHistogramMatrix);
for i = 1:size(TestHistogramMatrix, 2)
    TestHistogramMatrix(:, i) = TestHistogramMatrix(:, i) / tmpmax(i);
end
save('tmp2','TestHistogramMatrix')
predicted_label = MClassSVM_Predict(TestHistogramMatrix , model);

count = find(predicted_label == 1);
rmpath(genpath(strcat(pwd, '\liblinear-2.11\windows')))
h = toc;
disp(h);




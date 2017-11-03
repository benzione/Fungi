function model = MClassSVM_Train( Data, Labels )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

TempLabels = zeros(size(Labels'));    
TempLabels(Labels ~= 1) = -1;
TempLabels(Labels == 1) = 1;
ClassModel = train(TempLabels, Data, '-s 3 -c 5  -B 1');
model = (ClassModel.w)';

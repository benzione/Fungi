function [TrainData, TestData, TrainLabels, TestLabels] = TrainTestSplit(Data, Labels, SplitRatio)
%split the data and labels to 2 groups using to SplitRatio. the function
%takes (SplitRatio*number of samples of class a) per each class.
%input:
%Data-a matrix (m*n) that contains m samples with n dimensions\a matrix (m*n*n) that contains m samples with n*n dimensions
%Labels-vector(1*m) contain m labels
%splitRatio- a ratio (0<splitRatio<1)that determine the size of the
%TrainData part (TestData will be (1-splitRatio) of the total samples.
%output:
%TrainData - matrix (SplitRatio*number of samples)*n \ 
%matrix(SplitRatio*number of samples)*n*n
%TestData - matrix (1-SplitRatio*number of samples)*n \  
%matrix(1-SplitRatio*number of samples)*n *n
%TrainLabels- vector 1*(SplitRatio*number of samples)
%TestLabels - vector 1*(1-SplitRatio*number of samples)
classes=unique(Labels);
TrainData=[];
TestData=[];
TrainLabels=[];
TestLabels=[];
assert(SplitRatio>0,'SplitRatio should be>0')
DataDim=ndims(Data);
for i=1:length(classes)
    Indices = find( Labels==classes(i) );
    NumberOfElementsForTraining = round(size(Indices,2)* SplitRatio);
    assert(DataDim==2 || DataDim==3, 'Unsuppurted number of dimensions in TestTrainSlit');
    switch DataDim
        case 2
            classData = Data(Indices,:);
             TrainData=[TrainData ; classData(1:NumberOfElementsForTraining,:)];
            TestData=[TestData;  classData(NumberOfElementsForTraining+1:size(classData,1),:)];
        case 3
            classData = Data(:,:,Indices);
            TrainData=cat(3,TrainData, classData(:,:,1:NumberOfElementsForTraining));
            TestData=cat(3,TestData, classData(:,:,NumberOfElementsForTraining+1:size(classData,3)));
    end
    TrainLabels=[TrainLabels,ones(1,NumberOfElementsForTraining)*classes(i)];
    TestLabels=[TestLabels,ones(1,size(classData,1)-NumberOfElementsForTraining)*classes(i)];
end




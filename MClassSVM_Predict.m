function predict = MClassSVM_Predict(examples , model)
%the function create a vector of predicted labels to the examples sample
%using matrix multiplication
%input-
%examples-an S*S*N matrix that represent N photos sized S*S
%model- the train output. an P*L matrix where P is the number of features in training
%data +1 and L is the number of classes, that represent the classes weights
%output-
%pretict-a vector of the preticted labels of the examples.
examples = [examples, ones(size(examples, 1), 1)];
MultiplMatrix = examples * model;
disp(min(MultiplMatrix))
disp(max(MultiplMatrix))
predict = zeros(length(MultiplMatrix), 1);
predict(MultiplMatrix > 0) = 1;
predict(MultiplMatrix <= 0) = 2;
end
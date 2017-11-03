function test = createTest(Params)
imt = imread(Params.testFileName);
imtest = rgb2gray(imt);
[imH, imW] = size(imtest);
tmp = ceil(size(imtest, 2) / Params.patchStride);
sizeTest = ceil((size(imtest, 1) / Params.patchStride)) * tmp;

test = zeros(Params.mH, Params.mW, sizeTest);
idx = 1;
for i = 1:Params.patchStride:imH
    for j = 1:Params.patchStride:imW
        if i+Params.mH-1 > imH
            tmp1 = imH;
        else
            tmp1 = i+Params.mH-1;
        end
        if j+Params.mW-1 > imW
            tmp2 = imW;
        else
            tmp2 = j+Params.mW-1;
        end
        tmpH = tmp1 - i + 1;
        tmpW = tmp2 - j + 1;
        tmp = imtest(i:tmp1,j:tmp2);
        test(1:tmpH,1:tmpW,idx) = tmp;
        idx = idx + 1;
    end
end
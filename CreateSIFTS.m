function Sifts = CreateSIFTS(TrainData, iSize, iStep)
%The function represent each picture with SIFT using a patch size.
%input-
%TrainData- S*S*N data where N is the number of pictures and S*S are number
%of picsels in a picture (number of featurs).
%patchSize- the size of the %%%%%%Ï‰Ú˙È˜ Ó‰readme
%output- 
%(N*numOfSiftsPerImage)*128 where numOfSiftsPerImage depand on
%picture size and input patchSize and N is number of picture (size of the
%3th dim of TrainData
ImageDescriptors = getSifts(im2single(TrainData(:,:,1)), iSize, iStep);
ImageDescriptors = im2double(ImageDescriptors);
numOfSiftsPerImage = size(ImageDescriptors, 2);
N = size(TrainData, 3);
Sifts = zeros(N*numOfSiftsPerImage, 128);
Sifts(1:numOfSiftsPerImage, :) = ImageDescriptors';
for i = 2:N
    ImageDescriptors = getSifts(im2single(TrainData(:, :, i)), iSize, iStep);
    ImageDescriptors = im2double(ImageDescriptors);
    Sifts((numOfSiftsPerImage*(i - 1) + 1):numOfSiftsPerImage * i, :) = ImageDescriptors';
    if mod(i, 10) == 0
        fprintf('sift for image number %g of %g images \n', i, N);
    end
end


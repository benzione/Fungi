%run('H:\\Task 2\VLFEATROOT\toolbox\vl_setup')
run(strcat(pwd, '\VLFEATROOT\toolbox\vl_setup'))

%  TRAINING
%
% read pos and neg images
%monPos = readFolderImages('H:\\Task 2\\pos');
monPosG = readFolderImages('pos',1);
%monNeg = readFolderImages('H:\\Task 2\\neg2');
monNegG = readFolderImages('neg2',1);

% extract HoG features
% 5239 = 13x13x31 feat.dim (cellSize=6 -> 78=6x13, 13x13 cells in 78x78 window) 
cellSize = 6;
featPos = getImageHoG(monPosG, cellSize);
featNeg = getImageHoG(monNegG, cellSize);

% fit model
X = [featPos; featNeg];
Y = [ones(size(featPos,1),1); zeros(size(featNeg,1),1)];
CMdl = fitclinear(X,Y,'KFold',5);
kfoldLoss(CMdl)
Mdl = fitclinear(X,Y);
loss(Mdl,X,Y)

%
%  TESTING
%
% test on image
imt = imread('7e.jpg');
imtest = imt;

%
imhog = vl_hog(single(imtest), cellSize, 'verbose');
% window method
wcell = 78/cellSize;    % cellSize=6 -> wcell=13
[imH,imW,c] = size(imhog);
tic
outim = zeros(imH,imW);
for iw = 1:(imW-wcell+1)
    for ih = 1:(imH-wcell+1)
        f = imhog(ih:(ih+wcell-1),iw:(iw+wcell-1),:);
        outim(ih,iw) = predict(Mdl, f(:)');
    end
end
toc
% imshow(outim);
% % 110.1 sec for 1920x2560 image (320x427 cells)
% 
% %%
% stats = regionprops(bwconncomp(outim),'BoundingBox','Area');
% arr = zeros(1,length(stats));
% for i=1:length(stats)
%     arr(i) = stats(i).Area;
% end
% % figure,hist(arr,1:max(arr));
% 
% %% final result
% out1 = imopen(outim, strel('disk', 1));
% stats = regionprops(bwconncomp(out1),'BoundingBox','Area');
% 
% %% visualize
% figure, imshow(outim);
% for i=1:length(stats)
%     rectangle('Position',stats(i).BoundingBox,'EdgeColor','r');
% end
% figure, imshow(out1);
% for i=1:length(stats)
%     rectangle('Position',stats(i).BoundingBox,'EdgeColor','r');
% end
% 
% %% calculate box coords for the original image
% % outim box: [x1 y1 w h]
% % Each pixel in outim comes from wcellxwcell box in outim (78x78 in original image)
% % e.g. cellSize=6, wcell=13. Each detection box is 78x78pixels (orig),13x13 cells (outim)
% % So, outim box: (x1,y1) - (x1+w+wcell-1, y1+h+wcell-1)
% % Multiply by cellSize to get orig.image coords (e.g. x*6-5)
% figure, imshow(imtest); title(length(stats));
% for i=1:length(stats)
%     rectangle('Position',stats(i).BoundingBox*6+[15 15 30 30],'EdgeColor','r');
% end
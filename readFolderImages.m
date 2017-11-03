function mon = readFolderImages(imdir,g)
flist = dir(fullfile(imdir, '*.jpg'));
% read images
if nargin < 2   %RGB image
    mon = zeros(78,78,3,length(flist), 'single');
    for i=1:length(flist)
        imPath = fullfile(imdir,flist(i).name);
        im_ = imread(imPath) ;
        im_ = imresize(im_,[78 78]) ;
        mon(:,:,:,i) = im_;
    end
else            %graylevel image
    mon = zeros(78,78,length(flist), 'single');
    for i=1:length(flist)
        imPath = fullfile(imdir,flist(i).name);
        im_ = rgb2gray(imread(imPath));
        im_ = imresize(im_,[78 78]) ;
        mon(:,:,i) = im_;
    end
end

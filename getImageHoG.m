function feat = getImageHoG(mon, cellSize)
if nargin < 2
    cellSize = 6;
end
if length(size(mon)) == 4 % RGB images
    hog = vl_hog(single(mon(:,:,:,1)), cellSize, 'verbose') ;
    feat = zeros( size(mon,4), length(hog(:)) );
    for i=1:size(mon,4)
        hog = vl_hog(single(mon(:,:,:,i)), cellSize) ;
        feat(i, :) = hog(:)';
    end
else
    disp('HoG on graylevel');
    hog = vl_hog(single(mon(:,:,1)), cellSize, 'verbose') ;
    feat = zeros( size(mon,3), length(hog(:)) );
    for i=1:size(mon,3)
        hog = vl_hog(single(mon(:,:,i)), cellSize) ;
        feat(i, :) = hog(:)';
    end
end
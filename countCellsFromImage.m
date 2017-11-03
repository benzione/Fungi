function cnt = countCellsFromImage(filename)
a = imread(filename);
b = imresize(double(rgb2gray(a)),[400,400]);
%K = wiener2(b,[10 10]);
Kmedian = medfilt2(b);
[Gmag,Gdir] = imgradient(Kmedian);
c = Gmag;
s = size(c)/5;
d = im2col(c, s, 'distinct');
cnt = 0;
rs = [];
for i = 1:size(d,2)
    img = reshape(d(:,i), s);
    xy = calcLocalMaxima(img);
    subplot(5,5,i)
    imagesc(img);colormap gray;
    hold on;
    plot(xy(:,1),xy(:,2),'r*')
    hold off;
    cnt = cnt + length(xy);
end
subplot(5,5,3)
title(['Fungus cell count=',int2str(cnt)])
    

function xy = calcLocalMaxima(c)
h = fspecial('gaussian', 20,4);
d = imfilter(c, h);
e = fft2(d);
inx = find(abs(e(:))<1);
e(inx) = 0+0i;
f = ifft2(e);
u = FastPeakFind(f);
% imagesc(f);
% colormap gray;
% hold on;
% plot(u(1:2:end), u(2:2:end), 'g*')
% hold off;
xy = [u(1:2:end) u(2:2:end)];


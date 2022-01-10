% im_input = im2double(imread('.\Pics\Ch08\airport.tif'));
im_input = im2double(imread('.\Pics\homework4\test01.jpg'));
figure, imshow(im_input); title('input image');
out_input = im_input;
T = graythresh(im_input);
T*255;
im_output = im2bw(im_input, T); 
figure,imshow(im_output);title('OtsuãÐÖµ»¯½á¹û 02');
%% 
im_output = ~im_output;
%% ÒÆ³ýÐ¡¶ÔÏó
img7= bwareaopen(img5, 30);
figure('name', 'ÒÆ³ýÐ¡¶ÔÏó');
imshow(img7);
title('´ÓÍ¼ÏñÖÐÒÆ³ýÐ¡¶ÔÏó img7');

f=edge(img7,'canny');
%% ±ßÔµ¼ì²â
 [m,n] = size(im_output);
 img5 = im_output(0.3*m:0.8*m,0.05*n:0.95*n);
BW = edge(img5,'canny');
% BW = canny1step(img5,22);
figure('name','±ßÔµ¼ì²â');
imshow(BW);
title('cannyËã×Ó±ßÔµ¼ì²â');
f =BW;
%% »ô·ò¼ì²â
[H, theta, rho] = hough(f, 'RhoResolution', 1,'Theta',-90:1:89.5); 
 imshow(H, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit') 
axis on, axis normal 
xlabel('\theta'), ylabel('\rho') 

peaks = houghpeaks(H, 2); 
hold on  
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'linestyle', 'none', 'marker', 's', 'color', 'y') ;
lines = houghlines(f, theta, rho, peaks); 
figure, imshow(f), hold on 
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end 

%%  ÌáÈ¡¿¨ºÅ
% img_extract = zeros(m,n);
maxx = 0;
maxy = 0;
miny = n;
minx = m;
[m_1,n_1] = size(f);
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
if max(xy(:,1))>maxx
%     &&m_1>max(xy(:,1))
    maxx = max(xy(:,1));
% else maxx = m_1;
end
if max(xy(:,2))>maxy
%     &&n_1>max(xy(:,2))
    maxy = max(xy(:,2));
% else  maxy = n_1;
end
if min(xy(:,1))<minx
    minx = min(xy(:,1));
end
if min(xy(:,2))<miny
    miny = min(xy(:,2));
end
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end 
img_extract = f(miny+0.3*m:maxy+0.3*m,minx+0.05*n:maxx+0.1*n);
 figure; imshow(img_extract);
 img_com = zeros(m,n);
 img_com(miny:maxy,minx:maxx) = f(miny:maxy,minx:maxx);
  figure; imshow(img_com);
%% 
RGB = im2double(imread('.\Pics\homework4\test02.jpg'));
I  = rgb2gray(RGB);
%% 
imhist(I);
title('»Ò¶ÈÖ±·½Í¼');
%% Í¼Ïñ¸¯Ê´
se=[1;1;1];
img5 = imerode(I, se);
figure('name','Í¼Ïñ¸¯Ê´');
imshow(img5);
title('¸¯Ê´ºóµÄÍ¼Ïñ');
figure
imhist(img5);
title('»Ò¶ÈÖ±·½Í¼');
%%   ±ßÔµ¼ì²â
 [m,n] = size(img5);
 img5 = img5(0.1*m:0.9*m,0.05*n:0.95*n);
BW = edge(img5,'canny');
figure('name','±ßÔµ¼ì²â');
imshow(BW);
title('cannyËã×Ó±ßÔµ¼ì²â');
%% 
% »ô·ò¼ì²â
[H, theta, rho] = hough(BW,'RhoResolution',5,'Theta',-90:0.5:89);
subplot(2,1,1);
imshow(RGB);
title('gantrycrane.png');
subplot(2,1,2);
imshow(imadjust(rescale(H)),'XData',theta,'YData',rho,...
      'InitialMagnification','fit');
title('Hough transform of gantrycrane.png');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(gca,hot);
% ¼ì²â·åÖµ
peaks = houghpeaks(H, 2); 
hold on  
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'linestyle', 'none', 'marker', 's', 'color', 'y') ;
lines = houghlines(BW, theta, rho, peaks); 
figure, imshow(BW), hold on 
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end 


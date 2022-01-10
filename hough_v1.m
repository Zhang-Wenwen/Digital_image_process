im_input = im2double(imread('.\Pics\homework4\test03.jpg'));
im_input = rgb2gray(im_input);
figure, imshow(im_input); title('input image');
% T = graythresh(im_input);
% T*255;
% im_input = im2bw(im_input, T); 
% figure,imshow(im_input);title('Otsu阈值化结果 02');
%% 边缘检测
 [m,n] = size(im_input);
 img5 = im_input;
%  (0.3*m:0.8*m,0.05*n:0.95*n);
BW = edge(img5,'canny');
figure('name','边缘检测');
imshow(BW);
title('canny算子边缘检测');
%% 霍夫检测
[H, theta, rho] = hough(BW, 'RhoResolution', 1,'Theta',-90:1:89.5); 
 imshow(H, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit') 
axis on, axis normal 
xlabel('\theta'), ylabel('\rho') 

peaks = houghpeaks(H, 2); 
hold on  
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'linestyle', 'none', 'marker', 's', 'color', 'y') ;
lines = houghlines(BW, theta, rho, peaks); 
figure, imshow(BW), hold on 
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end
%%  霍夫检测 以及提取卡号
maxx = 0;
maxy = 0;
miny = n;
minx = m;
[m_1,n_1] = size(BW);
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
if max(xy(:,1))>maxx
    maxx = max(xy(:,1));
end
if max(xy(:,2))>maxy
    maxy = max(xy(:,2));
end
if min(xy(:,1))<minx
    minx = min(xy(:,1));
end
if min(xy(:,2))<miny
    miny = min(xy(:,2));
end
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end 
img_extract = BW(miny:maxy,minx:maxx);
 figure; imshow(img_extract);
 %% 
 img_com = zeros(m,n);
 img_com(miny:maxy,minx:maxx) = BW(miny:maxy,minx:maxx);
  figure; imshow(img_com);
%% 用第三张图片的结果处理第四张图片
  im_input_4 = im2double(imread('.\Pics\homework4\test04.jpg'));
im_input_4 = rgb2gray(im_input_4);
figure, imshow(im_input_4); title('input image');
T = graythresh(im_input_4);
T*255;
im_input_4 = im2bw(im_input_4, T); 
figure,imshow(im_input_4);title('Otsu阈值化结果 04');
 img_com_4 = zeros(m,n);
 img_com_4(miny:maxy,minx:maxx) = im_input_4(miny:maxy,minx:maxx);
  figure; imshow(img_com_4);
 
  %% 
se1 = strel('square', 2);
im_output2 = imdilate(img_com_4, se1);
figure, imshow(im_output2),title('膨胀结果 ');

%% 
figure,imshow(im_input_4);title('Otsu阈值化结果 04'); hold on
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end 

%% 
img7= bwareaopen(im_output2, 10);
figure('name', '移除小对象');
imshow(img7);
title('从图像中移除小对象 img7');
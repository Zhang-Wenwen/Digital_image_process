im_input = im2double(imread('.\Pics\homework4\test01.jpg'));
R =   im_input(:,:,1);
G =   im_input(:,:,2);
B =   im_input(:,:,3);
T = graythresh(im_input);
T*255;
%% 二值化
out_input = im2bw(im_input, T); 
% out_input =edge(rgb2gray(im_input),'canny');
figure,imshow(out_input);title('Otsu阈值化结果');

%% 去除蓝色分量
X = find(B>0.6);
out_input(X) = 0;
figure;imshow(out_input);title('去除蓝色分量');
%% 
out_input1 =edge(out_input,'canny');
figure;imshow(out_input1);title('canny检测');
%%  普通取反，去除小区域
img1 = ~out_input;
figure;imshow(img1);title('取反图像');
%% 
img2 = bwareaopen(img1, 1000);
figure;imshow(img2);title('去除小区域');
%% 
img3 = img1 - img2;
figure;imshow(img3);title('主要图像');

%% 
 [L,num] = bwlabel(img1,4);
 figure;imshow(L);title('连通区域提取');
 
 
 
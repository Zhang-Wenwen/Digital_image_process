im_input = im2double(imread('.\Pics\homework4\test01.jpg'));
R =   im_input(:,:,1);
G =   im_input(:,:,2);
B =   im_input(:,:,3);
T = graythresh(im_input);
T*255;
%% ��ֵ��
out_input = im2bw(im_input, T); 
% out_input =edge(rgb2gray(im_input),'canny');
figure,imshow(out_input);title('Otsu��ֵ�����');

%% ȥ����ɫ����
X = find(B>0.6);
out_input(X) = 0;
figure;imshow(out_input);title('ȥ����ɫ����');
%% 
out_input1 =edge(out_input,'canny');
figure;imshow(out_input1);title('canny���');
%%  ��ͨȡ����ȥ��С����
img1 = ~out_input;
figure;imshow(img1);title('ȡ��ͼ��');
%% 
img2 = bwareaopen(img1, 1000);
figure;imshow(img2);title('ȥ��С����');
%% 
img3 = img1 - img2;
figure;imshow(img3);title('��Ҫͼ��');

%% 
 [L,num] = bwlabel(img1,4);
 figure;imshow(L);title('��ͨ������ȡ');
 
 
 
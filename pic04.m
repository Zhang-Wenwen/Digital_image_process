% im_input = im2double(imread('.\Pics\homework4\test04.jpg'));
% maxx = 440;
% maxy = 194;
% minx = 52;
% miny = 170;
% T = graythresh(im_input);
% out_input = im2bw(im_input,  T); 
% [m,n] = size(out_input);
% figure,imshow(out_input);title('Otsu��ֵ�����');
% output_1 = zeros(m,n);
% output_1(miny:maxy,minx:maxx) = out_input(miny:maxy,minx:maxx);
% figure,imshow(output_1);title('��λ����');
% %%  ��ͼ����ֵ�ٽ��ж�ֵ
% output_2 = output_1.*im_input;
% T = graythresh(output_2);
% output_3 = im2bw(output_2,  0.05);
% figure,imshow(output_2);title('��ͼ');
% figure,imshow(output_3);title('������');


im_input = im2double(imread('.\Pics\homework4\test04.jpg'));
%% ��ֵ��
T = graythresh(im_input);
out_input = im2bw(im_input, T); 
% out_input =edge(rgb2gray(im_input),'canny');
figure,imshow(out_input);title('��ֵ�����');
%% ��ͼ����ɾ������С��3����8�ڽ�
img2 = bwareaopen(out_input, 10);
figure;imshow(img2);title('ȥ��С����');

%% �ұ���
img3 = MY_bwareaopen(img2, 180);
figure;imshow(img3);title('ȥ��������');

%% ������
[H, theta, rho] = hough(img3, 'RhoResolution', 1,'Theta',-90:1:89.5); 
 imshow(H, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit') 
axis on, axis normal 
xlabel('\theta'), ylabel('\rho') 

peaks = houghpeaks(H, 2); 
hold on  
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'linestyle', 'none', 'marker', 's', 'color', 'y') ;
lines = houghlines(img3, theta, rho, peaks); 
figure, imshow(img3), hold on 
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end
%% ��ȡ����
[m,n] = size(img3);
maxx = 0;
maxy = 0;
miny = n;
minx = m;
[m_1,n_1] = size(img3);
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
%% ƫ��ֵ
img_extract = zeros(m,n);
img_extract(miny-0.01*n:maxy+0.01*n,minx:maxx) = img3(miny-0.01*n:maxy+0.01*n,minx:maxx);
 figure; imshow(img_extract);title('��ȡ����ƫ��ֵ���� ');
 %% ԭͼ
 img_extract = zeros(m,n);
img_extract(miny:maxy,minx:maxx) = img3(miny:maxy,minx:maxx);
 figure; imshow(img_extract);title('��ȡ����ԭͼ���� ');
 
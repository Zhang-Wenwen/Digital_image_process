im_input = im2double(imread('.\Pics\homework4\test03.jpg'));
R =   im_input(:,:,1);
G =   im_input(:,:,2);
B =   im_input(:,:,3);

T = graythresh(im_input);
T*255;
%% ��ֵ��
T = 0.65;
out_input = im2bw(im_input, T); 
% out_input =edge(rgb2gray(im_input),'canny');
figure,imshow(out_input);title('canny');
%% ȥ����ɫ����
X = find(R>0.6);
out_input(X) = 1;
figure;imshow(out_input);title('ȥ����ɫ����');
%% ��ͼ����ɾ������С��3����8�ڽ�
img1 = ~out_input;
figure;imshow(img1);title('ȡ��ͼ��');
img2 = bwareaopen(img1, 10);
figure;imshow(img2);title('ȥ��С����');

%% ��ͼ����ɾ������С��3000����8�ڽ� ��Ϊ����ͼ��ȥ
img3 = bwareaopen(img1, 50);
figure;imshow(img3);title('����');
%% ��ȡ��Ҫ����
img4 = img2 - img3;
figure;imshow(img4);title('������');
%% ������
[H, theta, rho] = hough(img4, 'RhoResolution', 1,'Theta',-90:1:89.5); 
 imshow(H, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit') 
axis on, axis normal 
xlabel('\theta'), ylabel('\rho') 

peaks = houghpeaks(H, 2); 
hold on  
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'linestyle', 'none', 'marker', 's', 'color', 'y') ;
lines = houghlines(img4, theta, rho, peaks); 
figure, imshow(img4), hold on 
for k = 1:length(lines) 
xy = [lines(k).point1 ; lines(k).point2]; 
plot(xy(:,1), xy(:,2), 'LineWidth', 4, 'Color', [1 1 0]); 
end

%% ��ȡ����
[m,n] = size(img4);
maxx = 0;
maxy = 0;
miny = n;
minx = m;
[m_1,n_1] = size(img4);
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
%% 
img_extract = zeros(m,n);
img_extract(miny:maxy,minx:maxx) = img4(miny:maxy,minx:maxx);
 figure; imshow(img_extract);title('��ȡ�������� ');
 %% ƫ��ֵ
img_extract = zeros(m,n);
img_extract(miny-0.01*n:maxy+0.01*n,minx:maxx) = img4(miny-0.01*n:maxy+0.01*n,minx:maxx);
 figure; imshow(img_extract);title('��ȡ����ƫ��ֵ���� ');
 
%  %% ֱ������
%  se1 =;
% result = imdilate(img_extract, se1);
% figure, imshow(img_extract),title('���ͽ�� ');
 %% ��ǿ��ֱ��ֵ����
H=[-1 0 -1; -1 0 1; -1 0 1];
img6=  imfilter(img_extract, H);
im_bw = (img6 >=0);
img6 = img6.*im_bw;
figure;imshow(img6),title('��ȡ��ֱ������');
% ��ֱ����
% se1 = strel('rectangle',[5 2]);
% se1 = [1,1,1;0,1,0];
se1 = strel('line',6,0);
img6 = imdilate(img6, se1);
figure, imshow(img6),title('��ֱ���ͽ�� ');
%% ��ǿˮƽ��ֵ����
L=[-1 -1 -1; 0 0 0; 1 1 1];
img7=  imfilter(img_extract, L);
im_bw = (img7 >=0);
img7 = img7.*im_bw;
figure;imshow(img7),title('��ȡˮƽ������');

% ��ˮƽ��������
% se1 = strel('rectangle',[2 5]);
% se1 = [0,0,1,0,0;1,1,1,1,1];
se1 = strel('line',6,90);
img7 = imdilate(img7, se1);
figure, imshow(img7),title('ˮƽ���ͽ�� ');
%% ����ˮƽ����ֱ����
img8 = img7+img6;
im_bw = (img8 >=0);
img8 = img8.*im_bw;
figure;imshow(img8),title('����ˮƽ����ֱ������');
%% 
se2=ones(2);
d = imerode(img8, se2);
figure, imshow(d),title('��ʴ���');%��ʴ����
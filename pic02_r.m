im_input = im2double(imread('.\Pics\homework4\test02.jpg'));
figure,imshow(im_input);title('ԭͼ');

%% ��ֵ��
T = graythresh(im_input);
out_input = im2bw(im_input, T); 
% out_input =edge(rgb2gray(im_input),'canny');
figure,imshow(out_input);title('��ֵ�����');
%% ��ͼ����ɾ������С��30����8�ڽ�
img2 = bwareaopen(out_input, 30);
figure;imshow(img2);title('ȥ��С����');
%% �ұ���
[m,n] = size(img2);
img3 = zeros(m,n);
img3(:,n/2:end) = img2(:,n/2:end);
 figure; imshow(img3);title('ֻ��ȡ�ұ߲��� ');
%%  ��ʴ
% se2 = strel('line',2,90);
% d = imerode(img3, se2);
% figure, imshow(d),title('��ʴ���');%��ʴ����
%% 
img3_1 = MY_bwareaopen(img3,209);
figure;imshow(img3_1);title('�����ұߣ�ȥ��������');
% % [L, num] = bwlabel(img3,8);
img_extract = zeros(m,n);
img_extract(0.3*m:0.7*m,:) = img3_1(0.3*m:0.7*m,:);
 figure; imshow(img_extract);title('��ȡ�����ұ߲������� ');

 %% 
img3_2 = img3-img3_1;
figure;imshow(img3_2);title('����');
 % �ұ߲��ֵ�������ȡ�����˽���

%% ������
[H, theta, rho] = hough(img_extract, 'RhoResolution', 1,'Theta',-90:1:-86.5); 
 imshow(H, [], 'XData', theta, 'YData', rho, 'InitialMagnification', 'fit') 
axis on, axis normal 
xlabel('\theta'), ylabel('\rho') 

peaks = houghpeaks(H, 2); 
hold on  
plot(theta(peaks(:, 2)), rho(peaks(:, 1)), 'linestyle', 'none', 'marker', 's', 'color', 'y') ;
lines = houghlines(img_extract, theta, rho, peaks); 
figure, imshow(img_extract), hold on 
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
img_extract_re = zeros(m,n);
% img_extract(miny-0.01*n:maxy+0.01*n,minx:maxx) = img3(miny-0.01*n:maxy+0.01*n,minx:maxx);
img_extract_re(miny-0.01*n:maxy+0.01*n,minx*7.8:end) = img3(miny-0.01*n:maxy+0.01*n,minx*7.8:end);
 figure; imshow(img_extract_re);title('��ȡ����ƫ��ֵ���� ');
%% ��ͼ����ɾ������С��10000����8�ڽ�
img3_le = zeros(m,n);
img3_le(:,1:n/2) = ~img2(:,1:n/2);
figure;imshow(img3_le);title('ȡ��');
%% 
img4 =MY_bwareaopen(img3_le, 200);
figure;imshow(img4);title('ɾȥ������');
%% ������
[H, theta, rho] = hough(img4, 'RhoResolution', 1,'Theta',-90:1:-86.5); 
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
img_extract_le = zeros(m,n);
% img_extract(miny-0.01*n:maxy+0.01*n,minx:maxx) = img3(miny-0.01*n:maxy+0.01*n,minx:maxx);
img_extract_le(miny-0.01*n:maxy+0.01*n,0.1*n:maxx/1.05) = img4(miny-0.01*n:maxy+0.01*n,0.1*n:maxx/1.05);
 figure; imshow(img_extract_le);title('��ȡ����������� ');
 %% 
 full = img_extract_le +img_extract_re;
  figure; imshow(full);title('��ȡ������������ ');
  %% 
%   se1 = strel('line',1,90);
se1 = ones(2);
full_1 = imerode(full, se1);
figure, imshow(full_1),title('��ֱ��ʴ��� ');
  %% ȥ��С����
 full_2 = bwareaopen(full_1, 6);
figure;imshow(full_2);title('ȥ��С����');
%% ����
se1 = ones(2);
full_3 = imdilate(full_2, se1);
figure, imshow(full_3),title('���ͽ�� ');
%% 
 se1 = strel('line',2,0);
full_3 = imdilate(full_2, se1);
figure, imshow(full_3),title('���ͽ�� ');
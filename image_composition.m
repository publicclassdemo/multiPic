% 读取图片的信息
info = imfinfo('sample_photos\sample4.jpg');

% 获取图片的宽度和高度
width = info.Width;
height = info.Height;

% 获取图片的色彩通道（高度）
% if isfield(info, 'BitDepth')
%     bitDepth = info.BitDepth;
%     if bitDepth == 24
%         channels = 3; % RGB 图像
%     elseif bitDepth == 8
%         channels = 1; % 灰度图像
%     else
%         channels = []; % 其他类型
%     end
% else
%     channels = []; % 不存在 BitDepth 字段
% end
scale = width/height;
% 显示图片的信息
disp(['Width: ', num2str(width)]);
disp(['Height: ', num2str(height)]);
disp(['scale', num2str(scale)]);
% disp(['Channels: ', num2str(channels)]);


%% 
% 读取图片
% img1 = imread('img1.jpg');
% img2 = imread('img2.jpg');
% img3 = imread('img3.jpg');
% img4 = imread('img4.jpg');

% 获取每张图片的尺寸
for i = 1:n
[heighti, widthi, ~] = size(imgi);
end

%获取用户需要的排列方式
row = input('please input the row number');
column = input('please input the column number');

% 压缩图片到原始尺寸的一半
% imgCompressed = imresize(img, 0.5);
% imwrite(imgCompressed, 'img_compressed.jpg');

% 放大图片到原始尺寸的两倍
% imgEnlarged = imresize(img, 2);
% imwrite(imgEnlarged, 'img_enlarged.jpg');

% 将图片调整为1500x1500像素
for i = 1:n
imgResized = imresize(img, [1500 1500]);
imwrite(imgResized, 'imgi');
end

% 显示原始图片
% figure, imshow(img), title('Original Image');

% 显示压缩后的图片
% figure, imshow(imgCompressed), title('Compressed Image (0.5x)');

% 显示放大后的图片
% figure, imshow(imgEnlarged), title('Enlarged Image (2x)');

% 显示调整后的图片
% figure, imshow(imgResized), title('Resized Image (300x400)');


% 确定组合后图片的尺寸
% height = max([height1, height2, height3, height4]);
% width = max([width1, width2, width3, width4]);

% 创建一个空矩阵用于存储组合后的图片
combinedImage = uint8(zeros(1500 * row, 1500 * column, 3));

% 将每张图片放置在组合图片的正确位置
switch row
    case 1 
        switch column
            case 2
                combinedImage(1:1500, 1:1500, :) = img1;
                combinedImage(1:1500, 1501:3000, :) = img2;
        end
    case 2
        switch column
            case 2
                combinedImage(1:1500, 1:1500, :) = img1;
                combinedImage(1:1500, 1500+1:1500+1500, :) = img2;
                combinedImage(1500+1:1500+1500, 1:1500, :) = img3;
                combinedImage(1500+1:1500+1500, 1500+1:1500+1500, :) = img4;
        end
end

% 显示组合后的图片
imshow(combinedImage);

% 保存组合后的图片
imwrite(combinedImage, 'combined_image.jpg');

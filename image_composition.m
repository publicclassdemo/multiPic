%% 
clc;clear ;close all;
% 加载图像
img = imread('sample2.jpg');

% 第二步：转换为灰度图像并增强对比度
gray_img = rgb2gray(img);
enhanced_img = imadjust(gray_img);

% 第三步：使用边缘检测定位方框区域
edges = edge(enhanced_img, 'Canny', 0.3);  % 调整阈值以改进边缘检测精度
se = strel('rectangle', [5, 5]);  % 使用较小的结构元素
closed_edges = imclose(edges, se);

% 第四步：填充并标记连通区域
filled_img = imfill(closed_edges, 'holes');
[labels, num] = bwlabel(filled_img);
stats = regionprops(labels, 'Area', 'BoundingBox');
area_filter = [stats.Area] > 100;  % 只考虑较大的区域，避免标签和刻度被包括
stats = stats(area_filter);

% 找到最大的区域作为方框
[~, idx] = max([stats.Area]);
frame = stats(idx).BoundingBox;

% 第五步：创建掩码以标记方框外区域
mask = true(size(img,1), size(img,2));
x1 = ceil(frame(1));
y1 = ceil(frame(2));
x2 = x1 + frame(3) - 1;
y2 = y1 + frame(4) - 1;
mask(y1:y2, x1:x2) = false;

% 第六步：使用OCR读取图像中的所有文字
ocr_result = ocr(img);

% 第七步：提取文字位置并筛选出方框外的文字
text_positions = round([ocr_result.WordBoundingBoxes]);
texts_to_restore = ocr_result.Words(any(mask(sub2ind(size(mask), text_positions(:,2), text_positions(:,1))), 2));
text_locations = text_positions(any(mask(sub2ind(size(mask), text_positions(:,2), text_positions(:,1))), 2), :);

% 第八步：应用掩码，将方框外区域填充为白色
img(repmat(mask, [1, 1, size(img, 3)])) = 255;

% 第九步：将提取的文字恢复到原位
for k = 1:length(texts_to_restore)
    position = text_locations(k, :);
    img = insertText(img, position(1:2), texts_to_restore{k}, ...
                     'FontSize', 40, 'BoxOpacity', 0, 'TextColor', 'black');
end

% 第十步：显示并保存最终图像
imshow(img);
% imwrite(img, '/mnt/data/final_image.jpg');

%% 
clc;clear ;close all;
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
imshow("sample_photos\sample4.jpg")

%% 
img = imread("sample_photos\sample4.jpg");
% 执行OCR
results = ocr(img);

% 提取识别的文本
recognizedText = results.Text;

% 显示识别的文本
disp('Recognized Text:');
disp(recognizedText);

% 显示原始图片
figure;
imshow(img);
title('Recognized Text');

% 获取识别到的单词区域
wordBBox = results.WordBoundingBoxes;

% 在图片上绘制边界框和文字
hold on;
for i = 1:size(wordBBox, 1)
    rectangle('Position', wordBBox(i, :), 'EdgeColor', 'red');
    text(wordBBox(i, 1), wordBBox(i, 2) - 10, results.Words{i}, 'Color', 'red', 'FontSize', 12);
end
hold off;


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
            case 3
                if n == 5
                    combinedImage(1:1500, 1:1500, :) = img1;
                    combinedImage(1:1500, 1500+1:1500+1500, :) = img2;
                    combinedImage(1:1500, 1+3000:1500+3000, :) = img3;
                    combinedImage(1+1500:1500+1500, 750+1:750+1500, :) = img4;
                    combinedImage(1+1500:1500+1500, 1+750+1500:750+1500+1500, :) = img5;
                else
                    combinedImage(1:1500, 1:1500, :) = img1;
                    combinedImage(1:1500, 1500+1:1500+1500, :) = img2;
                    combinedImage(1:1500, 1+3000:1500+3000, :) = img3;
                    combinedImage(1+1500:1500+1500, 1:1500, :) = img4;
                    combinedImage(1+1500:1500+1500, 1+1500:1500+1500, :) = img5;
                    combinedImage(1+1500:1500+1500, 1+1500+1500:1500+1500+1500, :) = img6;
                end
            case 4
                    combinedImage(1:1500, 1:1500, :) = img1;
                    combinedImage(1:1500, 1500+1:1500+1500, :) = img2;
                    combinedImage(1:1500, 1+3000:1500+3000, :) = img3;
                    combinedImage(1:1500, 1+3000+1500:1500+3000+1500, :) = img4;
                    combinedImage(1+1500:1500+1500, 1:1500, :) = img5;
                    combinedImage(1+1500:1500+1500, 1+1500:1500+1500, :) = img6;
                    combinedImage(1+1500:1500+1500, 1+1500+1500:1500+1500+1500, :) = img7;
                    combinedImage(1+1500:1500+1500, 1+1500+1500+1500:1500+1500+1500+1500, :) = img8;
        end
end

% 显示组合后的图片
imshow(combinedImage);

% 保存组合后的图片
imwrite(combinedImage, 'combined_image.jpg');
%% 
clc;clear ;close all;
% 加载图像
img = imread('sample_photos\sample10.jpg');

% 转换为灰度并使用边缘检测确定方框位置
gray_img = rgb2gray(img);
edges = edge(gray_img, 'Canny');
se = strel('rectangle', [5, 5]);  % 使用较小的结构元素
closed_edges = imclose(edges, se);

% 填充并标记连通区域
filled_img = imfill(closed_edges, 'holes');
[labels, ~] = bwlabel(filled_img);
stats = regionprops(labels, 'Area', 'BoundingBox');
area_filter = [stats.Area] > 100;  % 只考虑较大的区域，避免标签和刻度被包括
stats = stats(area_filter);
imshow(img)
% 找到最大的区域作为方框
[~, idx] = max([stats.Area]);
frame = stats(idx).BoundingBox;

% 生成方框外的掩码
mask = false(size(img,1), size(img,2));
x1 = ceil(frame(1));
y1 = ceil(frame(2));
x2 = x1 + frame(3) - 1;
y2 = y1 + frame(4) - 1;
mask([1:y1, y2:end], :) = true;
mask(:, [1:x1, x2:end]) = true;

% 读取图像中的所有文本
text = ocr(img);
text_positions = round([text.WordBoundingBoxes]);

% 保留方框外的文本
texts_to_restore = text.Words(any(mask(sub2ind(size(mask), text_positions(:,2), text_positions(:,1))), 2));
text_locations = text_positions(any(mask(sub2ind(size(mask), text_positions(:,2), text_positions(:,1))), 2), :);

% 将方框外区域填充为白色
img(mask) = 255;
imshow(img);

% 调整图像大小
resized_img = imresize(img, 0.5);  % 以50%大小调整图像

% 将文本重新放置在调整后的图像上
for k = 1:length(texts_to_restore)
    % 根据调整比例更新文本位置
    new_position = round(text_locations(k,:) * 0.5);
    resized_img = insertText(resized_img, new_position(1:2), texts_to_restore{k}, ...
                             'FontSize', 12, 'BoxOpacity', 0, 'TextColor', 'black');
end

% 显示和保存最终图像
figure; imshow(resized_img);
% imwrite(resized_img, 'final_adjusted')

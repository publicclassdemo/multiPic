%% This file is used for create and develop GUI
clear;
close all;
clc;
% 创建窗口
fig = uifigure("Name", "multiPic");
fig.Position(3:4) = [600, 400];

% 创建白色背景的面板
p = uipanel(fig,"Position",[50, 50, 225, 300], BackgroundColor=[1, 1, 1]);

% 创建上传文件的按钮并绑定回调函数
pictures = Pictures();
btn = uicontrol(p, 'Style', 'pushbutton', 'String', '选择图片', 'Position', [62.5, 100, 100, 30], 'Callback', {@upload_file, pictures});


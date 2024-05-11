function upload_file(~, ~, resultsHandle)
        % 打开文件选择对话框
        [filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.gif', '图片文件 (*.jpg, *.jpeg, *.png, *.gif)'}, '选择图片');
        
        % 如果用户选择了图片文件
        if ischar(filename)
            % 读取图片文件
            img = imread(fullfile(pathname, filename));
            resultsHandle.addImage(img);
            % 显示图片
            imshow(img);
        else
            % 如果用户取消了选择，则显示提示信息
            msgbox('未选择图片文件。', '警告', 'warn');
        end
end
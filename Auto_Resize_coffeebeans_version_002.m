% ----------------------------------------------------
function y = Auto_Resize_coffeebeans_version_002()
% ----------------------------------------------------
clc;
fname = dir('D:\Project MATLAB\Code & Image\input_coffee_image\Medium\*.png');
s = size(fname,1);
for i = 1:s
    imgfilename = fname(i).name;
    auto_Resize(imgfilename);
end
%-----------------------------------------------------
function y = auto_Resize(imgfilename)
%-----------------------------------------------------

imgfilepart = 'D:\Project MATLAB\Code & Image\input_coffee_image\Medium\';
img1 = strcat(imgfilepart,imgfilename);
img = imread(img1);
%B = imresize(A,[numrows numcols])
img_red = double(img(:,:,1));
img_blue = double(img(:,:,2));
img_green = double(img(:,:,3));

red_resize   = imresize(img_red,[160 160]);
green_resize = imresize(img_blue,[160 160]);
blue_resize  = imresize(img_green,[160 160]);

out(:,:,1) = red_resize;
out(:,:,2) = green_resize;
out(:,:,3) = blue_resize;

%figure, imshow(uint8(out)), title('ok');

folderName = 'D:\Project MATLAB\Code & Image\Output_coffee_image160\Medium\';
New_name = strcat(folderName,'_resize160_',imgfilename);
imwrite(uint8(out),New_name);

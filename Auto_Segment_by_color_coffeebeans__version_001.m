% ----------------------------------------------------
function y = Auto_Segment_by_color_coffeebeans__version_001()
% ----------------------------------------------------
clc;
fname = dir('D:\Project MATLAB\Code & Image\Output_coffee_image160\Medium\*.png');
s = size(fname,1);
for i = 1:s
    imgfilename = fname(i).name;
    auto_Resize(imgfilename);
end
%-----------------------------------------------------
function y = auto_Resize(imgfilename)
%-----------------------------------------------------
imgfilepart = 'D:\Project MATLAB\Code & Image\Output_coffee_image160\Medium\';
img1 = strcat(imgfilepart,imgfilename);
img = imread(img1);
%imshow(img);
[m,n,p] = size(img);
imgBW = zeros(m,n);
img_red = double(img(:,:,1));
img_green = double(img(:,:,2));
img_blue = double(img(:,:,3));

for i=1: m
    for j=1:n
        if (img_red(i,j)>100&&img_green(i,j)>100&&img_blue(i,j)>100)
            imgBW(i,j) = 0;
        else
            imgBW(i,j) = 1; 
        end
    end
end
%  Black = 0 and white = 1
out1 = imbinarize(imgBW); 
out2 = double(out1);
%imshow(out1);

red_crop_cycle = img_red.*out1 ;
green_crop_cycle = img_green.*out1;
blue_crop_cycle = img_blue.*out1;

out(:,:,1) = red_crop_cycle;
out(:,:,2) = green_crop_cycle;
out(:,:,3) = blue_crop_cycle;

folderName = 'D:\Project MATLAB\Code & Image\Output_coffee_segment\Medium\';
New_name = strcat(folderName,'_segment_',imgfilename);
imwrite(uint8(out),New_name);
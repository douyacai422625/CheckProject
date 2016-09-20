clear 
clc

[FileName,PathName] = uigetfile('*.*','Select the input image-file');
I=double(imread([PathName FileName]))/255;
[Ir,Ic] = size(I(:,:,1));
I = imresize(I,[700,(700*Ic)/Ir]);

img_name = strcat(PathName,FileName);

h = imshow(I);

n = 3;%修改切割的份数

I1 = I(:,:,1);
I2 = I(:,:,2);
I3 = I(:,:,3);

%选择每个区域
for i = 1:n
    e = impoly;
    position = wait(e);
    p{i} = createMask(e,h);
    zuobiao{i} = find(p{i}==1);
end
I98 = cell(1,3);
for i = 1:n
    for j = 1:n
        if j ==i
            I1(zuobiao{j}(:)) = 1;
            I2(zuobiao{j}(:)) = 1;
            I3(zuobiao{j}(:)) = 1;
        else
            I1(zuobiao{j}(:)) = 0;
            I2(zuobiao{j}(:)) = 0;
            I3(zuobiao{j}(:)) = 0;
        end
    end
    I98{1,i}(:,:,1) = I1;
    I98{1,i}(:,:,2) = I2;
    I98{1,i}(:,:,3) = I3;
%     figure,imshow(I{i})
    
     scribs_img_name = I98{i};
     runMatting
end

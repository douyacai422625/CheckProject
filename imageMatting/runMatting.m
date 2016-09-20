%判断这个参数在不在，如果不在，就建立一个新的变量
if (~exist('thr_alpha','var'))
  thr_alpha=[];
end
if (~exist('epsilon','var'))
  epsilon=[];
end
if (~exist('win_size','var'))
  win_size=[];
end

if (~exist('levels_num','var'))
  levels_num=1;
end  
if (~exist('active_levels_num','var'))
  active_levels_num=1;
end  

I=double(imread(img_name))/255;
I = imresize(I,[700,(700*Ic)/Ir]);    %彩色图像
mI=scribs_img_name;      %做完标记之后的图像
consts_map=sum(abs(I-mI),3)>0.001;    %找到我所选择的区域.
%size(I,3)是判断图片I是否为3维图像。
if (size(I,3)==3)
  consts_vals=rgb2gray(mI).*consts_map;
end
if (size(I,3)==1)
  consts_vals=mI.*consts_map;
end



alpha=solveAlphaC2F(I,consts_map,consts_vals,levels_num, ...
                    active_levels_num,thr_alpha,epsilon,win_size);
alpha = alpha>0.5;
%figure, imshow(alpha);
drawnow;
[F,B]=solveFB(I,alpha);
figure, imshow([F.*repmat(alpha,[1,1,3])]);
%  ,B.*repmat(1-alpha,[1,1,3])]
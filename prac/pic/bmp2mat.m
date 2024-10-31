clear;clc;
pic = [];
pic_mat = [];

cc = 10;% ∂‡…Ÿ◊È¡∑œ∞Õº∆¨

for ii = 1:cc
    
    aa = "pic_name = 'PRA1_%d.bmp'";
    eval(sprintf(aa,ii));
    bb = "pic = imread('%s')";    
    eval(sprintf(bb,pic_name));    
    pic_mat{ii,1} = pic;
    
    aa = "pic_name = 'PRA2_%d.bmp'";
    eval(sprintf(aa,ii));
    bb = "pic = imread('%s')";    
    eval(sprintf(bb,pic_name));    
    pic_mat{ii,2} = pic;

end



pic = pic_mat;

cd ../MateMM
save prapic pic
clear;clc;
n_prac = 10;
n_block = 3;
n_trial_block = 40;

Mtrial              = 1; % 所有trial数目
Mblock_cond         = 2; % 3个block，1代表正-中匹配，2代表中-中匹配，3代表负-中匹配
Mpic_pos            = 3; %  图片的位置，1代表正-中，2代表中-正
Mdot_pos            = 4; % 点的位置，1代表左边，2代表右边
Mpic_num            = 5;% 图片的序号
MAonset             = 6; % 呈现时间
Mres                = 7; % 被试的按键，1：f，2：j，999：未反应
MRT                 = 8; % 反应时，999：未反应
Macc                = 9;%1：正确，0：错误，999：未反应

block_cond_raw = [1:n_block];% 3个block，1代表正-中匹配，2代表中-中匹配，3代表负-中匹配
block_cond_raw = block_cond_raw(randperm(length(block_cond_raw)));% 将3个block顺序随机打乱
Seq = [];

for i_block = 1: n_block
    
    pic_pos=[]; % 图片的位置，1代表正-中，2代表中-正
    dot_pos= []; % 点的位置，1代表左边，2代表右边
    block_cond = [];
    pic_num_mat = [1:60];
    pic_num = [];
    seq_num = [];
    block_cond_num = block_cond_raw(i_block);% block的类别随机
    block_cond_num2 = repmat(block_cond_num, 1, n_trial_block);
    
    pi_num1 = pic_num_mat((block_cond_num-1)*20+1:block_cond_num*20);
    pic_num2 = repmat(pi_num1, 1, 2);
    
    pic_pos_num1 = repmat(1, 1, 20);
    pic_pos_num2 = repmat(2, 1, 20);
    pic_pos_num = [pic_pos_num1 pic_pos_num2];
    
    dot_pos_num = repmat([1 2], 1, 20);
    
    block_cond = [block_cond block_cond_num2];
    pic_num = [pic_num pic_num2];% 图片的序号
    pic_pos = [pic_pos pic_pos_num];
    dot_pos = [dot_pos dot_pos_num];
    
    seq_num(:,Mblock_cond) = block_cond;    
    seq_num(:,Mpic_pos) = pic_pos;
    seq_num(:,Mdot_pos) = dot_pos;
    seq_num(:,Mpic_num) = pic_num;
    
    seq_num = seq_num(randperm(40),:);
    seq_num(:,1) = 1:n_trial_block;
    
    Seq = cat(1,Seq,seq_num);
    
end

Seq

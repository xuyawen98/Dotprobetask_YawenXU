clear;clc;
n_prac = 10;
n_block = 3;
n_trial_block = 40;

Mtrial              = 1; % ����trial��Ŀ
Mblock_cond         = 2; % 3��block��1������-��ƥ�䣬2������-��ƥ�䣬3����-��ƥ��
Mpic_pos            = 3; %  ͼƬ��λ�ã�1������-�У�2������-��
Mdot_pos            = 4; % ���λ�ã�1������ߣ�2�����ұ�
Mpic_num            = 5;% ͼƬ�����
MAonset             = 6; % ����ʱ��
Mres                = 7; % ���Եİ�����1��f��2��j��999��δ��Ӧ
MRT                 = 8; % ��Ӧʱ��999��δ��Ӧ
Macc                = 9;%1����ȷ��0������999��δ��Ӧ

block_cond_raw = [1:n_block];% 3��block��1������-��ƥ�䣬2������-��ƥ�䣬3����-��ƥ��
block_cond_raw = block_cond_raw(randperm(length(block_cond_raw)));% ��3��block˳���������
Seq = [];

for i_block = 1: n_block
    
    pic_pos=[]; % ͼƬ��λ�ã�1������-�У�2������-��
    dot_pos= []; % ���λ�ã�1������ߣ�2�����ұ�
    block_cond = [];
    pic_num_mat = [1:60];
    pic_num = [];
    seq_num = [];
    block_cond_num = block_cond_raw(i_block);% block��������
    block_cond_num2 = repmat(block_cond_num, 1, n_trial_block);
    
    pi_num1 = pic_num_mat((block_cond_num-1)*20+1:block_cond_num*20);
    pic_num2 = repmat(pi_num1, 1, 2);
    
    pic_pos_num1 = repmat(1, 1, 20);
    pic_pos_num2 = repmat(2, 1, 20);
    pic_pos_num = [pic_pos_num1 pic_pos_num2];
    
    dot_pos_num = repmat([1 2], 1, 20);
    
    block_cond = [block_cond block_cond_num2];
    pic_num = [pic_num pic_num2];% ͼƬ�����
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

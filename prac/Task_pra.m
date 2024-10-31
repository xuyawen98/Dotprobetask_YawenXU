% clear all
clear all; clc; close('all');

pra_pic_num = 10;%��ϰ��ͼƬ����666?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2                6 ?0?2?0?2                                       

%-------solve SYCHRONIZATION FAILURE-------%f

Screen('Preference','SkipSyncTests',1);
%% Set up variajjffbles 
%-g-----------------------------------------------------------------------%
prompt      =   {'���뱻�Ա��:','��ϰ����:'};
wintitle    =   '���뱻����Ϣ';
numlines    =   1;
defaultans  =   {'888888','10'};

answer      =   inputdlg(prompt,wintitle,numlines,defaultans);
subjectID   =   str2double(answer{1});                    % ���Ա��
n_trial   =   str2double(answer{2});                
s=max(Screen('Screens'));
black=BlackIndex(s); white=WhiteIndex(s); gray=GrayIndex(s); % bkGround=gray
% windowPtr = Screen('OpenWindow',0, gray);
[w, ScreenRect] = Screen('OpenWindow',0, gray);
%  Screen('Preference','TextEncodingLocale','UTF8');
% HideCursor;
% ����Ļ��������ʾ�ı�windowPtr

% DrawFormattedText(w, 'Hello, world!', 'center', 'center', [255 255 255]);
% Screen('Flip', w);
% 
% % �ر���Ļ����
% KbStrokeWait;
% sca;

% λ���������
xcenter     =   round(ScreenRect(3)/2);
ycenter     =   round(ScreenRect(4)/2);
xleft       =   round(ScreenRect(3)/4);
xright      =   round(ScreenRect(3)*3/4);
% ����ʱ�����
fixtime     =   0.5;% ע�ӵ����ʱ��
duration    =   0.5;% ͼƬ����ʱ��
blan1       =   0.05;% ��һ�ο���ʱ��
respwind    =   2;% �̼������ʱ��
blan2       =   1;% �ڶ��ο���ʱ��S
dotsize = round(min(ScreenRect(3),ScreenRect(4))/20);% ����̽���ĳ�ʼ��С
dotsize_max = dotsize;
dotsize_min = 4;
chg = 1;
dotsize_mat = [];
rt_mat = [];

n_block = 1;
n_trial_block = pra_pic_num*2;
n_trial = n_block*n_trial_block;

% ����
textSize=round(0.025*ScreenRect(3));
theFont='Simsun';
text_color = black;
lspace = 1.5 ;
Screen('TextFont',w,theFont);
Screen('TextSize',w,textSize);
Screen(w,'FillRect',white);

imgwidth=260;%ͼƬ����

imgheight=300;%ͼƬ�߶�


%% define variable
keys={'f','j'};

Mtrial              = 1; % ����trial��Ŀ
Mblock_cond         = 2; % 3��block��1������-��ƥ�䣬2������-��ƥ�䣬3������-��ƥ��
Mpic_pos            = 3; %  ͼƬ��λ�ã�1������-�У�2������-��
Mdot_pos            = 4; % ���λ�ã�1������ߣ�2�����ұ�
Mpic_num            = 5;% ͼƬ�����
MAonset             = 6; % ����ʱ��
Mres                = 7; % ���Եİ�����1��f��2��j��999��δ��Ӧ
MRT                 = 8; % ��Ӧʱ��999��δ��Ӧ
Macc                = 9;%1����ȷ��0������999��δ��Ӧ

block_cond_raw = [1:n_block];% 3��block��1������-��ƥ�䣬2������-��ƥ�䣬3������-��ƥ��
block_cond_raw = block_cond_raw(randperm(length(block_cond_raw)));% ��3��block˳���������
Seq = [];

for i_block = 1: n_block
    
    pic_pos=[]; % ͼƬ��λ�ã�1������-�У�2������-��
    dot_pos= []; % ���λ�ã�1������ߣ�2�����ұ�
    block_cond = [];
    pic_num_mat = [1:pra_pic_num];
    pic_num = [];
    seq_num = [];
    block_cond_num = block_cond_raw(i_block);% block��������S
    block_cond_num2 = repmat(block_cond_num, 1, n_trial_block);
    
    pi_num1 = pic_num_mat((block_cond_num-1)*pra_pic_num+1:block_cond_num*pra_pic_num);
    pic_num2 = repmat(pi_num1, 1, 2);
    
    pic_pos_num1 = repmat(1, 1, pra_pic_num);
    pic_pos_num2 = repmat(2, 1, pra_pic_num);
    pic_pos_num = [pic_pos_num1 pic_pos_num2];
    
    dot_pos_num = repmat([1 2], 1, pra_pic_num);
    
    block_cond = [block_cond block_cond_num2];
    pic_num = [pic_num pic_num2];% ͼƬ�����
    pic_pos = [pic_pos pic_pos_num];
    dot_pos = [dot_pos dot_pos_num];
    
    seq_num(:,Mblock_cond) = block_cond;    
    seq_num(:,Mpic_pos) = pic_pos;
    seq_num(:,Mdot_pos) = dot_pos;
    seq_num(:,Mpic_num) = pic_num;
    
    seq_num = seq_num(randperm(pra_pic_num*2),:);
    seq_num(:,1) = 1:n_trial_block;
    
    Seq = cat(1,Seq,seq_num);
    
end


load 'MateMM\\prapic.mat';

%% get ready to go
HideCursor;
FlushEvents('keyDown');	 
baselinepos=1;
%%% get started instruction here
instru={{double('��ӭ����������Ϊʵ�飬������������ ????')}...
    {''}...
    {double('���ȣ���Ļ����������һ��ע�ӵ� + ')}...
    {''}...
    {double('�������ٹ۲���Ļͬʱ���ֵ����Ų�ͬ���ͼƬ')}...
    {''}...
    {double('ͼƬ��ʧ��ĳһ��ͼƬλ���ϻ����һ����ɫԲ��')}...
    {''}...
    {double('����Ѹ��׼ȷ�ж�Բ���λ��')}...
    {''}...
    {double('Բ��������밴��F���������ұ��밴��J����')}...
    {''}...
      {double('������������10����ϰ������Ϥʵ�����')}...
    {''}...
    {double('�� S ����ʼ')}...
    };
Screen(w,'TextSize',round(textSize));
Screen(w,'FillRect',gray);

for i=1:size(instru,2)
    textbox = Screen('TextBounds', w, double('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'));
    Screen(w,'DrawText', instru{i}{:}, xcenter-textbox(3)/2, i*(textSize+5), black);
end

Screen('Flip',w);

folder = fileparts(mfilename('fullpath'));
c=clock;
d=date;
outfile=sprintf('%s\\Results\\pra_test_Sub%03d_%s_%02.0f_%02.0f',folder,subjectID,date,c(4),c(5));% �ļ�������

%% start presentation
PlaySound;
WaitTrigger;

startSecs=GetSecs; 
onset=0;
n_trial   =   str2double(answer{2});
% ����һ�����ڼ�¼���Ա��ֵĽṹ��
performance = struct('rt', [], 'accuracy', []);

try
    for i_trial=1:n_trial %%%
        
        %fixation       
        DrawFormattedText(w, '+', 'center', 'center',[0 0 0]);
        Screen('Flip', w);
        
        if Seq(i_trial,Mpic_pos) == 1
            imageleft = pic{Seq(i_trial,Mpic_num),1};
            imageright = pic{Seq(i_trial,Mpic_num),2};
        else %�������λ��
            imageleft = pic{Seq(i_trial,Mpic_num),2};
            imageright = pic{Seq(i_trial,Mpic_num),1};
        end
        
        imgleftpos = [round(xleft -imgwidth/2),round(ycenter-imgheight/2),round(xleft+imgwidth/2),round(ycenter+imgheight/2)];
        imgrightpos = [round(xright-imgwidth/2),round(ycenter-imgheight/2),round(xright+imgwidth/2),round(ycenter+imgheight/2)];
        Screen(w,'PutImage',imageright,imgleftpos );
        Screen(w,'PutImage',imageleft,imgrightpos);
        
        WaitSecs(fixtime); 
        Screen('Flip',w); 
        Seq(i_trial,MAonset)=GetSecs - startSecs;%��¼����ʱ��
        WaitSecs(duration);
        Screen('Flip',w);       
        
        if Seq(i_trial,Mpic_pos) == 1
            Screen('DrawDots', w,[xleft, ycenter],dotsize,[0 0 0],[0 0],1);%���
        else
            Screen('DrawDots', w,[xright, ycenter],dotsize,[0 0 0],[0 0],1);   %�Ҳ�
        end
        
        WaitSecs(blan1);
        Screen('Flip',w,[],1);             
        
        repstart=GetSecs;
        
        [key,timeSec]=WaitTill(repstart + respwind,keys,1);
        
        if ~isempty(key)  
            clickSec=GetSecs;
            num=strfind(cell2mat(keys),key);
            Seq(i_trial,Mres)=num;
            Seq(i_trial,MRT)=clickSec-repstart;
            Seq(i_trial,Macc)=(num==Seq(i_trial,Mpic_pos));%1��ȷ��0����
                        
        end
        Screen('Flip',w);  
        if isempty(key) 
            Seq(i_trial,Mres)=999;
            Seq(i_trial,MRT)=respwind;
            Seq(i_trial,Macc)=0;%1��ȷ��0����
        end
        WaitSecs(blan2);
        performance(i_trial).rt = Seq(i_trial,MRT);
        performance(i_trial).accuracy = Seq(i_trial,Macc);
        mean_accuracy = mean([performance.accuracy]);
        mean_rt = mean([performance.rt]);
        
        dotsize_mat(i_trial,1) = dotsize;
        % ���ݷ�Ӧʱ�����̽����С
        if  i_trial <=3 && Seq(i_trial,Macc) == 1          
            dotsize = round(dotsize_mat(i_trial,1)*0.7);
        elseif i_trial <= 3 && Seq(i_trial,Macc) == 0
            dotsize = round(dotsize_mat(i_trial,1)*1.3);
        elseif i_trial == 1 && Seq(i_trial,Macc) == 1 
            dotsize = round(dotsize*0.7);
        elseif i_trial == 1 && Seq(i_trial,Macc) == 0 
            dotsize = round(dotsize*1.3);  
        elseif i_trial > 3 && Seq(i_trial,Macc) == 1 && std([performance(end-3:end).rt]) > 0.05 &&  chg
            min_num = find([performance(end-3:end).rt]==min([performance(end-3:end).rt]))+length([performance.rt])-4;
            dotsize = round(mean([dotsize_mat(min_num,1),dotsize_mat(i_trial,1)]));
        elseif i_trial > 3 && Seq(i_trial,Macc) == 0 &&  chg
            dotsize = round(dotsize_mat(i_trial,1)*1.2);
        elseif i_trial > 3 && Seq(i_trial,Macc) == 1 && mean_accuracy > 0.9 && std([performance(end-3:end).rt]) <= 0.05 &&  chg
            chg = 0;
            min_num = find([performance(end-3:end).rt]==min([performance(end-3:end).rt]))+length([performance.rt])-4;
            dotsize = dotsize_mat(min_num,1);
        end            
           

        
        % ��Ϣ
        if Seq(i_trial,Mtrial)==n_trial_block
            DrawFormattedText(w, double('����Ϣһ��\n�����������'), 'center', 'center', text_color,[],[],[],lspace);
            Screen('Flip', w);
            KbStrokeWait
        end
 
    end
    eval(sprintf('save %s Seq',outfile));
    dotfile=sprintf('%s\\Results\\pra_test_Sub%03d_dotsize',folder,subjectID);% �ļ�������
    eval(sprintf('save %s dotsize',dotfile));
    Screen(w,'TextSize',round(textSize));
    textbox = Screen('TextBounds', w, double('���������!'));
    Screen(w,'DrawText',double('���������!'),xcenter-textbox(3)/2,ycenter-textbox(4)/2,black);
    Screen('Flip',w);
    WaitSecs(1);
catch
    outfile=sprintf('%s\\Results\\tmp_pra_test_sub%03d_%s_%02.0f-%02.0f',folder,subjectID,d(1:6),c(4),c(5));
    eval(sprintf('save %s Seq',outfile));
    dotfile=sprintf('%s\\Results\\tmp_pra_test_Sub%03d',folder,subjectID);% �ļ�������
    eval(sprintf('save %s dotsize',dotfile));
    Screen('CloseAll');
    lasterr
end

Screen('CloseAll');

dotsize
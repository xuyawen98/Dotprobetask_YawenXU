% clear all
clear all; clc; close('all');

pra_pic_num = 10;%练习的图片组数666?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2?0?2                6 ?0?2?0?2                                       

%-------solve SYCHRONIZATION FAILURE-------%f

Screen('Preference','SkipSyncTests',1);
%% Set up variajjffbles 
%-g-----------------------------------------------------------------------%
prompt      =   {'输入被试编号:','练习次数:'};
wintitle    =   '输入被试信息';
numlines    =   1;
defaultans  =   {'888888','10'};

answer      =   inputdlg(prompt,wintitle,numlines,defaultans);
subjectID   =   str2double(answer{1});                    % 被试编号
n_trial   =   str2double(answer{2});                
s=max(Screen('Screens'));
black=BlackIndex(s); white=WhiteIndex(s); gray=GrayIndex(s); % bkGround=gray
% windowPtr = Screen('OpenWindow',0, gray);
[w, ScreenRect] = Screen('OpenWindow',0, gray);
%  Screen('Preference','TextEncodingLocale','UTF8');
% HideCursor;
% 在屏幕窗口上显示文本windowPtr

% DrawFormattedText(w, 'Hello, world!', 'center', 'center', [255 255 255]);
% Screen('Flip', w);
% 
% % 关闭屏幕窗口
% KbStrokeWait;
% sca;

% 位置坐标参数
xcenter     =   round(ScreenRect(3)/2);
ycenter     =   round(ScreenRect(4)/2);
xleft       =   round(ScreenRect(3)/4);
xright      =   round(ScreenRect(3)*3/4);
% 呈现时间参数
fixtime     =   0.5;% 注视点呈现时间
duration    =   0.5;% 图片呈现时间
blan1       =   0.05;% 第一次空屏时间
respwind    =   2;% 刺激点呈现时间
blan2       =   1;% 第二次空屏时间S
dotsize = round(min(ScreenRect(3),ScreenRect(4))/20);% 设置探测点的初始大小
dotsize_max = dotsize;
dotsize_min = 4;
chg = 1;
dotsize_mat = [];
rt_mat = [];

n_block = 1;
n_trial_block = pra_pic_num*2;
n_trial = n_block*n_trial_block;

% 字体
textSize=round(0.025*ScreenRect(3));
theFont='Simsun';
text_color = black;
lspace = 1.5 ;
Screen('TextFont',w,theFont);
Screen('TextSize',w,textSize);
Screen(w,'FillRect',white);

imgwidth=260;%图片宽度

imgheight=300;%图片高度


%% define variable
keys={'f','j'};

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
    pic_num_mat = [1:pra_pic_num];
    pic_num = [];
    seq_num = [];
    block_cond_num = block_cond_raw(i_block);% block的类别随机S
    block_cond_num2 = repmat(block_cond_num, 1, n_trial_block);
    
    pi_num1 = pic_num_mat((block_cond_num-1)*pra_pic_num+1:block_cond_num*pra_pic_num);
    pic_num2 = repmat(pi_num1, 1, 2);
    
    pic_pos_num1 = repmat(1, 1, pra_pic_num);
    pic_pos_num2 = repmat(2, 1, pra_pic_num);
    pic_pos_num = [pic_pos_num1 pic_pos_num2];
    
    dot_pos_num = repmat([1 2], 1, pra_pic_num);
    
    block_cond = [block_cond block_cond_num2];
    pic_num = [pic_num pic_num2];% 图片的序号
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
instru={{double('欢迎来到本次行为实验，具体流程如下 ????')}...
    {''}...
    {double('首先，屏幕正中央会出现一个注视点 + ')}...
    {''}...
    {double('请您快速观察屏幕同时呈现的两张不同面孔图片')}...
    {''}...
    {double('图片消失在某一张图片位置上会出现一个黑色圆点')}...
    {''}...
    {double('请您迅速准确判断圆点的位置')}...
    {''}...
    {double('圆点在左边请按【F】键；在右边请按【J】键')}...
    {''}...
      {double('接下来，您有10次练习用来熟悉实验操作')}...
    {''}...
    {double('按 S 键开始')}...
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
outfile=sprintf('%s\\Results\\pra_test_Sub%03d_%s_%02.0f_%02.0f',folder,subjectID,date,c(4),c(5));% 文件的名称

%% start presentation
PlaySound;
WaitTrigger;

startSecs=GetSecs; 
onset=0;
n_trial   =   str2double(answer{2});
% 定义一个用于记录被试表现的结构体
performance = struct('rt', [], 'accuracy', []);

try
    for i_trial=1:n_trial %%%
        
        %fixation       
        DrawFormattedText(w, '+', 'center', 'center',[0 0 0]);
        Screen('Flip', w);
        
        if Seq(i_trial,Mpic_pos) == 1
            imageleft = pic{Seq(i_trial,Mpic_num),1};
            imageright = pic{Seq(i_trial,Mpic_num),2};
        else %否则调换位置
            imageleft = pic{Seq(i_trial,Mpic_num),2};
            imageright = pic{Seq(i_trial,Mpic_num),1};
        end
        
        imgleftpos = [round(xleft -imgwidth/2),round(ycenter-imgheight/2),round(xleft+imgwidth/2),round(ycenter+imgheight/2)];
        imgrightpos = [round(xright-imgwidth/2),round(ycenter-imgheight/2),round(xright+imgwidth/2),round(ycenter+imgheight/2)];
        Screen(w,'PutImage',imageright,imgleftpos );
        Screen(w,'PutImage',imageleft,imgrightpos);
        
        WaitSecs(fixtime); 
        Screen('Flip',w); 
        Seq(i_trial,MAonset)=GetSecs - startSecs;%记录呈现时间
        WaitSecs(duration);
        Screen('Flip',w);       
        
        if Seq(i_trial,Mpic_pos) == 1
            Screen('DrawDots', w,[xleft, ycenter],dotsize,[0 0 0],[0 0],1);%左侧
        else
            Screen('DrawDots', w,[xright, ycenter],dotsize,[0 0 0],[0 0],1);   %右侧
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
            Seq(i_trial,Macc)=(num==Seq(i_trial,Mpic_pos));%1正确，0错误
                        
        end
        Screen('Flip',w);  
        if isempty(key) 
            Seq(i_trial,Mres)=999;
            Seq(i_trial,MRT)=respwind;
            Seq(i_trial,Macc)=0;%1正确，0错误
        end
        WaitSecs(blan2);
        performance(i_trial).rt = Seq(i_trial,MRT);
        performance(i_trial).accuracy = Seq(i_trial,Macc);
        mean_accuracy = mean([performance.accuracy]);
        mean_rt = mean([performance.rt]);
        
        dotsize_mat(i_trial,1) = dotsize;
        % 根据反应时间更新探测点大小
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
           

        
        % 休息
        if Seq(i_trial,Mtrial)==n_trial_block
            DrawFormattedText(w, double('请休息一下\n按任意键继续'), 'center', 'center', text_color,[],[],[],lspace);
            Screen('Flip', w);
            KbStrokeWait
        end
 
    end
    eval(sprintf('save %s Seq',outfile));
    dotfile=sprintf('%s\\Results\\pra_test_Sub%03d_dotsize',folder,subjectID);% 文件的名称
    eval(sprintf('save %s dotsize',dotfile));
    Screen(w,'TextSize',round(textSize));
    textbox = Screen('TextBounds', w, double('本任务结束!'));
    Screen(w,'DrawText',double('本任务结束!'),xcenter-textbox(3)/2,ycenter-textbox(4)/2,black);
    Screen('Flip',w);
    WaitSecs(1);
catch
    outfile=sprintf('%s\\Results\\tmp_pra_test_sub%03d_%s_%02.0f-%02.0f',folder,subjectID,d(1:6),c(4),c(5));
    eval(sprintf('save %s Seq',outfile));
    dotfile=sprintf('%s\\Results\\tmp_pra_test_Sub%03d',folder,subjectID);% 文件的名称
    eval(sprintf('save %s dotsize',dotfile));
    Screen('CloseAll');
    lasterr
end

Screen('CloseAll');

dotsize
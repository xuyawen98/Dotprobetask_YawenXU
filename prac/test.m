% clear all
clear all; clc; close('all');                                  

%-------solve SYCHRONIZATION FAILURE-------%f

Screen('Preference','SkipSyncTests',1);
AssertOpenGL;
%% Set up variables 

s=max(Screen('Screens'));
black=BlackIndex(s); white=WhiteIndex(s); gray=GrayIndex(s); % bkGround=gray
% windowPtr = Screen('OpenWindow',0, gray);
[w, ScreenRect] = Screen('OpenWindow',0, gray);
Priority(MaxPriority(w));
Screen('Preference','TextEncodingLocale','UTF8');
% HideCursor;
% 在屏幕窗口上显示文本windowPtr

xcenter     =   round(ScreenRect(3)/2);
ycenter     =   round(ScreenRect(4)/2);
xleft       =   round(ScreenRect(3)/4);
xright      =   round(ScreenRect(3)*3/4);

textSize=round(0.025*ScreenRect(3));
theFont='Simhei';
% % text_color = black;
% % lspace = 1.5 ;
% Screen('TextFont',w,theFont);
% Screen('TextSize',w,textSize);
% Screen(w,'FillRect',white);


DrawFormattedText(w, 'Hello, world!', 'center', 'center', [255 255 255]);
Screen('Flip', w);
WaitSecs(5);

% instru={{double('指导语')}...
%     {''}...
%     {double('第二行')}...
%     {''}...
%     {double('第三行')}...
%     {''}...
%     {double('按 S 键开始')}...
%     };
% Screen(w,'FillRect',gray);
% 
% for i=1:size(instru,2)
%     textbox = Screen('TextBounds', w, double('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'));
%     Screen(w,'DrawText', instru{i}{:}, xcenter-textbox(3)/2, i*(textSize+5), black);
% end

Priority(0);
sca;

% % 位置坐标参数
% xcenter     =   round(ScreenRect(3)/2);
% ycenter     =   round(ScreenRect(4)/2);
% xleft       =   round(ScreenRect(3)/4);
% xright      =   round(ScreenRect(3)*3/4);
% 
% 
% 
% % 字体
% textSize=round(0.025*ScreenRect(3));
% theFont='Simsun';
% text_color = black;
% lspace = 1.5 ;
% Screen('TextFont',w,theFont);
% Screen('TextSize',w,textSize);
% Screen(w,'FillRect',white);
% 
% 
% 
% load 'MateMM/prapic.mat';
% 
% %% get ready to go
% HideCursor;
% FlushEvents('keyDown');	 
% baselinepos=1;
% %%% get started instruction here
instru={{double('指导语')}...
    {''}...
    {double('第二行')}...
    {''}...
    {double('第三行')}...
    {''}...
    {double('按 S 键开始')}...
    };
Screen(w,'TextSize',round(textSize));
Screen(w,'FillRect',gray);

for i=1:size(instru,2)
    textbox = Screen('TextBounds', w, double('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'));
    Screen(w,'DrawText', instru{i}{:}, xcenter-textbox(3)/2, i*(textSize+5), black);
end

Screen('Flip',w);
% 
% 
% Screen('CloseAll');

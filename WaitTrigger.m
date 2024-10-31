function varargout = WaitTrigger(ignoreNum)
% 
% Usage: [timeSecs = ] WaitTrigger([ignoreNum]);
%
% Wait for scanner trigger (key press 5) and return the trigger time. The
% optional input specifies how many triggers to ignore (default 0). Press
% ESC will abort code execution and clear screen. 
 
% 2006/04   xl wrote it
% 2011/05   xl added GetChar, to solve the fOPR problem

if nargin<1, ignoreNum=0; end
for i=0:ignoreNum
    [~, secs]=WaitTill('s');
    KbReleaseWait;
end
if nargout, varargout={secs}; end

function PlaySound(wave, SampleRate, isParallel)
% Learning tasks for QuickLearning, event related design 
% Created by xfgavin, Jul 19, 2011
%%%% setup the sound staff
%%%% Setting up the sound stuff
%isParallel: 1 means play rest scripts in parallel;
%            0 means wait till current sound sequence finish
% Snd('Open');
clear playsnd;
if nargin ==0
    SampleRate=44100;
    aud_stim = sin(1:0.25:1000);
    aud_delay = []; 		
    aud_padding = zeros(1, round(0.005*SampleRate));	%%% Padding lasts for 5ms
    wave = [  aud_delay  aud_padding  aud_stim  0 ];	% Vector fed into SND
    Snd('Play',wave,SampleRate); %play sound to start
					% The zero at the end prevents a click at the start
					% of the next sound to be played. Suggested by Denis Pelli
elseif nargin==1
    SampleRate=44100;
    Snd('Play',wave,SampleRate); %play sound to start
elseif nargin==2
    Snd('Play',wave,SampleRate); %play sound to start
elseif nargin==3
    Snd('Play',wave,SampleRate); %play sound to start
    if ~isParallel
        Snd('Wait');
    end
end
% Snd('Close');
% clear playsnd;
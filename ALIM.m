%% --------- [The Methodology of Adaptive Levels of Interval] ---------- %%
% This function implements the mathematical equations for the 
% Methodology of Adaptive Levels of Interval.

% Copyright (c) 2025 holder: 
% Ali A. Al-Temeemy is a Professor in the Department of Laser and 
% Optoelectronics Engineering at Al-Nahrain University and an honorary 
% research fellow in the Department of Electrical Engineering and 
% Electronics at the University of Liverpool.

% In return for making this code available, I would appreciate that you 
% cite the following publications:

% [1]
% Al-Temeemy AA. The Methodology of Adaptive Levels of Interval for Laser 
% Speckle Imaging. Journal of Imaging. 2024; 10(11):289.
% https://doi.org/10.3390/jimaging10110289

% [2]
% Ali A. Al-Temeemy, ALI: The adaptive levels of interval method for processing 
% laser speckle images with superior activity extraction and discrimination 
% capabilities, Optics and Lasers in Engineering, Volume 178, 2024, 108173, 
% ISSN 0143-8166, https://doi.org/10.1016/j.optlaseng.2024.108173

%% --------------------------------------------------------------------- %%

function [AI]=ALIM(I,M,TAP) 
%% Inputs:
% I: Input speckle frames.
% M: Number of interval levels.
% TAP: Time-variant intensity analysis approach.
%% Outputs:
% AI: Activity image for all levels.
%% ----------------------------- [ Main ] ------------------------------ %%
%% --- [Interval Values for each Interval Level]
T=zeros(1,M);T(1)=((2.^(M+1))-2); % Create interval vector.
for L=2:M
    T(L)=(T(L-1)/2)-1;
end
%% --- [Calculate Shift Vector for Interval Levels]
t=zeros(1,2.^(M-1)); % Create shift vector.
for n=1:2^(M-1)
    for k=2:M
    t(n)=t(n)+(1-sign(mod(n,2^(k-1))));
    end
    t(n)=2*t(n);
end
%% ---[Main Loop]
[D1,D2,N]=size(I); % Data Size.
AIL=zeros(D1,D2,M); % Create Multi-interval level Matrix.
for L=1:M  % For each Interval Level.
% Number of valid samples per level.
NN=(2^(L-1))*floor(N/T(1)) + floor(max(0,(mod(N,T(1))+2-(2.^L))/T(L)));
    for k=1:NN
        if k==1;alk=L;
        else
        ulk=((1+sign(-mod(k-1,2^(L-1))))*2^(L-1))+mod(k-1,2^(L-1));    
        alk=blk+t(ulk)+1;
        end % akl.
        blk=alk+T(L)-1; % bkl;
        % Activity image.
        AIL(:,:,L)=AIL(:,:,L)+TAP(I(:,:,alk),I(:,:,blk)); % AI for each L.
    end
AIL(:,:,L)=AIL(:,:,L)/NN;
end
% Interval Level Weighted Equation.
v=zeros(D1,D2,M);v(:,:,0 +1)=AIL(:,:,1);
if M>1;for n=1:M-1;v(:,:,n +1)=AIL(:,:,n+1)+v(:,:,n-1 +1).*(1-AIL(:,:,n+1));end;end
AI=v(:,:,M-1 +1); %  Activity Image for weighted Levels.
end
%% --------------------------------------------------------------------- %%
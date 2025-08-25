%% ----------------- [ALI Methodology Demonstration] ------------------- %%
% This file demonstrates the effectiveness of the ALI methodology on the 
% extraction and discrimination capabilities of standard speckle pattern 
% methods. It reads dynamic speckle patterns from the "Speckles.mat" file,
% processes them using the "ALIM.m" function, and displays the extracted 
% activity map. It also allows the user to select different "Time-variant
% intensity analysis approaches" that correspond to the standard speckle
% pattern methods.

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

%% --------------------- Speckle Patterns Reading ---------------------- %%
clear;close all;clc; % Initialization.
load('Speckles'); % Load Speckles Patterns Frames.
Speckles=double(Speckles)/255; % Double conversion and Normalization.
%% --------------------------------------------------------------------- %%

%% --- [Select the type of Time-variant intensity analysis approach] --- %%
TAP=@(a,b) (abs(a-b)); % Absolute Difference.   
% TAP=@(a,b) (a-b).^2;   % Inertia Moment.
% TAP=@(a,b) (abs(a-b)./(a+b+eps)); % Fujii Method.
%% --------------------------------------------------------------------- %%

%% --------- [The Methodology of Adaptive Levels of Interval] ---------- %%
% --[Calculate the Number of interval levels (TL) Automatically]
[d1,d2,d3]=size(Speckles);for TL=3:10;e=0; 
for k=0:TL-1;e=e+((2^k)*2);end;if e>d3;TL=TL-1;break;end;end
% --[Set the Number of interval levels]
% TL=6; %             [**Uncomment to Set (TL) Value Manually**]
% --[Apply ALI Methodology]
ALIM=ALIM(Speckles,TL,TAP); 
%% --------------------------------------------------------------------- %%

%% ----------------------- [Display Activity Map] ---------------------- %%
figure;imagesc(ALIM);colormap turbo;cb = colorbar(); 
ylabel(cb,'Activity Values','FontSize',12,'Rotation',270)
xlabel('Pixels');ylabel('Pixels');
title('The Methodology of Adaptive Levels of Interval [Activity Map]');
%% --------------------------------------------------------------------- %%
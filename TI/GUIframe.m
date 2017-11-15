function varargout = GUIframe(varargin)
% GUIFRAME M-file for GUIframe.fig
%      GUIFRAME, by itself, creates a new GUIFRAME or raises the existing
%      singleton*.
%
%      H = GUIFRAME returns the handle to a new GUIFRAME or the handle to
%      the existing singleton*.
%
%      GUIFRAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUIFRAME.M with the given input arguments.
%
%      GUIFRAME('Property','Value',...) creates a new GUIFRAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUIframe_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUIframe_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUIframe

% Last Modified by GUIDE v2.5 13-JAN-2013 15:05:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIframe_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIframe_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUIframe is made visible.
function GUIframe_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUIframe (see VARARGIN)

% Choose default command line output for GUIframe
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIframe wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIframe_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%% Point detection
Y = imread('D:\Rohit\TI\tiecd\gray1.jpg');
Y1= bwareaopen(Y, 20);
fplap = [1 1 1; 1 -8 1; 1 1 1];     
fplap = [0 1 0; 1 -4 1; 0 1 0];      
filtim = imfilter(Y,fplap,'symmetric', 'conv');

figure;
subplot(2,2,1)
imshow(Y);
title('Original');

subplot(2,2,2);
imshow(filtim);
title('Laplacian Point Filtered');

subplot(2,2,3)
imshow(Y-filtim);
title('Difference Image');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
%Edge Detection
i = imread('D:\Rohit\TI\tiecd\gray1.jpg');
figure;
I = rgb2gray(i);
BW3= edge(I,'roberts');
subplot (2,2,1);
imshow(I);
title('original');
subplot(2,2,2);
imshow(BW3); 
title('Roberts'); 



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
%Angular rotation
I  = imread('D:\Rohit\TI\tiecd\gray1.jpg');
figure;
rotI = imrotate(I,33,'crop');
fig1 = imshow(rotI);
BW = edge(rotI,'canny');
figure, imshow(BW);
[H,theta,rho] = hough(BW);
figure, imshow(imadjust(mat2gray(H)),[],'XData',theta,'YData',rho,...
        'InitialMagnification','fit');
xlabel('\theta (degrees)'), ylabel('\rho');
axis on, axis normal, hold on;
colormap(hot)
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = theta(P(:,2));
y = rho(P(:,1));
plot(x,y,'s','color','black');
lines = houghlines(BW,theta,rho,P,'FillGap',5,'MinLength',7);
figure, imshow(rotI), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
%Segmentation
clc;
J = imread ('D:\Rohit\TI\tiecd\gray1.jpg ');
figure;
I = rgb2gray (J);
subplot (131), imshow (I);
title ('original image')
% The following MATLAB function to calculate the threshold
level = graythresh (I);
%Otsu method to calculate the global threshold of image I
BW = im2bw (I, level);
 % Threshold segmentation
subplot (132), imshow (BW)
title ('graythresh calculating a threshold value')
disp (strcat ('graythresh calculated grayscale threshold: of',  num2str( uint16 (level * 255))))
 % The following MATLAB program to simplify the calculation value
iMax = max (max (I));
iMin = min (min (I));
 % Calculated maximum and minimum values
T = double (iMin: iMax);
iSize = size (I);
muxSize = iSize (1) * iSize (2);
for i = 1: length (T)
       % Variance were calculated from the minimum gray value to the maximum value
       TK = T (1, i);
       iForeground = 0;
       iBackground = 0;
       % Define the foreground and background of the number of
       ForegroundSum = 0;
       BackgroundSum = 0;
       % Define the foreground and background grayscale sum
       for j = 1: iSize (1)
            for k = 1: iSize (2)
                tmpData = I (j, k);
                if (tmpData >= TK)
                 % Foreground pixel point calculation
                 iForeground = iForeground +1;
                 ForegroundSum = ForegroundSum + double (tmpData);
                else
                     %The calculation of the background pixels
                     iBackground = iBackground +1;
                     BackgroundSum = BackgroundSum + double (tmpData);
                 end
              end
            end
            % Proportion of the foreground and the background and the average gradation value
            % There is a 0 denominator, causing alarm, the solution is simple, but does not affect the results, the reader is improved
            w0 = iForeground / muxSize;
            w1 = iBackground / muxSize;
            u0 = ForegroundSum / iForeground;
            u1 = BackgroundSum / iBackground;
            T (2, i) = w0 * w1 * (u0-u1) * (u0-u1);
            % Second is to calculate the variance
     end
oMax = max (T (2, :));
% Second line of maximum variance, slightly NaN
idx = T (2, :) >= oMax;
% Variance corresponding to the maximum column number
T = uint8 (T (1, idx));
% From the first line to remove the gray value as a threshold value
disp (strcat ('the simplify Otsu method to calculate the grayscale threshold:',num2str (T)))
BW = im2bw (I, double (T) / 255);
% Threshold segmentation
subplot (133), imshow (BW)
title ('Otsu threshold')



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
%Text extraction
clc;
clear all;
%k=input('Enter the file name','C:\Users\Dashpreet\Downloads\gray111.jpg'); % input image; color image
im=imread('D:\Rohit\TI\tiecd\gray111.jpg');
im1=rgb2gray(im);
[X, map]=imread('clipim2','gif');

Y=ind2gray(X,map); 
C_r =304; % cycle change for the red channel

P_r=0; % phase change for the red channel

C_b=804; % cycle change for the blue channel

P_b=60; % phase change for the blue channel

C_g=304; % cycle change for the green channel

P_g=60; % phase change for the green channel

r=abs(sin(2*pi*[-P_r:255-P_r]/C_r));

g=abs(sin(2*pi*[-P_b:255-P_b]/C_b));

b=abs(sin(2*pi*[-P_g:255-P_g]/C_g));

figure, subplot(3,1,1);plot(r,'r');grid;ylabel('R value')

subplot(3,1,2);plot(g,'g');grid;ylabel('G value');

subplot(3,1,3);plot(b,'b');grid;ylabel('B value');

figure, imshow(Y);

map=[r;g;b;]'; % construct color map

figure, imshow(Y,map); % display pseudo color image
im1=medfilt2(im1,[3 3]); %Median filtering the image to remove noise%
BW = edge(im1,'sobel'); %finding edges 
[imx,imy]=size(BW);
msk=[0 0 0 0 0;
 0 1 1 1 0;
 0 1 1 1 0;
 0 1 1 1 0;
 0 0 0 0 0;];
B=conv2(double(BW),double(msk)); %Smoothing  image to reduce the number of connected     components
L = bwlabel(B,8);% Calculating connected components
mx=max(max(L));
% There will be mx connected components.Here U can give a value between 1 and mx for L     or in a loop you can extract all connected components
% If you are using the attached car image, by giving 17,18,19,22,27,28 to L you can     extract the number plate completely.
[r,c] = find(L==17);  
rc = [r c];
[sx sy]=size(rc);
n1=zeros(imx,imy); 
for i=1:sx
x1=rc(i,1);
y1=rc(i,2);
n1(x1,y1)=255;
end % Storing the extracted image in an array
figure,imshow(im1);
figure,imshow(im);
figure,imshow(B);
%figure,imshow(n1,[]);



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('D:\Rohit\TI\tiecd\tie11.png')
% Hint: place code in OpeningFcn to populate axes1

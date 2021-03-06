function varargout = MainFrm(varargin)
% MAINFRM M-file for MainFrm.fig
%      MAINFRM, by itself, creates a new MAINFRM or raises the existing
%      singleton*.
%
%      H = MAINFRM returns the handle to a new MAINFRM or the handle to
%      the existing singleton*.
%
%      MAINFRM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINFRM.M with the given input arguments.
%
%      MAINFRM('Property','Value',...) creates a new MAINFRM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainFrm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainFrm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainFrm

% Last Modified by GUIDE v2.5 15-Jan-2013 15:11:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainFrm_OpeningFcn, ...
                   'gui_OutputFcn',  @MainFrm_OutputFcn, ...
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


% --- Executes just before MainFrm is made visible.
function MainFrm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainFrm (see VARARGIN)

% Choose default command line output for MainFrm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainFrm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainFrm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in MainFrmSTART.
function MainFrmSTART_Callback(~, ~, ~)
GUIframe;
% hObject    handle to MainFrmSTART (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(~, ~, ~)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
%# read text file lines as cell array of strings
fid = fopen( fullfile('C:\Users\user\Documents\bapu work\TI\textmatlab.txt') );
str = textscan(fid, '%s', 'Delimiter','\n'); str = str{1};
fclose(fid);

%# GUI with multi-line editbox
hFig = figure('Menubar','none', 'Toolbar','none');
hPan = uipanel(hFig, 'Title','Display window', ...
    'Units','normalized', 'Position',[0.05 0.05 0.9 0.9]);
hEdit = uicontrol(hPan, 'Style','edit', 'FontSize',9, ...
    'Min',0, 'Max',2, 'HorizontalAlignment','left', ...
    'Units','normalized', 'Position',[0 0 1 1], ...
    'String',str);

%# enable horizontal scrolling
jEdit = findjobj(hEdit);
jEditbox = jEdit.getViewport().getComponent(0);
jEditbox.setWrapping(false);                %# turn off word-wrapping
jEditbox.setEditable(false);                %# non-editable
set(jEdit,'HorizontalScrollBarPolicy',30);  %# HORIZONTAL_SCROLLBAR_AS_NEEDED

%# maintain horizontal scrollbar policy which reverts back on component resize 
hjEdit = handle(jEdit,'CallbackProperties');
set(hjEdit, 'ComponentResizedCallback',...
    'set(gcbo,''HorizontalScrollBarPolicy'',30)')
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.


% --- Executes during object creation, after setting all properties.

% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
axes(hObject)
imshow('C:\Users\user\Documents\bapu work\TI\tiecd\tie11.png')

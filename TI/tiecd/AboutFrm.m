function varargout = AboutFrm(varargin)
% ABOUTFRM M-file for AboutFrm.fig
%      ABOUTFRM, by itself, creates a new ABOUTFRM or raises the existing
%      singleton*.
%
%      H = ABOUTFRM returns the handle to a new ABOUTFRM or the handle to
%      the existing singleton*.
%
%      ABOUTFRM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ABOUTFRM.M with the given input arguments.
%
%      ABOUTFRM('Property','Value',...) creates a new ABOUTFRM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AboutFrm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AboutFrm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AboutFrm

% Last Modified by GUIDE v2.5 15-JAN-2013 10:54:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AboutFrm_OpeningFcn, ...
                   'gui_OutputFcn',  @AboutFrm_OutputFcn, ...
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


% --- Executes just before AboutFrm is made visible.
function AboutFrm_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AboutFrm (see VARARGIN)

% Choose default command line output for AboutFrm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AboutFrm wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AboutFrm_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hText = uicontrol('Style','text','String','Text data present in images and video contain useful information for automatic annotation, indexing, and structuring of images. Extraction of this information involves detection, localization, tracking, extraction, enhancement, and recognition of the text from a given image. However, variations of text due to differences in size, style, orientation, and alignment, as well as low image contrast and complex background make the problem of automatic text extraction extremely challenging.');
newString = 'Add this line!';
set(hText,'String',strvchar(get(hText,'String'),newString));

% Get default command line output from handles structure
varargout{1} = handles.output;

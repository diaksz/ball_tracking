function varargout = EP17_gui(varargin)
% EP17_GUI MATLAB code for EP17_gui.fig
%      EP17_GUI, by itself, creates a new EP17_GUI or raises the existing
%      singleton*.
%
%      H = EP17_GUI returns the handle to a new EP17_GUI or the handle to
%      the existing singleton*.
%
%      EP17_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EP17_GUI.M with the given input arguments.
%
%      EP17_GUI('Property','Value',...) creates a new EP17_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EP17_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EP17_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EP17_gui

% Last Modified by GUIDE v2.5 02-Oct-2017 09:20:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EP17_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @EP17_gui_OutputFcn, ...
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


% --- Executes just before EP17_gui is made visible.
function EP17_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EP17_gui (see VARARGIN)

% Choose default command line output for EP17_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes EP17_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EP17_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in plot_ball.
function plot_ball_Callback(hObject, eventdata, handles)
% hObject    handle to plot_ball (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

plot_69;


% --- Executes on button press in close_plots.
function close_plots_Callback(hObject, eventdata, handles)
% hObject    handle to close_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close all;
set(EP17_gui,'HandleVisibility', 'on');


% --- Executes on button press in init.
function init_Callback(hObject, eventdata, handles)
% hObject    handle to init (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
WinOnTop(EP17_gui);


% --- Executes on button press in plotD.
function plotD_Callback(hObject, eventdata, handles)
% hObject    handle to plotD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_D


% --- Executes on button press in plotC.
function plotC_Callback(hObject, eventdata, handles)
% hObject    handle to plotC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_C


% --- Executes on button press in plot_cal.
function plot_cal_Callback(hObject, eventdata, handles)
% hObject    handle to plot_cal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_algo_zach

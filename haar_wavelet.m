function varargout = haar_wavelet(varargin)
% HAAR_WAVELET MATLAB code for haar_wavelet.fig
%      HAAR_WAVELET, by itself, creates a new HAAR_WAVELET or raises the existing
%      singleton*.
%
%      H = HAAR_WAVELET returns the handle to a new HAAR_WAVELET or the handle to
%      the existing singleton*.
%
%      HAAR_WAVELET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HAAR_WAVELET.M with the given input arguments.
%
%      HAAR_WAVELET('Property','Value',...) creates a new HAAR_WAVELET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before haar_wavelet_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to haar_wavelet_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help haar_wavelet

% Last Modified by GUIDE v2.5 07-Mar-2019 15:29:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @haar_wavelet_OpeningFcn, ...
                   'gui_OutputFcn',  @haar_wavelet_OutputFcn, ...
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


% --- Executes just before haar_wavelet is made visible.
function haar_wavelet_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to haar_wavelet (see VARARGIN)

% Choose default command line output for haar_wavelet
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes haar_wavelet wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = haar_wavelet_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select.
function select_Callback(hObject, eventdata, handles)
% hObject    handle to select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_name=uigetfile({'*.wav'},'Select an Audio File');
fileinfo = dir(file_name);
SIZE = fileinfo.bytes;
Size = SIZE/1024;
[x,Fs] = audioread(file_name);
xleng = length(x);
%t = linspace(0,(xleng-1)/Fs,length(x));
t=0:1/Fs:(xleng-1)/Fs;
set(handles.original_size,'string',Size);
axes(handles.axes1)
plot(t,x(:,1))
set(handles.axes1,'XMinorTick','on')
grid on
wname = 'haar';
level=3;
[C,L] = wavedec(x(:,1),level, wname);
[thr,sorh,keepapp] = ddencmp('cmp','wv',x(:,1));
%%%%%%%% to make it lossles/lossy just change the power 6 to 0 and vice versa %%%%%%%%%%
thr=thr*10^0;
[XC,CXC,LXC,PERF0,PERFL2] = wdencmp('gbl',C, L, wname,level,thr,sorh,keepapp);
C=CXC;
L=LXC;
axes(handles.axes3)
plot(t,C(1:xleng))
set(handles.axes3,'XMinorTick','on')
grid on
xd = waverec(C,L,wname);
audiowrite('output1.wav',xd,Fs,'BitsPerSample',8);
[y,fs] = audioread('output1.wav');
fileinfo2 = dir('output1.wav');
SIZE2 = fileinfo2.bytes;
Size2 = SIZE2/1024;
set(handles.compressed_size,'string',Size2)
t2=0:1/fs:(length(y)-1)/fs;
axes(handles.axes2)
plot(t2,y)
set(handles.axes2,'XMinorTick','on')
grid on
CompressionRatio = Size/Size2;
set(handles.compression_ratio,'string',CompressionRatio)

 


% --- Executes on button press in compress.
% function compress_Callback(hObject, eventdata, handles)
% % hObject    handle to compress (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)

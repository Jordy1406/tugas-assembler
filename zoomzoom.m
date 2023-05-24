function varargout = zoomzoom(varargin)
% ZOOMZOOM MATLAB code for zoomzoom.fig
%      ZOOMZOOM, by itself, creates a new ZOOMZOOM or raises the existing
%      singleton*.
%
%      H = ZOOMZOOM returns the handle to a new ZOOMZOOM or the handle to
%      the existing singleton*.
%
%      ZOOMZOOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ZOOMZOOM.M with the given input arguments.
%
%      ZOOMZOOM('Property','Value',...) creates a new ZOOMZOOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before zoomzoom_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to zoomzoom_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help zoomzoom

% Last Modified by GUIDE v2.5 24-May-2023 08:16:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @zoomzoom_OpeningFcn, ...
                   'gui_OutputFcn',  @zoomzoom_OutputFcn, ...
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


% --- Executes just before zoomzoom is made visible.
function zoomzoom_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to zoomzoom (see VARARGIN)

% Choose default command line output for zoomzoom
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes zoomzoom wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = zoomzoom_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;

[namafile, formatfile] = uigetfile({'*.png; *.bmp; *.jpg'}, 'memilih gambar');
if formatfile ==0
    return;
end
image = imread([formatfile, namafile]);
axes(handles.axes1); 
imshow(image), title('Citra Asli');

gambarnya = fullfile(formatfile, namafile);
set(handles.edit1,'String',gambarnya);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
%b = imread('image.png');
[m, n, colormap]=size(image);

if colormap==3
x=image(:,:,1);
y=image(:,:,2);
z=image(:,:,3);
end

p=1;
q=1; 
f = str2double(get(handles.edit2,'String'));

for i=1:m
    for t=1:f
        
        for j=1:n
            for t=1:f
                
                if colormap==3
                    c1(p,q) = x(i,j);
                    c2(p,q) = y(i,j);
                    c3(p,q) = z(i,j);
                else
                    c(p,q) = b(i,j);
                end
                q=q+1;
            end
        end
        q=1;
        p=p+1;
        
    end
end

if colormap==3
    c(:,:,1)=c1;
    c(:,:,2)=c2;
    c(:,:,3)=c3;
end

axes(handles.axes2); 
imshow(c), title('Citra Hasil Zoom')

size(image)
size(c)


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pilihan = questdlg('Apakah anda ingin menutup program?', ...
	'Menutup Program', ...
	'Ya','Tidak','Tidak');
% Handle response
switch pilihan
    case 'Ya'
        close;
    case 'Tidak'
        return;
end

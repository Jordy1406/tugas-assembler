function varargout = HSI(varargin)
% HSI MATLAB code for HSI.fig
%      HSI, by itself, creates a new HSI or raises the existing
%      singleton*.
%
%      H = HSI returns the handle to a new HSI or the handle to
%      the existing singleton*.
%
%      HSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HSI.M with the given input arguments.
%
%      HSI('Property','Value',...) creates a new HSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HSI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HSI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HSI

% Last Modified by GUIDE v2.5 24-May-2023 08:25:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HSI_OpeningFcn, ...
                   'gui_OutputFcn',  @HSI_OutputFcn, ...
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


% --- Executes just before HSI is made visible.
function HSI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HSI (see VARARGIN)

% Choose default command line output for HSI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HSI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HSI_OutputFcn(hObject, eventdata, handles) 
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
global hsi;

[namafile, formatfile] = uigetfile({'*.png; *.bmp; *.jpg'}, 'memilih gambar');
if formatfile ==0
    return;
end
image = imread([formatfile, namafile]);
handles.image = image;
guidata(hObject,handles);
axes(handles.axes1);
imshow(image);
gambarnya = fullfile(formatfile, namafile);
set(handles.edit1,'String',gambarnya);

cover_image = im2double(image);

r = cover_image(:,:,1);
g = cover_image(:,:,2);
b = cover_image(:,:,3);

numh = 0.5*((r-g).^2 + (r-b).*(g-b));
denh = sqrt((r-g).^2 + (r-b).*(g-b));
theta = acos(numh./(denh + eps));
H = theta;
H(b>g) = 2*pi - H(b>g);
H = H/(2*pi);
nums = min(min(r,g),b);
dens = r + g + b;
dens(dens == 0) = eps;
S = 1-3.* nums./dens;
H(S == 0) = 0;
I = (r + g + b)/3;

hsi = cat(3, H, S, I);

%figure, imshow(cover_image),title('cover');
%figure, imshow(hsi),title('hsi');
axes(handles.axes2);
imshow(hsi)

set(handles.pushbutton2, 'Enable', 'on');
set(handles.ketutrare, 'Visible', 'on');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global hsi;

[namafile, direktori] = uiputfile({'*.bmp'}, 'menyimpan hasil hsi');
if direktori==0
    return
end
imwrite(hsi, strcat(direktori, namafile));
msgbox('gambar berhasil disimpan','pemberitahuan');

 

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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
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

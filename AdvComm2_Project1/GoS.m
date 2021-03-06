function varargout = GoS(varargin)
% GOS MATLAB code for GoS.fig
%      GOS, by itself, creates a new GOS or raises the existing
%      singleton*.
%
%      H = GOS returns the handle to a new GOS or the handle to
%      the existing singleton*.
%
%      GOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GOS.M with the given input arguments.
%
%      GOS('Property','Value',...) creates a new GOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GoS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GoS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GoS

% Last Modified by GUIDE v2.5 26-Mar-2022 02:09:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GoS_OpeningFcn, ...
                   'gui_OutputFcn',  @GoS_OutputFcn, ...
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


% --- Executes just before GoS is made visible.
function GoS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GoS (see VARARGIN)

% Choose default command line output for GoS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
Edit_Box_off(handles)

% UIWAIT makes GoS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GoS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% This functions hides all instances in the gui until one option from the
% radio buttons is picked
function Edit_Box_off(handles)

set(handles.N_Trunks ,'enable', 'off')
set(handles.K_Users ,'enable', 'off')
set(handles.Lambda_CallRate ,'enable', 'off')
set(handles.H_HoldTime ,'enable', 'off')
set(handles.Calc_GoS ,'enable', 'off')
set(handles.Calc_Traffic ,'enable', 'off')
set(handles.G_GoS ,'enable', 'off')
set(handles.N_Trunks_2 ,'enable', 'off')
set(handles.Calc_Traffic_2 ,'enable', 'off')
set(handles.uitable_2_ErlangB ,'enable', 'off')
set(handles.popupmenu1 ,'enable', 'off')
set(handles.popupmenu2 ,'enable', 'off')
set(handles.N_Range ,'enable', 'off')
set(handles.Gos_Range ,'enable', 'off')
set(handles.K_Users_2 ,'enable', 'off')

% --- Executes on button press in pushbutton_Calc.
function pushbutton_Calc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%if on which radio

if (get(handles.radiobutton1,'value'))
 %First requirment is selected (Calculate Traffic and GoS)
    Trunks=str2double(get(handles.N_Trunks,'String'));
    if isnan(Trunks)  ||  Trunks<=0   %Check if input is invalid 
        set(handles.N_Trunks, 'String', 0);
        errordlg('Input must be a number','Error');
        return;
    end
    Hold_Time=str2double(get(handles.H_HoldTime,'String'));
    if isnan(Hold_Time) ||  Hold_Time<=0   %Check if input is invalid
        set(handles.H_HoldTime, 'String', 0);
        errordlg('Input must be a number','Error');
        return;
    end
    Call_Rate=str2double(get(handles.Lambda_CallRate,'String'));
    if isnan(Call_Rate) ||  Call_Rate<0   %Check if input is invalid
        set(handles.Lambda_CallRate, 'String', 0);
        errordlg('Input must be a number','Error');
        return;
    end
    N_Users=str2double(get(handles.K_Users,'String'));
    if isnan(N_Users) ||  N_Users<0   %Check if input is invalid
        set(handles.K_Users, 'String', 0);
        errordlg('Input must be a number','Error');
        return;
    end
    
    %According to the user selection from the popup menu on which type GoS
    %method, the traffic and GoS is calculated
    if get(handles.popupmenu1,'Value') == 1
        [Traffic,GoS_] = Erlang_B_Part1(Trunks,N_Users,Call_Rate,Hold_Time);
    elseif get(handles.popupmenu1,'Value') == 2
        [Traffic,GoS_] = Erlang_C_Part1(Trunks,N_Users,Call_Rate,Hold_Time); 
    else
        [Traffic,GoS_] = Erlang_Bino_Part1(Trunks,N_Users,Call_Rate,Hold_Time);
    end
    %Set the calculated valueS of Trffic and GoS in GUI
    set(handles.Calc_Traffic, 'String', Traffic);
    set(handles.Calc_GoS, 'String',GoS_ );
elseif (get(handles.radiobutton2,'value'))
 %Second requirment is selected (Calculate Traffic given GoS)   
    Trunks=str2double(get(handles.N_Trunks_2,'String'));
    if isnan(Trunks) ||  Trunks<=0   %Check if input is invalid
        set(handles.N_Trunks_2, 'String', 0);
        errordlg('Input must be a number','Error');
        return;
    end
    GoS_=str2double(get(handles.G_GoS,'String'));
    if isnan(GoS_) ||  GoS_<0   %Check if input is invalid
        set(handles.G_GoS, 'String', 0);
        errordlg('Input must be a number','Error');
        return;
    end
    
    %According to the user selection from the popup menu on which type GoS
    %method, the traffic is calculated 
    if get(handles.popupmenu2,'Value') == 1
        Traffic = Erlang_B_Part2(Trunks,GoS_);
    elseif get(handles.popupmenu2,'Value') == 2
        Traffic = Erlang_C_Part2(Trunks,GoS_); 
    else
        N_Users=str2double(get(handles.K_Users_2,'String'));
        if isnan(N_Users) ||  N_Users<0   %Check if input is invalid
            set(handles.K_Users_2, 'String', 0);
            errordlg('Input must be a number','Error');
            return;
        end
        
        Traffic = Erlang_Binomial_Part2(Trunks,GoS_,N_Users);
    end    
    %Set the calculated value of Trffic in GUI
    set(handles.Calc_Traffic_2, 'String', Traffic);

elseif (get(handles.radiobutton3,'value')) 
  %Third requirment is selected (Compare GoS of ErlangB and Bionomial)  
    
    coloumn_names=zeros(1,10);
    row_names=zeros(1,10);
    info=zeros(10,20);
    for i=1:10
      row_names(i)=i;
      for j=5:5:50
         if i==10
            coloumn_names(j/5)=j; 
         end
         k=(2*((j/5)-1))+1;
         %Get the GoS values corresponding to all different pairs of (N,K)
         [Traffic,GoS_] = Erlang_B_Part1(i,j,3,4);
          info(i,k)=GoS_; 
         [Traffic,GoS_] = Erlang_Bino_Part1(i,j,3,4);
          info(i,k+1)=GoS_;
      end  
    end
    
    %Insert the data into one table in figure to compare the GoS values of ErlangB and Bionomial
    % side by side ('ErlangB''Bionomial')
    fig = uifigure;
    tdata = table(info(:,1:2),info(:,3:4),info(:,5:6),info(:,7:8),info(:,9:10),info(:,11:12),info(:,13:14),info(:,15:16),info(:,17:18),info(:,19:20),'VariableNames',{'d','s','a','z','x','c','v','b','n','m'},'RowNames',{'d','s','a','z','x','c','v','b','n','m'});
    handles.uitable_2_ErlangB = uitable(fig,'Data',tdata);
    set(handles.uitable_2_ErlangB,'ColumnName',coloumn_names,'RowName',row_names,'BackgroundColor',[1 1 .9; .9 .95 1;1 .5 .5]);

elseif (get(handles.radiobutton4,'value'))
  %Fourth requirment is selected (Compare Traffic for all types of GoS)
    
    row_names=zeros(1,10);
    info=zeros(10,15);
    coloumn_names=[0.1,0.5,1,5,10];
    for i=1:10
      row_names(i)=i;
      for j=5:5:25
         k=(3*((j/5)-1))+1;
      %Get the Traffic values corresponding to all different pairs of
      %(N,GoS) for all types
         Traffic = Erlang_B_Part2(i,coloumn_names(j/5));
         info(i,k)=Traffic;       
         Traffic = Erlang_C_Part2(i,coloumn_names(j/5));
         info(i,k+1)=Traffic;
         Traffic = Erlang_Binomial_Part2(i,coloumn_names(j/5),15);
         info(i,k+2)=Traffic;
      end
    end
    
    %Insert the data into one table in figure to compare the Traffic values of 
    %the 3 types side by side ('ErlangB','ErlangC','Bionomial')
    fig = uifigure;
    tdata = table(info(:,1:3),info(:,4:6),info(:,7:9),info(:,10:12),info(:,13:15),'VariableNames',{'d','s','a','z','x'},'RowNames',{'d','s','a','z','x','c','v','b','n','m'});
    handles.uitable_2_ErlangB = uitable(fig,'Data',tdata);
    set(handles.uitable_2_ErlangB,'ColumnName',coloumn_names,'RowName',row_names,'BackgroundColor',[1 1 .9; .9 .95 1;1 .5 .5]);

elseif (get(handles.radiobutton5,'value'))
%Bonus requirment is selected (Compare Traffic for all types of GoS)
    N_EntRange=str2num(get(handles.N_Range, 'String'));  % Entered start and end of range of N trunks
    N_RowRange = N_EntRange(1) : 1 : N_EntRange(end);
    GOS_ColRange=str2num(get(handles.Gos_Range, 'String'));     %Entered vector of GoS 

    
    info_ErB=zeros(length(N_RowRange),length(GOS_ColRange));
    info_ErC=zeros(length(N_RowRange),length(GOS_ColRange));
    info_Bio=zeros(length(N_RowRange),length(GOS_ColRange));
    for i=1:length(N_RowRange)
      for j=1:1:length(GOS_ColRange)
     %Get the Traffic values corresponding to all different pairs of (N,GoS)
         info_ErB(i,j)=Erlang_B_Part2(N_RowRange(i),GOS_ColRange(j));
         info_ErC(i,j)=Erlang_C_Part2(N_RowRange(i),GOS_ColRange(j));
         info_Bio(i,j)=Erlang_Binomial_Part2(N_RowRange(i),GOS_ColRange(j),N_EntRange(end)+5);
      end   
    end
    
  %Insert the data into the 3 tables simulatenously  
set(handles.uitable_2_ErlangB  ,'Data',info_ErB,'ColumnName',GOS_ColRange,'RowName',N_RowRange,'BackgroundColor',[1 1 .9; .9 .95 1;1 .5 .5]);
set(handles.uitable_2_ErlangC  ,'Data',info_ErC,'ColumnName',GOS_ColRange,'RowName',N_RowRange,'BackgroundColor',[1 1 .9; .9 .95 1;1 .5 .5]);
set(handles.uitable_2_Bionomial,'Data',info_Bio,'ColumnName',GOS_ColRange,'RowName',N_RowRange,'BackgroundColor',[1 1 .9; .9 .95 1;1 .5 .5]);

end
% --- Executes on button press in pushbutton_Clear.
function pushbutton_Clear_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%clear all instances on the gui and re-disable all of them
set([handles.N_Trunks, handles.K_Users, handles.Lambda_CallRate,handles.H_HoldTime,handles.Calc_GoS,handles.Calc_Traffic], 'String','');
set([handles.G_GoS,handles.N_Trunks_2,handles.Calc_Traffic_2,handles.Gos_Range,handles.N_Range,handles.K_Users_2], 'String','');
Edit_Box_off(handles)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

if get(handles.popupmenu2,'Value') == 3
    set(handles.K_Users_2 ,'enable', 'on')
else
    set(handles.K_Users_2 ,'enable', 'off')
end


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
Edit_Box_off(handles)
set(handles.G_GoS ,'enable', 'on')
set(handles.N_Trunks_2 ,'enable', 'on')
set(handles.Calc_Traffic_2 ,'enable', 'on')
set(handles.popupmenu2 ,'enable', 'on')

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
Edit_Box_off(handles)
set(handles.N_Trunks ,'enable', 'on')
set(handles.K_Users ,'enable', 'on')
set(handles.Lambda_CallRate ,'enable', 'on')
set(handles.H_HoldTime ,'enable', 'on')
set(handles.Calc_GoS ,'enable', 'on')
set(handles.Calc_Traffic ,'enable', 'on')
set(handles.popupmenu1 ,'enable', 'on')


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

Edit_Box_off(handles)
set(handles.uitable_2_ErlangB ,'enable', 'on')

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
Edit_Box_off(handles)
set(handles.uitable_2_ErlangB ,'enable', 'on')

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5
Edit_Box_off(handles)
set(handles.N_Range ,'enable', 'on')
set(handles.Gos_Range ,'enable', 'on')
set(handles.uitable_2_ErlangB ,'enable', 'on')

function Calc_GoS_Callback(hObject, eventdata, handles)
% hObject    handle to Calc_GoS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Calc_GoS as text
%        str2double(get(hObject,'String')) returns contents of Calc_GoS as a double


% --- Executes during object creation, after setting all properties.
function Calc_GoS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Calc_GoS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function H_HoldTime_Callback(hObject, eventdata, handles)
% hObject    handle to H_HoldTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of H_HoldTime as text
%        str2double(get(hObject,'String')) returns contents of H_HoldTime as a double


% --- Executes during object creation, after setting all properties.
function H_HoldTime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to H_HoldTime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Lambda_CallRate_Callback(hObject, eventdata, handles)
% hObject    handle to Lambda_CallRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Lambda_CallRate as text
%        str2double(get(hObject,'String')) returns contents of Lambda_CallRate as a double


% --- Executes during object creation, after setting all properties.
function Lambda_CallRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lambda_CallRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K_Users_Callback(hObject, eventdata, handles)
% hObject    handle to K_Users (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K_Users as text
%        str2double(get(hObject,'String')) returns contents of K_Users as a double


% --- Executes during object creation, after setting all properties.
function K_Users_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K_Users (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function N_Trunks_Callback(hObject, eventdata, handles)
% hObject    handle to N_Trunks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_Trunks as text
%        str2double(get(hObject,'String')) returns contents of N_Trunks as a double


% --- Executes during object creation, after setting all properties.
function N_Trunks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_Trunks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function G_GoS_Callback(hObject, eventdata, handles)
% hObject    handle to G_GoS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of G_GoS as text
%        str2double(get(hObject,'String')) returns contents of G_GoS as a double


% --- Executes during object creation, after setting all properties.
function G_GoS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_GoS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function N_Trunks_2_Callback(hObject, eventdata, handles)
% hObject    handle to N_Trunks_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_Trunks_2 as text
%        str2double(get(hObject,'String')) returns contents of N_Trunks_2 as a double


% --- Executes during object creation, after setting all properties.
function N_Trunks_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_Trunks_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Calc_Traffic_2_Callback(hObject, eventdata, handles)
% hObject    handle to Calc_Traffic_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Calc_Traffic_2 as text
%        str2double(get(hObject,'String')) returns contents of Calc_Traffic_2 as a double


% --- Executes during object creation, after setting all properties.
function Calc_Traffic_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Calc_Traffic_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Calc_Traffic_Callback(hObject, eventdata, handles)
% hObject    handle to Calc_Traffic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Calc_Traffic as text
%        str2double(get(hObject,'String')) returns contents of Calc_Traffic as a double


% --- Executes during object creation, after setting all properties.
function Calc_Traffic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Calc_Traffic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable_2_ErlangB.
function uitable_2_ErlangB_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_2_ErlangB (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function N_Range_Callback(hObject, eventdata, handles)
% hObject    handle to N_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_Range as text
%        str2double(get(hObject,'String')) returns contents of N_Range as a double


% --- Executes during object creation, after setting all properties.
function N_Range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Gos_Range_Callback(hObject, eventdata, handles)
% hObject    handle to Gos_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Gos_Range as text
%        str2double(get(hObject,'String')) returns contents of Gos_Range as a double


% --- Executes during object creation, after setting all properties.
function Gos_Range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Gos_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function K_Users_2_Callback(hObject, eventdata, handles)
% hObject    handle to K_Users_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of K_Users_2 as text
%        str2double(get(hObject,'String')) returns contents of K_Users_2 as a double


% --- Executes during object creation, after setting all properties.
function K_Users_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to K_Users_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

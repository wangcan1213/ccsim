
clc;
[filename, pathname] = uigetfile({'*.dxf'},'Open File','Multiselect','off'); % choose file to open
    if filename==0
%         errordlg('no file selected','file error');
        return
    end
    
addpath(pathname); % add path to the matlab search path
fid=fopen(filename); % open file
dxfdata=textscan(fid,'%s'); % read dxf file as cell array of strings dxfdata
fclose(fid); % close file to accelerate further computation
dxfdata=dxfdata{1,1}; % reshape array
%%%%%%end%%%%%%%%  get file


%%%%%%begin%%%%%%%%  get dxf data
version=strcmp('$ACADVER',dxfdata(1:10)); % get version somewhere at the beginning of the .dxf header

    if sum (version)==0
        b=warndlg('corrupted file header/file version...problems may occur during processing ','file error');
        uiwait(b);clear b;
        version=('unknown');
    else         
        version=dxfdata{(find(version==1)+2)}; % +2...acadversion (-> autodesk(r) dxf reference)        
            switch (version)
                case('AC1014')
                    version=('Acad R 14');
                case('AC1015')
                    version=('Acad R 2000');
                case('AC1018')
                    version=('Acad R 2004');
                case('AC1021')
                    version=('Acad R 2007');
                otherwise
                    version=('unknown');
                    b=warndlg('corrupted file header/file version...problems may occur during processing ','file error');
                    uiwait(b);clear b;
            end
    end

dxfinfo=struct([]); % file info
dxfinfo(1).pathname=pathname;
dxfinfo(1).filename=filename;
dxfinfo(1).dxfversion=version;
clear filename pathname version

beg=strcmp('ENTITIES',dxfdata); % cut out dxf entity data block to increase speed and reduce required memory  
    if sum(beg)==0
        b=errordlg('corrupted dxf file, processing stopped ','file error');
        uiwait(b);clear;return
    end
beg=find(beg==1);               
endsec=strcmp('ENDSEC',dxfdata);
endsec=find(endsec==1);
endsec=endsec(endsec>beg);
endsec=endsec(1);
dxfdata=dxfdata(beg:endsec); 
clear beg endsec;

tic;
%%%%%%begin%%%%%%%%  get indices + total... 
% of line no's of all treated entities, total=all indices in ascend order+no of last line of dxf block  
points=strcmp('AcDbPoint',dxfdata); 
points=find(points==1);
    if isempty (points);
        clear points;
    else
        if exist ('total','var')==0
            total=(points);
        else
            total=[total;points];
        end         
    end
    
lines=strcmp('AcDbLine',dxfdata);
lines=find(lines==1);
    if isempty (lines);
        clear lines;
    else
        if exist ('total','var')==0
            total=(lines);
        else
            total=[total;lines];
        end         
    end
    
circles=strcmp('AcDbCircle',dxfdata);
circles=find(circles==1);
    if isempty (circles)
        clear circles;
    else
        if exist ('total','var')==0
            total=(circles);
        else
            total=[total;circles];
        end        
    end
    
lwpolys=strcmp('AcDbPolyline',dxfdata);
lwpolys=find(lwpolys==1);
    if isempty (lwpolys)
        clear lwpolys;
    else
        if exist ('total','var')==0
            total=(lwpolys);
        else
            total=[total;lwpolys];
        end
    end   
    
threedpolynum=strcmp('AcDb3dPolyline',dxfdata);
threedpolynum=find(threedpolynum==1);
    if isempty (threedpolynum)
        clear threedpolynum;
    else
        if exist ('total','var')==0
            total=(threedpolynum);
        else
            total=[total;threedpolynum];
        end          
    end 
    
threedfaces=strcmp('AcDbFace',dxfdata);
threedfaces=find(threedfaces==1);
    if isempty (threedfaces)
        clear threedfaces;
    else
        if exist ('total','var')==0
            total=(threedfaces);
        else
            total=[total;threedfaces];
        end         
    end    
    
total=sort(total);
total=[total;length(dxfdata)]; % add no of last line in dxfdata
%%%%%%%end%%%%%%%  get indices + total


%%%%%%begin%%%%%% data extraction
%%%%%%%%%%%%%%%%%%% case points %%%%%%%%%%%%%%%%%%%%%%%%%% 
if exist('points','var')==1
    
    pointlayers=cell(length(points),1);             %#ok<NASGU> % get entity layernames
    pointlayers=dxfdata(points-2);  
    
    points(:,2:4)=zeros;                            % preallocate
    points(:,2)=str2double(dxfdata(points(:,1)+2)); % x
    points(:,3)=str2double(dxfdata(points(:,1)+4)); % y
    points(:,4)=str2double(dxfdata(points(:,1)+6)); % z
    points(:,1)=1:length(points);                   % no's.
 
end
%%%%%%%%%%%%%%%%%%% end case points %%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%% case lines %%%%%%%%%%%%%%%%%%%%%%%%%%
if exist ('lines','var')==1
    
    lineslayers=cell(length(lines),1);                      %#ok<NASGU> % get entity layernames
    lineslayers=dxfdata(lines-2); 

        for a=1:length(lines)
            if str2double(dxfdata(lines(a)+1))==39          % 39 .. group code for "thickness" (optional)
                lines(a)=lines(a)+2;
            end    
        end
    a=1:length(lines);
    lines(max(a)+1:2*max(a),2:5)=zeros;                     % preallocate    
    lines(a*2,2)=lines(a);                                  % rearrange matrix lines
    lines(a*2-1,2)=lines(a);
    lines(2*a,1)=1:max(a);
    lines(1:2:2*(max(a)),1)=1:max(a);
    lines(2*a-1,3)=str2double(dxfdata(lines((2*a-1),2)+2)); % odd line no. x
    lines(2*a-1,4)=str2double(dxfdata(lines((2*a-1),2)+4)); % odd line no. y
    lines(2*a-1,5)=str2double(dxfdata(lines((2*a-1),2)+6)); % odd line no. y    
    lines(2*a,3)=str2double(dxfdata(lines((2*a),2)+8));     % even line no. x
    lines(2*a,4)=str2double(dxfdata(lines((2*a),2)+10));    % even line no. y
    lines(2*a,5)=str2double(dxfdata(lines((2*a),2)+12));    % even line no. z
    lines(:,2)=[];                                          % reshape lines
end
%%%%%%%%%%%%%%%%%%% end case lines %%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%%%%%%%%%%%%%%% case circles %%%%%%%%%%%%%%%%%%%%%%%%%%
if exist ('circles','var')==1
    
    circleslayers=cell(length(circles),1);              %#ok<NASGU> % get entity layernames
    circleslayers=dxfdata(circles-2); 

        for a=1:length(circles)
            if str2double(dxfdata(circles(a)+1))==39
                circles(a)=circles(a)+2;
            end
        end
    circles(:,2:5)=zeros;
    circles(:,2)=str2double(dxfdata(circles(:,1)+2));   % center x
    circles(:,3)=str2double(dxfdata(circles(:,1)+4));   % center y
    circles(:,4)=str2double(dxfdata(circles(:,1)+6));   % center z
    circles(:,5)=str2double(dxfdata(circles(:,1)+8));   % radius
    circles(:,1)=1:length(circles);                     % no.
end     
%%%%%%%%%%%%%%%%%%% end case circles %%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%%%%%%%%%%%%%%% case lwpolylines %%%%%%%%%%%%%%%%%%%%%%%%%%
if exist ('lwpolys','var')==1  
    
    lwpolylayers=cell(length(lwpolys),1);                %#ok<NASGU> % get entity layernames
    lwpolylayers=dxfdata(lwpolys-2); 
    lwvertices=str2double(dxfdata(lwpolys+2));
    lwclosed=str2double(dxfdata(lwpolys+4));
    lwclosed=(lwclosed==1); % get only 1's (closed polylines), other possibilities are '0' or '128'
    lwpolylines=zeros(sum(lwvertices)+sum(lwclosed),4); % preallocate output var lwpolylines     
           
    for a=1:length(lwpolys)
        lwtemp=lwvertices(a)+lwclosed(a); % create temp matrix in loop
        lwtemp=repmat(a,lwtemp,4); 
        lwtemp(1,2)=min(strmatch('10',dxfdata((lwpolys(a)+3):(lwpolys(a)+11)),'exact'))+3+lwpolys(a);
        lwtemp(2:lwvertices(a),2)=lwtemp(1,2)+4:4:lwtemp(1,2)+((lwvertices(a)-2)*4)+4; 
        lwtemp(:,3)=lwtemp(:,2)+2;                             

            if lwclosed(a)==1;
                lwtemp(lwvertices(a)+1,2:3)=lwtemp(1,2:3); % if closed -> last coords = first coords
            end

        lwtemp(:,2:3)=str2double(dxfdata(lwtemp(:,2:3))); % get dxfdata
        lw_38=strmatch('38',dxfdata(lwpolys(a)+3:lwpolys(a)+7),'exact'); % get z data if exist            

            if isempty(lw_38)
                lwtemp(:,4)=0;
            else
                lwtemp(:,4)=str2double(dxfdata(lw_38+lwpolys(a)+3)); % correct line no. and get dxfdata
            end                                                
            
            if a==1 %  set marker variable for indexing tempvar lwtemp --> output var lwpolylines
                lwtemp_beg=1;
                lwtemp_end=lwvertices(a)+lwclosed(a);
            else
                lwtemp_beg=lwtemp_end+1;
                lwtemp_end=lwtemp_beg+lwvertices(a)+lwclosed(a)-1;
            end

            lwpolylines(lwtemp_beg:lwtemp_end,:)=lwtemp; % write tempvar --> output var
    end
end
clear lw_38 lwtemp_beg lwtemp_end lwclosed lwvertices lwtemp lwpolys  % delete garbage
%%%%%%%%%%%%%%%%%%% end case lwpolylines %%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%%%%%%%%%%%%%%% case 3d polylines %%%%%%%%%%%%%%%%%%%%%%%%%%
if exist ('threedpolynum','var')==1 
    
    threedpolylayers=cell(length(threedpolynum),1);                      %#ok<NASGU> % get entity layernames
    threedpolylayers=dxfdata(threedpolynum-2);   
    
    for a=1:length(threedpolynum)                                                                               
            threedvertices=strcmp('AcDb3dPolylineVertex',dxfdata(threedpolynum(a):min(total(total>threedpolynum(a)))));                                 
            threedvertices=find(threedvertices==1)+threedpolynum(a)-1;  % find + correct index no's                       
            threedvertices(:,2)=threedvertices(:,1);                    % create vertices matrix (rows 2:4)...
            threedvertices=repmat(threedvertices,2);
            threedvertices(:,1)=a;                                      % .. with 3dpoly id (row 1)            
            threedclosed=strcmp('70',dxfdata(threedpolynum(a):threedpolynum(a)+15));
                if sum(threedclosed)==1               
                    threedclosed=find(threedclosed==1);
                    threedclosed=dec2bin(str2double(dxfdata(threedpolynum(a)+threedclosed)),8);                    
                        if threedclosed(8)=='1'                         
                            threedvertices(end+1,:)=threedvertices(1,:); %#ok<AGROW> % if closed copy coords of first vertex to last position                  
                        end 
                end             
                if a==1 % build output variable threedpolys (id & indices)
                    threedpolys=threedvertices;
                else
                    threedpolys=[threedpolys;threedvertices]; %#ok<AGROW>
                end           
    end 
    threedpolys(:,2)=threedpolys(:,2)+2;                            % indices for x- coords
    threedpolys(:,3)=threedpolys(:,3)+4;                            % indices for y- coords
    threedpolys(:,4)=threedpolys(:,4)+6;                            % indices for z- coords
    threedpolys(:,2:4)=str2double(dxfdata(threedpolys(:,2:4)));     % get data        
end 
clear threedvertices threedclosed threedpolynum 
%%%%%%%%%%%%%%%%% end case 3d polylines %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%% case 3d faces %%%%%%%%%%%%%%%%%%%%%%%%%%
if exist('threedfaces','var')==1
    
    threedfaceslayers=cell(length(threedfaces),1); %#ok<NASGU> % get entity layernames
    threedfaceslayers=dxfdata(threedfaces-2); 
  
    a=1:length(threedfaces);    
    threedfaces=repmat(threedfaces,4,5);
    threedfaces(:,2:5)=zeros;
    threedfaces=sort(threedfaces,'ascend');
    b=1:4:length(threedfaces);    
    threedfaces(b,3)=str2double(dxfdata(threedfaces(b)+2));     % x1
    threedfaces(b,4)=str2double(dxfdata(threedfaces(b)+4));     % y1
    threedfaces(b,5)=str2double(dxfdata(threedfaces(b)+6));     % z1            
    threedfaces(b+1,3)=str2double(dxfdata(threedfaces(b)+8));   % x2
    threedfaces(b+1,4)=str2double(dxfdata(threedfaces(b)+10));  % y2
    threedfaces(b+1,5)=str2double(dxfdata(threedfaces(b)+12));  % z2             
    threedfaces(b+2,3)=str2double(dxfdata(threedfaces(b)+14));  % x3
    threedfaces(b+2,4)=str2double(dxfdata(threedfaces(b)+16));  % y3
    threedfaces(b+2,5)=str2double(dxfdata(threedfaces(b)+18));  % z3            
    threedfaces(b+3,3)=str2double(dxfdata(threedfaces(b)+20));  % x4
    threedfaces(b+3,4)=str2double(dxfdata(threedfaces(b)+22));  % y4
    threedfaces(b+3,5)=str2double(dxfdata(threedfaces(b)+24));  % z4 
    a=a';
    a=repmat(a,4,1); % 1 2 3 4 1 2 3 4 1 2 3 4 1 2 3 4
    a=sort(a,'ascend'); % 1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4
    threedfaces(:,2)=a;
    threedfaces(:,1)=[];
    threedfaces=unique(threedfaces,'rows'); % delete double coords, caution: changes order of content for each id
end
%%%%%%%%%%%%%%%%%% end case 3d faces %%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%end%%%%%% data extraction

%%%%%%end%%%%%%  get dxf data

clear a b total fid dxfdata % delete garbage

toc;
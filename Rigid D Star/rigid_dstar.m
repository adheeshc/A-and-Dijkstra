clc
clear all
close all

%% GUI

xmax=250;
ymax=150;
MAP=zeros(xmax,ymax);

surf(MAP')
colormap(gray)
view(2)
MAP(149:174,14:53)=1;
MAP(173,15:52)=1;
MAP(150:173,15)=1;
MAP(150:173,52)=1;
%% Take User Input and check Position
count = 1;
count2 = 0;

while(count==1)
start_node=input('enter start point as a 1x2 matrix: ');
if start_node==[0,0]
    start_node=[start_node(1)+1,start_node(2)+1];
end
target_node=input('enter end point as a 1x2 matrix: ');
if target_node==[250,150]
    target_node=[target_node(1)-1,target_node(2)-1];
end
resolution=input('enter resolution(default=1): ');
radius=input('enter diameter(default=10): ');
clearance=input('enter clearance(default=0): ');
default={'0 0','250 150','1'};
% resolution=1;
% start_node=[200,10];
% target_node=[150,140];
% radius=10;
% clearance=0;
mink=(radius/2);
xstart=(floor(start_node(1)/resolution))*resolution;
ystart=(floor(start_node(2)/resolution))*resolution;
drawnow
hold on
r1=rectangle('Position',[xstart ystart resolution resolution]);
r1.FaceColor='green';
r1.EdgeColor='green';
r1.LineWidth=3;
xtarget=(floor(target_node(1)/resolution))*resolution;
ytarget=(floor(target_node(2)/resolution))*resolution;
r2=rectangle('Position',[xtarget ytarget resolution resolution]);
r2.FaceColor='red';
r2.EdgeColor='red';
r2.LineWidth=3;
    if (~(checkposition(xstart,ystart,resolution,mink,clearance)))
        disp('Inavalid Start Point Input');
        count=0;
    elseif(~(checkposition(xtarget,ytarget,resolution,mink,clearance)))
        disp('Inavalid Target Point Input');
        count=0;
    else
        count=0;
        count2=1;
    end
end
%% plot circle
xcentre=190;
ycentre=130;
mink1=mink+15;
t=0:0.01:2*pi;
x=15*cos(t)+xcentre;
y=15*sin(t)+ycentre;
x2=mink1*cos(t)+xcentre;
y2=mink1*sin(t)+ycentre;
drawnow
fill(x2,y2,'b')
fill(x,y,'r')
[xx,yy] = meshgrid((1:size(MAP,2))-ycentre,(1:size(MAP,1))-xcentre);
MAP(sqrt(xx.^2 + yy.^2) <= mink1+clearance) = 1;
%% plot ellipse
xcentre2=140;
ycentre2=120;
a=30;
b=12;
mink2=mink+a;
mink3=mink+b;
x3=a*cos(t)+xcentre2;
y3=b*sin(t)+ycentre2;
x4=mink2*cos(t)+xcentre2;
y4=mink3*sin(t)+ycentre2;
drawnow
fill(x4,y4,'b')
fill(x3,y3,'r')
[xx,yy] = meshgrid((1:size(MAP,2))-ycentre2,(1:size(MAP,1))-xcentre2);
MAP(sqrt((xx/(b+mink2+clearance)).^2 + (yy/(a+mink3+clearance)).^2) <= 1) = 1;
%% plot rectangle
xp1=[50,50,100,100];
yp1=[75,120,120,75];
xp2=[50-mink-clearance,50-mink-clearance,100+mink+clearance,100+mink+clearance];
yp2=[75-mink-clearance,120+mink+clearance,120+mink+clearance,75-mink-clearance];
drawnow
fill(xp2,yp2,'b')
fill(xp1,yp1,'r')
MAP(50-mink-clearance:100+mink+clearance,75-mink-clearance:120+mink+clearance)=1;

%% plot polygon
xp3=[125,163,170,193,173,150];
yp3=[56,52,90,52,15,15];
xp4=[115.466,158.921,167.466,198.76,175.981,147.193];
yp4=[62.031,57.457,103.843,52.14,10,10];
drawnow
drawnow
fill(xp4,yp4,'b')
fill(xp3,yp3,'r')
tic
[xx1,yy1] = fillline([125,56],[163,52],100);
diagonal=round([linspace(125,56,60); linspace(150,15,60)]);
MAP(165:183,57:85)=1;
MAP(125:160,52:56)=1;
MAP(170:172,52:57)=1;
MAP(172:175,57:61)=1;
MAP(175:178,61:65)=1;
MAP(178:181,65:70)=1;
MAP(181:183,70:74)=1;
MAP(183:185,74:78)=1;
MAP(185:188,78:82)=1;
MAP(188:191,82:86)=1;
MAP(191:193,86:90)=1;
MAP(127:131,48:54)=1;
MAP(131:136,40:48)=1;
MAP(136:140,33:40)=1;
MAP(140:144,27:33)=1;
MAP(144:147,20:27)=1;
MAP(147:150,15:20)=1;
MAP(173:174,15:20)=1;
MAP(174:176,20:25)=1;
MAP(176:179,25:30)=1;
MAP(179:181,30:35)=1;
MAP(181:184,35:40)=1;
MAP(184:187,40:44)=1;
MAP(187:190,44:48)=1;
MAP(190:193,48:52)=1;
%% Creating Variables
tic
if count2==1
%Heuristic Map of all nodes
for x = 1:size(MAP,1)
    for y = 1:size(MAP,2)
        if(MAP(x,y)~=inf)
            G(x,y) = inf;
        end
    end
end

G(start_node(1),start_node(2)) = 0;
F(start_node(1),start_node(2)) = 0;
close_list = [];
open_list = [start_node G(start_node(1),start_node(2)) F(start_node(1),start_node(2)) 0]; 

%% Implementation

count4 = false;
while(~isempty(open_list))
    
    pause(0.001)
    
    %find node from open list with smallest F value
    [~,pos] = min(open_list(:,4));
    
    %set current node
    current_node = open_list(pos,:);
    r1=rectangle('Position',[xstart ystart resolution resolution]);
    r1.FaceColor='green';
    r1.EdgeColor='green';
    r1.LineWidth=3;
    rectangle('Position',[current_node(1),current_node(2),resolution,resolution],'FaceColor','y','EdgeColor','black')
    
    %if goal is reached, break the loop
    if(current_node(1:2)==target_node)
        close_list = [close_list;current_node];
        count4 = true;
        break;
    end
    
    %pop current node
    open_list(pos,:) = [];
    close_list = [close_list;current_node];
    
    %plot current node
    for x = current_node(1)-1:current_node(1)+1
        for y = current_node(2)-1:current_node(2)+1
            
            %check boundary
            if (x<1||x>xmax||y<1||y>ymax)
                continue
            end
            
            %check obstacle
            if (MAP(x,y)==1)
                continue
            end
            
            %check current node
            if (x==current_node(1)&&y==current_node(2))
                continue
            end
            
            %check if repeat in close_list
            skip = 0;
            for j = 1:size(close_list,1)
                if(x == close_list(j,1) && y==close_list(j,2))
                    skip = 1;
                    break;
                end
            end
            if(skip == 1)
                continue
            end
            
            A = [];
            %Check if repeat in open_list
            if(~isempty(open_list))
                for j = 1:size(open_list,1)
                    if(x == open_list(j,1) && y==open_list(j,2))
                        A = j;
                        break;
                    end
                end
            end
            
            
            newG = G(current_node(1),current_node(2)) + round(norm([current_node(1)-x,current_node(2)-y]),1);
            
            if(isempty(A))
                G(x,y) = newG;
                newF = G(x,y);
                newNode = [x y G(x,y) newF size(close_list,1)];
                open_list = [open_list; newNode];
                
                continue
            end
            
            if (newG >= G(x,y))
                continue
            end
            
            G(x,y) = newG;
            newF = newG;
            open_list(A,3:5) = [newG newF size(close_list,1)];
        end
    end
end

%% Path Plotting

if (count4)
    %Path plotting
    j = size(close_list,1);
    path = [];
    while(j > 0)
        x = close_list(j,1);
        y = close_list(j,2);
        j = close_list(j,5);
        path = [x,y;path];
    end
    
    for j = 1:size(path,1)
        plot(path(j,1),path(j,2),'x','color','b')
        pause(0.01)
    end
    r1=rectangle('Position',[xstart ystart resolution resolution]);
    r1.FaceColor='green';
    r1.EdgeColor='green';
    r1.LineWidth=3;

    r2=rectangle('Position',[xtarget ytarget resolution resolution]);
    r2.FaceColor='red';
    r2.EdgeColor='red';
    r2.LineWidth=3;
end
end
toc
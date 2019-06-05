clc
clear all
close all

%% GUI

xmax=251;
ymax=151;
MAP=zeros(xmax,ymax);


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
default={'0 0','250 150','1'};
%resolution=1;
%start_node=[200,10];
%target_node=[150,140];
xstart=(floor(start_node(1)/resolution))*resolution;
ystart=(floor(start_node(2)/resolution))*resolution;
surf(MAP')
colormap(gray)
view(2)
MAP(149:174,14:53)=inf;
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
    if (~(checkposition(xstart,ystart,resolution)))
        disp('Invalid Start Point Input');
        count=0;
    elseif(~(checkposition(xtarget,ytarget,resolution)))
        disp('Invalid Target Point Input');
        count=0;
    else
        count=0;
        count2=1;
    end
end
%% plot circle
xcentre=190;
ycentre=130;
t=0:0.01:2*pi;
x=15*cos(t)+xcentre;
y=15*sin(t)+ycentre;
drawnow
plot(x,y)
fill(x,y,'r')
[xx,yy] = meshgrid((1:size(MAP,2))-ycentre,(1:size(MAP,1))-xcentre);
MAP(sqrt(xx.^2 + yy.^2) <= 15) = inf;
%% plot ellipse
xcentre2=140;
ycentre2=120;
a=30;
b=12;
x2=a*cos(t)+xcentre2;
y2=b*sin(t)+ycentre2;
drawnow
plot(x2,y2)
fill(x2,y2,'k')
[xx,yy] = meshgrid((1:size(MAP,2))-ycentre2,(1:size(MAP,1))-xcentre2);
MAP(sqrt((xx/b).^2 + (yy/a).^2) <= 1) = inf;
%% plot rectangle
xp1=[50,50,100,100];
yp1=[75,120,120,75];
drawnow
plot(xp1,yp1)
fill(xp1,yp1,'b')
MAP(50:100,75:120)=inf;
%% plot polygon
xp2=[125,163,170,193,173,150];
yp2=[56,52,90,52,15,15];
drawnow
plot(xp2,yp2)
fill(xp2,yp2,'g')
[xx1,yy1] = fillline([125,56],[163,52],100);
diagonal=round([linspace(125,56,60); linspace(150,15,60)]);
[lp1,lp2,lp3,lp4,lp5,lp6] = polygon(x,y);
MAP(165:183,57:85)=inf;
MAP(125:160,52:56)=inf;
MAP(170:172,52:57)=inf;
MAP(172:175,57:61)=inf;
MAP(175:178,61:65)=inf;
MAP(178:181,65:70)=inf;
MAP(181:183,70:74)=inf;
MAP(183:185,74:78)=inf;
MAP(185:188,78:82)=inf;
MAP(188:191,82:86)=inf;
MAP(191:193,86:90)=inf;
MAP(127:131,48:54)=inf;
MAP(131:136,40:48)=inf;
MAP(136:140,33:40)=inf;
MAP(140:144,27:33)=inf;
MAP(144:147,20:27)=inf;
MAP(147:150,15:20)=inf;
MAP(173:174,15:20)=inf;
MAP(174:176,20:25)=inf;
MAP(176:179,25:30)=inf;
MAP(179:181,30:35)=inf;
MAP(181:184,35:40)=inf;
MAP(184:187,40:44)=inf;
MAP(187:190,44:48)=inf;
MAP(190:193,48:52)=inf;
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
%% Creating Variables
tic
if count2==1
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
            if (isinf(MAP(x,y)))
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
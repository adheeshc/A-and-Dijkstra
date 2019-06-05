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
target_node=input('enter end point as a 1x2 matrix: ');
resolution=input('enter resolution(default=1): ');
default={'0 0','250 150','1'};
%resolution=1;
%start_node=[0,0];
%target_node=[250,150];
xstart=(floor(start_node(1)/resolution))*resolution;
ystart=(floor(start_node(2)/resolution))*resolution;
surf(MAP')
colormap(gray)
view(2)
drawnow
hold on
r1=rectangle('Position',[xstart ystart resolution resolution]);
r1.FaceColor='green';
r1.EdgeColor='green';
r1.LineWidth=1;
xtarget=(floor(target_node(1)/resolution))*resolution;
ytarget=(floor(target_node(2)/resolution))*resolution;
r2=rectangle('Position',[xtarget ytarget resolution resolution]);
r2.FaceColor='red';
r2.EdgeColor='red';
r2.LineWidth=1;
    if (~(checkposition(xstart,ystart,resolution)))
        disp('Inavalid Start Point Input');
        count=0;
    elseif(~(checkposition(xtarget,ytarget,resolution)))
        disp('Inavalid Target Point Input');
        count=0;
    else
        count=0;
        count2=1;
    end
end

tic
%% plot circle
xcentre=190;
ycentre=130;
t=0:0.01:2*pi;
x=15*cos(t)+xcentre;
y=15*sin(t)+ycentre;
drawnow
plot(x,y)
fill(x,y,'r')

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

%% plot rectangle
xp1=[50,50,100,100];
yp1=[75,120,120,75];
drawnow
plot(xp1,yp1)
fill(xp1,yp1,'b')

%% plot polygon
xp2=[125,163,170,193,173,150];
yp2=[56,52,90,52,15,15];
drawnow
plot(xp2,yp2)
fill(xp2,yp2,'g')

%% Points
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

open_list= [xstart,ystart]; 
close_list= [0 0];
explored_nodes=[xstart,ystart];  %all explored nodes
parent_node(:,:,1)=[1 1]; %  parentnode 

open_count=2; % count for open_list
node_count=2; % count for all explored nodes 
parent_count=1;% Initialing parent node count

cost(1)= 0; % c2c of all nodes in open_list
total_c2c=0; % C2c of all possible nodes
cost2come(1)=0; % C2c of all nodes in open_list

%% Implementation
if count2==1
while(~isempty(open_list)) 
    
[~,pos]=min(cost); 
x= open_list(pos,1); 
y=open_list(pos,2); 
[~,parent_count]=ismember([x y],explored_nodes,'rows');
[~,c2ccount]=ismember([x y],open_list,'rows');
if (x==xtarget && y==ytarget)
    break
end

%% Move Right
xy=[x+resolution,y];
count3=1;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Move Up
xy=[x,y+resolution];
count3=1;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Move Left
xy=[x-resolution,y];
count3=1;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Move Down
xy=[x,y-resolution];
count3=1;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Move Up Right
xy=[x+resolution,y+resolution];
count3=0;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Move Up Left
xy=[x-resolution,y+resolution];
count3=0;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Move Down Left
xy=[x-resolution,y-resolution];
count3=0;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Move Down Right
xy=[x+resolution,y-resolution];
count3=0;
[explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart);

%% Popping out Current Node out of open list
open_list(pos,:)=[];
cost2come(pos)=[];
cost(pos)=[];
open_count=open_count-1;
%% Adding the popped out node in close list
close_list= [x y;close_list];

end
end
%% Back Tracking the parent node to find the path
if count2==1
finish=0;
[~, node_countfinal]= ismember([xtarget,ytarget],explored_nodes,'rows');
node_count=node_countfinal;
position_final=explored_nodes(node_count,:);
hold on
while(finish==0)
    parent_count= parent_node(1,2,parent_count);
    position_final= explored_nodes(parent_count,:);
    if(position_final(1)==xstart && position_final(2)==ystart)
        finish=1;
    end
    rectangle('Position',[position_final(1) position_final(2) resolution resolution ], 'FaceColor','green','EdgeColor','g','LineWidth',2); %% Plotting explored Nodes.
    pause(0.002);

end
end
toc
function [overlap]= checkposition(x,y,res,mink,clearance)
%for circle
z1=((x-190)^2+(y-130)^2-(15+res+mink+clearance)^2);

%for oval
z2= (((x-140)/(30-res+mink+clearance))^2 + ((y-120)/(12-res+mink+clearance))^2)-1;

%for polygon
% l1=(y-56)-(56-15)/(125-150)*(x-125);    %(125,56) and (150,15)
% l2=(y-15);                              %(150,15) and (173,15)
% l3=-((y-15)-(15-52)/(173-193)*(x-173)); %(173,15) and (193,52)
% l4=(y-52)-(52-90)/(193-170)*(x-193);    %(193,52) and (170,90)
% l5=-((y-90)-(90-52)/(170-163)*(x-170)); %(170,90) and (163,52)
% l6=(y-52)-(52-56)/(163-125)*(x-163);    %(163,52) and (125,56)

m1=(-41/25); c1=261;n1=sqrt(1+m1^2);    %(125,56) and (150,15)
m2=0;c2=15;n2=sqrt(1+m2^2);             %(150,15) and (173,15)
m3=(37/20);c3=-6101/20;n3=sqrt(1+m3^2); %(173,15) and (193,52)
m4=(-38/23);c4=8530/23;n4=sqrt(1+m4^2); %(193,52) and (170,90)
m5=(38/7);c5=-5830/7;n5=sqrt(1+m5^2);   %(170,90) and (163,52)
m6=(-2/19);c6=1314/19;n6=sqrt(1+m6^2);  %(163,52) and (125,56)
d=mink+clearance;

c1_new=-(d*n1-c1);
c2_new=-(d*n2-c2);
c3_new=-(d*n3-c3);
c4_new=d*n4+c4;
c5_new=d*n5+c5;
c6_new=d*n6+c6;
 
l1=y-m1*x-c1_new
l2=y-m2*x-c2_new
l3=y-m3*x-c3_new
l4=y-m4*x-c4_new
l5=y-m5*x-c5_new
l6=y-m6*x-c6_new

%CHECK
if (x>=0 && x<=250 && y>=0 && y<=150)
    %for rectangle
    if (x>=(50-res-mink-clearance) && x<=(100+res+mink+clearance) && ...
            y>=(75-res-mink-clearance) && y<=120+res+mink+clearance) 
        overlap= false;
        
    %for polygon
    elseif (l1>=0 && l2>=0 && l3>=0 && l4<=0 && (l5>=0 || l6<=0))  
        overlap= false;

    %for circle
    elseif (z1<=0) 
        overlap= false;
    
    %for oval
    elseif (z2<=0)
        overlap= false;
        
    else
        overlap= true;
    end
else
    overlap= false;
    
end
end

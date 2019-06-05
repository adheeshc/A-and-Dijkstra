function [overlap]= checkposition(x,y,res)
%for circle
z1=((x-190)^2+(y-130)^2-(15+res)^2);

%for oval
z2= (((x-140)/(30-res))^2 + ((y-120)/(12-res))^2)-1;

%for polygon
l1=(y-56)-(56-15)/(125-150)*(x-125);    %(125,56) and (150,15)
l2=(y-15);                              %(150,15) and (173,15)
l3=-((y-15)-(15-52)/(173-193)*(x-173)); %(173,15) and (193,52)
l4=(y-52)-(52-90)/(193-170)*(x-193);    %(193,52) and (170,90)
l5=-((y-90)-(90-52)/(170-163)*(x-170)); %(170,90) and (163,52)
l6=(y-52)-(52-56)/(163-125)*(x-163);    %(163,52) and (125,56)

%CHECK
if (x>=0 && x<=250 && y>=0 && y<=150)
    %for rectangle
    if (x>=50-res && x<=100+res && y>=75-res && y<=120+res) 
        overlap= false;
    %for polygon
    elseif (l1>=0 && l2>=0 && l3<=0 && l4<=0 && (l5>=0 || l6<=0))
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

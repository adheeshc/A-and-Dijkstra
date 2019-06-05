function [lp1,lp2,lp3,lp4,lp5,lp6]= polygon(x,y)

m1=(-41/25); c1=261;n1=sqrt(1+m1^2);    %(125,56) and (150,15)
m2=0;c2=15;n2=sqrt(1+m2^2);             %(150,15) and (173,15)
m3=(37/20);c3=-6101/20;n3=sqrt(1+m3^2); %(173,15) and (193,52)
m4=(-38/23);c4=8530/23;n4=sqrt(1+m4^2); %(193,52) and (170,90)
m5=(38/7);c5=-5830/7;n5=sqrt(1+m5^2);   %(170,90) and (163,52)
m6=(-2/19);c6=1314/19;n6=sqrt(1+m6^2);  %(163,52) and (125,56)
d=5;

c1_new=-(d*n1-c1);
c2_new=-(d*n2-c2);
c3_new=-(d*n3-c3);
c4_new=d*n4+c4;
c5_new=d*n5+c5;
c6_new=d*n6+c6;
 
lp1=y-m1*x-c1_new;
lp2=y-m2*x-c2_new;
lp3=y-m3*x-c3_new;
lp4=y-m4*x-c4_new;
lp5=y-m5*x-c5_new;
lp6=y-m6*x-c6_new;

end
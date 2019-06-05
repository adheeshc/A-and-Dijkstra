function[cost2go]=c2g(x,y,xtarget,ytarget)

linear_cost=max(abs(xtarget-x),abs(ytarget-y)); 
diag_cost=min(abs(xtarget-x),abs(ytarget-y));
cost2go=((linear_cost-diag_cost)*10)+(diag_cost*floor((sqrt(2)*10)));

end

%diagonal dist will always be less than sum of linear distance

%%%%%%%%%%%%%
%REFERENCE

%https://math.stackexchange.com/questions/139600/how-do-i-calculate-euclidean-and-manhattan-distance-by-hand

%%%%%%%%%%%%%%%%
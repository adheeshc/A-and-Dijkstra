function [explored_nodes,parent_node,node_count,open_count,open_list,cost,cost2come,total_c2c]=new_node(xy,explored_nodes,close_list,parent_node,xtarget,ytarget,node_count,c2ccount,parent_count,open_count,count3,open_list,cost,cost2come,total_c2c,resolution,xstart,ystart,mink,clearance);

if (checkposition(xy(1),xy(2),resolution,mink,clearance))
    if(~ismember([xy(1),xy(2)],close_list,'rows'))
        if (count3==1)
            cost2come(open_count)=cost2come(c2ccount)+10*resolution;
        else
            cost2come(open_count)=cost2come(c2ccount)+(floor(sqrt(2)*10))*resolution;
        end
        
        cost2go=c2g(xy(1),xy(2),xtarget,ytarget);
        total_cost=cost2come(open_count)+cost2go;
        
        if(ismember([xy(1),xy(2)],open_list,'rows'))
            [~,index]=ismember([xy(1),xy(2)],open_list,'rows');
            if (cost2come(open_count)<cost2come(index))
                parent_node(:,:,node_count)=[node_count,parent_count];
                cost(index)=total_cost;
                cost2come(index)=cost2come(open_count);
            else
                parent_node(:,:,node_count)=[node_count,0];
            end
        else
            cost(open_count)=total_cost;
            parent_node(:,:,node_count)=[node_count,parent_count];
            open_list=[open_list;xy(1),xy(2)];
            total_c2c=[total_c2c,cost2come(open_count)];
            explored_nodes=[explored_nodes;xy(1),xy(2)];
            open_count=open_count+1;
            node_count=node_count+1;
        end
        
        r3=rectangle('Position',[xy(1),xy(2),resolution,resolution]);
        r3.FaceColor='yellow';
        r3.EdgeColor='black';
%        r3.LineWidth=1;
        pause(0.0001);
    end
end
end
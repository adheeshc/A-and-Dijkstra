function [id]= nodeid(node)
a=floor(node(1));
b=floor(node(2));
id=strcat(num2str(a),num2str(b));
id=str2num(id);
end
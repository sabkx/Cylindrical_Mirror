clear all;
close all;
clc;
%%
cylinder_length=0.14; % in meters
cylinder_radius=0.075./2; % in meters
%%
res_space=500;
cnt=zeros(res_space+1,res_space+1);
conv=cylinder_radius.*2./res_space;
init_pos=[0.9*cylinder_radius,0,0];
%%
for i=1:2.5e7
    z=rand();
    theta=rand().*2*pi;
    lr=light_ray(init_pos,[sqrt(1-z.^2).*cos(theta),sqrt(1-z.^2) ...
        .*sin(theta),z],0);
    % using https://math.stackexchange.com/questions/44689/how-to-find-a-random-axis-or-unit-vector-in-3d
    while true
        [flag,lr]=shine(lr,cylinder_length,cylinder_radius);
        if flag||anynan(lr.position)||anynan(lr.direction)
            break
        end
    end
    if anynan(lr.position)||anynan(lr.direction)||isnan(lr.distance)
        continue
    end
    x=round(lr.position(1)./conv)+res_space./2+1;
    y=round(lr.position(2)./conv)+res_space./2+1;
    cnt(x,y)=cnt(x,y)+1;
    % disp(i);
    if mod(i,1e6)==0
        disp(i);
    end
end
%%
% mesh(cnt);
%%
h=heatmap((movmean(movmean(cnt,1,1),1,2)),'CellLabelColor','none','Colormap',turbo);
s=struct(h);
s.XAxis.Visible='off';
s.YAxis.Visible='off';
h.GridVisible = 'off';
fh = gcf();  %if you don't already have the figure handle
originalUnits.fig = fh.Units;  % save original units (probaly normalized)
originalUnits.ax = h.Units; 
fh.Units = 'centimeters';  % any unit that will result in squares
h.Units = 'Normalize'; 
% Get number of rows & columns
sz = size(h.ColorData); 
% make axes square (not the table cells, just the axes)
h.Position(3:4) = min(h.Position(3:4))*[1,1]; 
fh.InnerPosition(3:4) = min(fh.InnerPosition(3:4))*[1,1]; 
% Change figure position;
if sz(1)>sz(2)
    % make the figure size more narrow
    fh.InnerPosition(3) = fh.InnerPosition(3)*(sz(2)/sz(1)); 
else
    % make the figure size shorter
    fh.InnerPosition(4) = fh.InnerPosition(4)*(sz(1)/sz(2)); 
end
% return original figure units
fh.Units = originalUnits.fig; 
h.Units = originalUnits.ax; 
% above code from https://www.mathworks.com/matlabcentral/answers/481666-heatmap-chart-depict-squares-rather-than-rectangles
x_bound=0.945;
y_bound=0.90;
mid_x=x_bound/2;
mid_y=y_bound/2;
ax=axes;
% xlim([left,width])
% ylim([bottom,height]);
plot(0,0,'.','Color','red','MarkerSize',0.1)
hold on;
plot(1,1,'.','Color','blue','MarkerSize',0.1)
plot(0.945,0.90,'.','Color','green','MarkerSize',0.1)
plot(mid_x+init_pos(2)/cylinder_radius*mid_x, ...
    mid_y-init_pos(1)/cylinder_radius*mid_y,'.','Color','red','MarkerSize',20)
hold off;
ax.Color = 'none';
ax.XTick = [];
ax.YTick = [];
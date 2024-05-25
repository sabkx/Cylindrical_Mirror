clear all;
close all;
clc;
%%
length=1;
width=3;
source=1.5;
num_sample=1000;
dx=width./(num_sample-1);
intensity=zeros(num_sample,1);
%%
for i=1:num_sample
    for j=-1000:1000
        if mod(j,2)==0
            pos=(i-1).*dx+j*width;
        else
            pos=(j+1).*width-(i-1).*dx;
        end
        intensity(i)=intensity(i)+1./((pos-source).^2+length.^2);
        % fprintf("%d %d %f\n",i,j,pos);
        % disp(1./((pos-source).^2+length.^2));
    end
end
%%
plot(linspace(0,width,num_sample),intensity,'LineWidth',3);
hold on;
plot(source,0,'r.','MarkerSize',72);
set(gca,'FontSize',16);
xlabel("Position",'FontSize',44);
ylabel("Intensity (arbitrary units)",'FontSize',44);
ylim([0,max(intensity).*1.2]);
xlim([0,width]);
%%
num_sample2=1000;
source_coord=linspace(0,width,num_sample2);
pos_of_max=zeros(num_sample2,1);
parfor i=1:num_sample2
    sim_intensity=Two_D_Sim(length,width,source_coord(i));
    [~,argmax]=max(sim_intensity);
    pos_of_max(i)=width./1499*(argmax-1);
end
%%
delete(gcp('nocreate'))
%%
plot(source_coord,pos_of_max,'LineWidth',3);
hold on;
plot([0,3],[0,3],'LineWidth',2,'LineStyle','--','Color','Red');
axis square;
xlim([0,3]);
ylim([0,3]);
legend(["Simulation","y=x"],'FontSize',24);
set(gca,'FontSize',16);
xlabel("Position of the source",'FontSize',36);
ylabel("Position with the maximum intensity",'FontSize',36);
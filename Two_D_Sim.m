function [intensity] = Two_D_Sim(length,width,source)
%Two_D_Sim Simulation for the 2D case
num_sample=1500;
dx=width./(num_sample-1);
intensity=zeros(num_sample,1);
for i=1:num_sample
    for j=-1000:1000
        if mod(j,2)==0
            pos=(i-1).*dx+j*width;
        else
            pos=(j+1).*width-(i-1).*dx;
        end
        intensity(i)=intensity(i)+1./((pos-source).^2+length.^2);
    end
end
end
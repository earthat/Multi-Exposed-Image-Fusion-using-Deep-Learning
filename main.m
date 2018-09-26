close all
clear 
clc
addpath(genpath(cd))
%% 
path=uigetdir('*');
I=load_images(path);
n=size(I,4);
subplotrows=ceil(n/3);
figure('Name','Input sequence');
for ii=1:n
    subplot(subplotrows,3,ii); imshow(I(:,:,:,ii));
end
%%
W_CNN=double(cnnFeatures_newnew(I));
RGB_proposed=zeros([size(I,1),size(I,2),size(I,3)]);
for ii=1:n
    for jj=1:3
        temp(:,:,jj)=W_CNN(:,:,jj,ii).*I(:,:,jj,ii);
    end
    RGB_proposed=RGB_proposed+temp;
end

R_hybrid=postprocessing(double(RGB_proposed));

figure('Name','Result by CNN features and fusion'); 
imshow((R_hybrid)) ;
%%
for ii=1:size(I,4)
    subplot(subplotrows,3,ii); imhist(I(:,:,:,ii));
end
figure
imhist(R_hybrid)



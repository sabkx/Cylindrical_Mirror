clear all;
close all;
clc;
%%
im = imread("Images/better_results_1.jpg");
imshow(im);
%%
conv_1 = [[-1, -1, -1], [-1, 8, -1], [-1, -1, -1]];
new_im_1 = conv2(im(:,:,1),conv_1);
new_im_2 = conv2(im(:,:,2),conv_1);
new_im_3 = conv2(im(:,:,3),conv_1);
new_im = cat(3, new_im_1, new_im_2, new_im_3);
imshow(new_im);
%%
u = [1 0 -1]';
v = [1 2 1];
new_im_1 = conv2(u, v, im(:,:,1));
new_im_2 = conv2(u, v, im(:,:,2));
new_im_3 = conv2(u, v, im(:,:,3));
new_im = cat(3, new_im_1, new_im_2, new_im_3);
imshow(new_im);
%%
conv_1 = [[-1, -1, -1], [-1, 8, -1], [-1, -1, -1]];
im_processed = sqrt(256-double(im));
new_im_1 = conv2(im_processed(:,:,1),conv_1);
new_im_2 = conv2(im_processed(:,:,2),conv_1);
new_im_3 = conv2(im_processed(:,:,3),conv_1);
new_im = cat(3, new_im_1, new_im_2, new_im_3);
new_im = new_im.*new_im;
imshow(new_im);
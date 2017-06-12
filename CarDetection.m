clc
clear

vidObj = VideoReader('3.mp4');
nFrames = vidObj.NumberOfFrames;

resim1 = rgb2gray(read(vidObj,1));
for k = 2 : nFrames
   resim2 = rgb2gray(read(vidObj,k));
   resim1kesim = resim1(390:720,200:970);
   resim2kesim = resim2(390:720,200:970);
   bs = imabsdiff(resim1kesim,resim2kesim);
   %th = graythresh(bs);
   binary = im2bw(bs,0.285);
   binary  = imclose(binary, true(20));
   binary = bwareaopen(binary,300);
   se = strel('disk',10);
   binary = imdilate(binary,se);
   binary = bwconvhull(binary,'object');
   B = bwboundaries(binary);
   
   hold on;
   for i = 1:length(B)
       boundary = B{i}; 
       plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2)
   end
   st = regionprops(binary,'BoundingBox');
   for b = 1 : length(st)
       thisBB = st(b).BoundingBox;
       rectangle('Position', [thisBB(1),thisBB(2),thisBB(3),thisBB(4)],'EdgeColor','b','LineWidth',2 )
   end
   resim1 = resim2;
   figure(1),imshow(resim2kesim);
end

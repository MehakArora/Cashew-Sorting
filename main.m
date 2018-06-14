%====== Main Function ======%

clear;
clc;

mk = zeros(8,1);
Xf = [];
Y = [];
%For Correct ones
for k = 1:5
    
    Directory = int2str(k);
    
    path = join(['images/',Directory,'/Training/*.JPG']);
    
    JPGfiles = dir(path);
    mk(k) = length(JPGfiles); 
    %Xf = zeros(mk(k),28);
    %Yf =zeros(mk(k),1);
    
    for j = 1:mk(k)
       
        name = join(['images/',Directory,'/Training/',JPGfiles(j).name]);
        
        I = imread(name);
        Ip = ImagePreprocessing(I);
        [Iseg, Ibin] = ImageSegmentation(Ip);
        Ig = rgb2gray(Iseg);
        X = []; 
        X = ShapeSizeFeature(Ibin,Ig,X);
        X = TextureFeatureExtract(Iseg,X);
        X = ColourFeatureExtract(Iseg,X);
        Xf = [Xf; X];
        Y = [Y; k];      %Class vector
    end
    
end

%For Defects
for k = 6:8
    
    Directory = int2str(k);
    
    path = join(['images/',Directory,'/Training/*.jpg']);
  
    JPGfiles = dir(path);
    mk(k) = length(JPGfiles); 
    %Xf = zeros(mk(k),28);
    %Yf =zeros(mk(k),1);
    
    for j = 1:mk(k)
       
        name = join(['images/',Directory,'/Training/',JPGfiles(j).name]);
        
        I = imread(name);
        Ip = ImagePreprocessing(I);
        [Iseg, Ibin] = ImageSegmentation(Ip);
        X = []; 
        Ig = rgb2gray(Iseg);
        X = ShapeSizeFeature(Ibin,Ig,X);
        X = TextureFeatureExtract(Iseg,X);
        X = ColourFeatureExtract(Iseg,X);
        Xf = [Xf; X];
        Y = [Y; k];      %Class vector
    end
    
end

XT = Xf;
YT = Y;
m = sum(mk)
mk = zeros(8,1);
Xf = [];
Y = [];
%For Correct ones
for k = 1:5
    
    Directory = int2str(k);
    
    path = join(['images/',Directory,'/Testing/CV/*.JPG']);
    
    JPGfiles = dir(path);
    mk(k) = length(JPGfiles); 
    %Xf = zeros(mk(k),28);
    %Yf =zeros(mk(k),1);
    
    for j = 1:mk(k)
       
        name = join(['images/',Directory,'/Testing/CV/',JPGfiles(j).name]);
        
        I = imread(name);
        Ip = ImagePreprocessing(I);
        [Iseg, Ibin] = ImageSegmentation(Ip);
        X = []; 
        Ig = rgb2gray(Iseg);
        X = ShapeSizeFeature(Ibin,Ig,X);
        X = TextureFeatureExtract(Iseg,X);
        X = ColourFeatureExtract(Iseg,X);
        Xf = [Xf; X];
        Y = [Y; k];      %Class vector
    end
    
end

%For Defects
for k = 6:8
    
    Directory = int2str(k);
    
    path = join(['images/',Directory,'/Testing/CV/*.jpg']);
  
    JPGfiles = dir(path);
    mk(k) = length(JPGfiles); 
    %Xf = zeros(mk(k),28);
    %Yf =zeros(mk(k),1);
    
    for j = 1:mk(k)
       
        name = join(['images/',Directory,'/Testing/CV/',JPGfiles(j).name]);
        
        I = imread(name);
        Ip = ImagePreprocessing(I);
        [Iseg, Ibin] = ImageSegmentation(Ip);
        X = []; 
        Ig = rgb2gray(Iseg);
        X = ShapeSizeFeature(Ibin,Ig,X);
        X = TextureFeatureExtract(Iseg,X);
        X = ColourFeatureExtract(Iseg,X);
        Xf = [Xf; X];
        Y = [Y; k];      %Class vector
    end
    
end

Xcv = Xf;
Ycv = Y;
mcv = sum(mk)

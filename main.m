%====== Main Function ======%

clear;
clc;
I = imread('_MG_1799.JPG');
Ip = ImagePreprocessing(I);
[Iseg, Ibin] = ImageSegmentation(Ip);

X = [];

X = ShapeSizeFeature(Ibin,X);
X = TextureFeatureExtract(Iseg,X);
X = ColourFeatureExtract(Iseg,X);





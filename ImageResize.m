function Iresize = ImageResize(I,width)
   dim = size(I);
   Iresize = imresize(I,[width*dim(1)/dim(2) width]);
end
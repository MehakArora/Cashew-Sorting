function Ip = ImagePreprocessing(I)

    Ip = im2double(I);
    Ip = ImageResize(Ip,800);
    Ip = ImageSharpen(Ip,2,1.7);
    
end
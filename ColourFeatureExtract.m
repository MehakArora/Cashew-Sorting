function X = ColourFeatureExtract(Iseg,X)
    
        Ihsv = rgb2hsv(Iseg);
        H = Ihsv(:,:,1);
        S = Ihsv(:,:,2);
        V = Ihsv(:,:,3);
        
        R = Iseg(:,:,1);
        G = Iseg(:,:,2);
        B = Iseg(:,:,3);
             
        %20. Mean
        meanH = mean2(H);
        meanS = mean2(S);
        meanV = mean2(V);
        X = [meanH meanS meanV X];
        
        meanR = mean2(R);
        meanG = mean2(G);
        meanB = mean2(B);
        X = [meanR meanG meanB X];
        
        %21. Std Dev
        stdH = std2(H);
        stdS = std2(S);
        stdV = std2(V);
        X = [stdH stdS stdV X];
        
        stdR = std2(R);
        stdG = std2(G);
        stdB = std2(B);
        X = [stdR stdG stdB X];
        
        %22. Skewness
        skewH = skewness(H(:));
        skewS = skewness(S(:));
        skewV = skewness(V(:));
        X = [skewH skewS skewV X];
        
        skewB = skewness(B(:));
        skewG = skewness(G(:));
        skewR = skewness(R(:));
        X = [skewR skewG skewB X];
        
        %23. Delta E
    
        %X = [DelE X];
 
end
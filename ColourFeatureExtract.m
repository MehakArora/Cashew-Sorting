function X = ColourFeatureExtract(Iseg,X)
    
        Ihsv = rgb2hsv(Iseg);
        H = Ihsv(:,:,1);
        S = Ihsv(:,:,2);
        V = Ihsv(:,:,3);
             
        %20. Mean
        meanH = mean2(H);
        meanS = mean2(S);
        meanV = mean2(V);
        X = [meanH meanS X];
        
        %21. Std Dev
        stdH = std2(H);
        stdS = std2(S);
        X = [stdH stdS X];
        
        %22. Skewness
        skewH = skewness(skewness(H,1,2));
        skewS = skewness(skewness(S,1,2));
        X = [skewH skewS X];
        
        %23. Delta E
        [r,c] = size(H);
        Hmean = meanH*ones(r,c);
        Smean = meanS*ones(r,c);
        Vmean = meanV*ones(r,c);
        
        Hcomp = (Hmean - H);
        Scomp = Smean - S;
        Vcomp = Vmean - V;
        DeltaE = sqrt(Hcomp.^2 + Scomp.^2 + Vcomp.^2);
        DelE = mean2(DeltaE);
        X = [DelE X];
 
end
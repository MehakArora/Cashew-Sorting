function X = TextureFeatureExtract(Iseg,X)
    
        Igrey = rgb2gray(Iseg);
        glcmI = graycomatrix(Igrey);
        GlcmStats = graycoprops(glcmI);
                       
        %15. Energy 
        EnergyI = GlcmStats.Energy;
        X = [EnergyI X];
        
        %16. Contrast
        ContrastI = GlcmStats.Contrast;
        X = [ContrastI X];
        
        %17. Correlation
        CorrelationI = GlcmStats.Correlation;
        X = [CorrelationI X];
        
        %18. Homogeneity
        HomoI = GlcmStats.Homogeneity;
        X = [HomoI X];
        
        %19. Entropy and 20.Uniformity
        
        V = Igrey(:,:,1);
        Z = V(:);
        IL = unique(Z);        % Get all intensity levels
        noinle = numel(IL);    % Number of intensity levels
        p = hist(V, noinle); % Histogram
        U = 0;
        for i = 1:noinle
            U = U + sum( p(i,:).^2 );
        end
        
        X = [U X];

        h = imhist(Igrey);
        pdf = h / numel(Igrey);

        %// Set any entries that are 0 to 1 so that log calculation equals 0.
        pdf(pdf == 0) = 1;

        %// Calculate entropy
        e = -sum(pdf.*log2(pdf));  
        X = [e X];
        
        %21. Local Binary Patter
        LBP = extractLBPFeatures(Igrey,'Upright',false);
        X = [LBP X];
        
end
        
        
        
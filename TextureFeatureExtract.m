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
        
        %19. Entropy
        EntropyI = entropy(Igrey);
        X = [EntropyI X];        
        
end
        
        
        
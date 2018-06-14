function X = ShapeSizeFeature(Ibin,Ig,X)
    
    [Ibin,sz] = RemoveExtraComp(Ibin);
    statso = regionprops(Ibin,'Orientation');
    Angle = statso.Orientation;
    Ibin = imrotate(Ibin, -Angle);
    Ig = imrotate(Ig, -Angle);
    Ibin = ImageResize(Ibin,800);
    Ig = ImageResize(Ig,800);
    B = GreatestBoundary(Ibin); 
    Ig(Ibin == 0) = 0;
    
    stats = regionprops(Ibin,Ig,'MajorAxisLength','MinorAxisLength','Orientation',...
    'Centroid','Solidity','ConvexArea', 'Extent','Perimeter','Area','MaxIntensity',...
    'MinIntensity','MeanIntensity','WeightedCentroid','Eccentricity','EquivDiameter');
    
     %1. AREA
     %totalpix = sz(1)*sz(2);
     AreaI = stats.Area;
     %sizeI = AreaI/totalpix;
     X = [AreaI X];
     
     %2.Major and 3.minor Axis and 4.Aspect ratio
     MajorAxis = stats.MajorAxisLength;
     MinorAxis = stats.MinorAxisLength;
     Aspect = MajorAxis/MinorAxis; 
     X = [MajorAxis MinorAxis Aspect X];
     
     %5.Perimeter
     PerimeterI = stats.Perimeter;
     X = [PerimeterI X];
     
     %6.Eccentricity
     EccentricityI = stats.Eccentricity;
     X = [EccentricityI X];
     
     %7. Equivivalent Diameter
     EquivDiameterI = stats.EquivDiameter;
     X = [EquivDiameterI X];
     
     %8. Extent 
     ExtentI = stats.Extent;
     X = [ExtentI X];
     
     %9.Convex Area
     ConvexAreaI = stats.ConvexArea;
     X = [ConvexAreaI X];
     
     %10. Solidity
     SolidityI = stats.Solidity;
     X = [SolidityI X];
     
     %11. Roundness
     RoundnessI = 4*pi*AreaI/(PerimeterI^2);
     X = [RoundnessI X];
     
     %12. Compactness
     CompactnessI = sqrt(4*AreaI/pi)/MajorAxis;
     X = [CompactnessI X];
     
     %13. Shape Feature
     SF1 = MajorAxis/AreaI;
     SF2 = AreaI/(MajorAxis^3);
     SF3 = AreaI/((MajorAxis/2)*(MinorAxis/2)*pi);
     X = [SF1 SF2 SF3 X];
     
     %14. Shape
     Center = stats.Centroid;
     C = [Center(1,2) Center(1,1)];
     D = B - C;
     D = sqrt(D.^2);
     R = fft(D);
     FF1 = R(1);
     X = [FF1 X];
     
     %15.Min Intensity 16. Max Intensity 17.Mean Intensity
     MinI = stats.MinIntensity;
     MaxI = stats.MaxIntensity;
     MeanI = stats.MeanIntensity;
     X = [MeanI MaxI MinI X];
     
     %18.WeightedCentroid - Centroid
     WC = stats.WeightedCentroid;
     Distance = sqrt(sum(((WC-Center).^2),2));
     X = [Distance X];
     
end
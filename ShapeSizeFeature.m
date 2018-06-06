function X = ShapeSizeFeature(Ibin,X)
     
     %Ibin = Ibin(:,:,1);
     %sz = size(Ibin);
     
     %Keeping the biggest component
    
     %CC = bwconncomp(Ibin);
     %numPixels = cellfun(@numel,CC.PixelIdxList);
     %[biggest,idx] = max(numPixels);
     
    % for i = 1:length(numPixels)
     %     if (i ~=idx)
      %         Ibin(CC.PixelIdxList{i}) = 0;
      %    end
     %end
    [Ibin,sz] = RemoveExtraComp(Ibin);
    
    boundaries = bwboundaries(Ibin); 
    
     stats = regionprops(Ibin,'Area','Centroid','BoundingBox','MajorAxisLength','MinorAxisLength',...
         'Eccentricity','Extent','EquivDiameter','Solidity','ConvexArea','Perimeter');
     
     %1. Size
     totalpix = sz(1)*sz(2);
     AreaI = stats.Area;
     sizeI = AreaI/totalpix;
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
     B = boundaries{1};
     D = B - Center;
     D = sqrt(D.^2);
     R = fft(D);
     FF1 = R(1);
     %FF2 = R(2);
     X = [FF1 X];
     
end
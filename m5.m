
[Is,Ib] = ImageSegmentation(Ip);
Ig = rgb2gray(Is);
Ib = Ib(:,:,1);
Ib = RemoveExtraComp(Ib);
B = GreatestBoundary(Ib);
Ig(Ib == 0) = 0;
stats = regionprops(Ib,Ig,'MajorAxisLength','MinorAxisLength','Orientation',...
    'Centroid','Solidity','ConvexArea', 'Extent','Perimeter','Area','MaxIntensity',...
    'MinIntensity','MeanIntensity','WeightedCentroid');

C = stats.Centroid;
WC = stats.WeightedCentroid;
Dist = sqrt(sum(((WC - C).^2),2))
imshow(Is);
hold on;
plot(B(:,2),B(:,1),'r');
hold on;
plot(C(1,1),C(1,2),'g+','MarkerSize',30);
hold on;
plot(WC(1,1),WC(1,2),'c+','MarkerSize',35);
D = B-C;
D = D.^2;
D = sum(D,2);
D = sqrt(D);
F = fft(D);
F(1);
X = [F(1)];
 MajorAxis = stats.MajorAxisLength;
     MinorAxis = stats.MinorAxisLength;
     Aspect = MajorAxis/MinorAxis; 
     X = [MajorAxis MinorAxis Aspect X];
     
 %8. Extent 
     ExtentI = stats.Extent;
     X = [ExtentI X];
     
     %9.Convex Area
     ConvexAreaI = stats.ConvexArea;
     X = [ConvexAreaI X];
     
     %10. Solidity
     SolidityI = stats.Solidity;
     X = [SolidityI X];
     
     PerimeterI = stats.Perimeter;
     AreaI = stats.Area;
     %11. Roundness
     RoundnessI = 4*pi*AreaI/(PerimeterI^2);
     X = [RoundnessI X];
     
     %12. Compactness
     CompactnessI = sqrt(4*AreaI/pi)/MajorAxis;
     X = [CompactnessI X];
     
    
     


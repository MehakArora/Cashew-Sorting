function [Iseg,Ibin,r] = ImageSegmentation(I)
    lab_he = rgb2hsv(I);
    ab = lab_he(:,:,2:3) ;   
    nrows = size(ab,1);
    ncols = size(ab,2);
    ab = reshape(ab,nrows*ncols,2);
   
    %save('ab.txt', 'ab', '-ascii')
    %rows = abs(ab(:,1) + ab(:,2)) < 0.000001; 
    %ab(rows, :) = []; 
    %nrows = size(ab,1);
    %ncols = size(ab,2);
    sumd = zeros(2,1);
    
for j = 2:3
  nColors = j;
    % repeat the clustering 3 times to avoid local minima
  %options = statset('Display', 'final');
    [cluster_idx, cluster_center, sum_d] = kmeans(ab,nColors,'distance','sqeuclidean', ...
          'Replicates',3);
    sumd(j,1) = sum(sum_d);
end

r = sumd(2)/sumd(3); 

if((sumd(2)/sumd(3)) > 1.7)
    nColors = 3;
else 
    nColors = 2;
end

nColors;
[cluster_idx, cluster_center, sum_d] = kmeans(ab,nColors,'distance','sqeuclidean', ...
          'Replicates',3);

      
    
%figure;
    %one = find(cluster_idx == 1);
    %two = find(cluster_idx == 2);
    %three = find(cluster_idx == 3);
    %four = find(cluster_idx ==4);
    %scatter(ab(one,1),ab(one,2),'MarkerEdgeColor','g');
    %hold on;
    %scatter(ab(two,1),ab(two,2),'MarkerEdgeColor','c');
    %hold on;
    %scatter(ab(four,1),ab(four,2),'MarkerEdgeColor','m')
    %hold on;
 %   scatter(cluster_center(:,1),cluster_center(:,2),'MarkerEdgeColor','r'); 
 %   hold on;
    %scatter(ab(three,1),ab(three,2),'MarkerEdgeColor','b'); 
    %hold off;
%cluster_center;
%count = zeros(length(cluster_idx),3);
%count(cluster_idx ==1, 1) = 1;
%count(cluster_idx ==2, 2) = 1;
%count(cluster_idx ==3, 3) = 1;
%count(cluster_idx ==4, 4) = 1;
%sum(count)

pixel_labels = reshape(cluster_idx,nrows,ncols);
%figure; imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = I;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end

%figure;
%imshow(segmented_images{1}), title('objects in cluster 1');
%figure;
%imshow(segmented_images{2}), title('objects in cluster 2');

%figure;
%imshow(segmented_images{3}), title('objects in cluster 3');
%figure;
%imshow(segmented_images{4}), title('cluster 4');

mean_cluster_value = mean(cluster_center,2);
[tmp, idx] = sort(mean_cluster_value);
cashew_cluster_num = idx(nColors);
background  = idx(1);
Iseg = I - segmented_images{background};
%nuclei_labels = repmat(uint8(0),[nrows ncols]);
%nuclei_labels(blue_idx(is_light_blue==false)) = 1;
%nuclei_labels = repmat(nuclei_labels,[1 1 3]);

cashew_object = segmented_images{cashew_cluster_num};
%cashew_object() = 0;
%figure;
%imshow(cashew_object), title('Cashew');
%Iseg = cashew_object;
Ibin = ones(size(Iseg));
Ibin(Iseg == 0) = 0;
Ibin = imbinarize(Ibin);

end
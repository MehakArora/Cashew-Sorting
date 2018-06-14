Ihsv = rgb2hsv(RGB);
 H = Ihsv(:,:,1);
        S = Ihsv(:,:,2);
        V = Ihsv(:,:,3);
  stdV = std2(V)
  Z = V(:);
  IL = unique(Z);        % Get all intensity levels
noinle = numel(IL);    % Number of intensity levels
p = hist(V, noinle); % Histogram

U = 0;

for i = 1:noinle
    U = U + sum( p(i,:).^2 );
end

U

h = imhist(RGB);
pdf = h / numel(RGB);

%// Set any entries that are 0 to 1 so that log calculation equals 0.
pdf(pdf == 0) = 1;

%// Calculate entropy
e = -sum(pdf.*log2(pdf))
function boundary = GreatestBoundary(Ibin)
    B = bwboundaries(Ibin);
    size = zeros(length(B),1);
    for i = 1:length(B)
        size(i,1) = length(B{i});
    end
    
    [n, ind] = max(size);
    boundary = B{ind};
end
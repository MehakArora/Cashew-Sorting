function Isharp = sharpen(I,radius,amount)
    Isharp = imsharpen(I,'radius', radius, 'amount', amount);
end
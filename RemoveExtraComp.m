function [Ibin,sz] = RemoveExtraComp(Ibin)

     Ibin = Ibin(:,:,1);
     sz = size(Ibin);
     
     %Keeping the biggest component
     CC = bwconncomp(Ibin);
     numPixels = cellfun(@numel,CC.PixelIdxList);
     [biggest,idx] = max(numPixels);
     
     for i = 1:length(numPixels)
          if (i ~=idx)
               Ibin(CC.PixelIdxList{i}) = 0;
          end
     end  
end
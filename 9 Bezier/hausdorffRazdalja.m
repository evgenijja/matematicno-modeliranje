function dist = hausdorffRazdalja(set1,set2)

% n1 = length(mn1); n2 = length(mn2);
% 
% seznam = [];
% for j=1:n2
%     sez = [];
%     for i=1:n1
%         razdalja = norm(mn1(:,i)-mn2(:,j), 2);
%         sez = [sez, razdalja];
%     end
%     minimum = min(sez);
%     seznam = [seznam, minimum];  
% end
% razd = max(seznam);
% end

noPts = size(set2,2);

dist = 0;
for i=1:noPts
   dist_i = set1-set2(:,i);
   dist_i = min(sqrt(dist_i(1,:).^2 + dist_i(2,:).^2));
   if dist_i>dist
       dist = dist_i;
   end    
end

end
     
function pred = Knn(traindata,testdata,k,r,opt)
pred = [];
j = 0;
distAll = [];
if opt ==1
 for j = 1:length(testdata)
   neighbors = [];
   c = [];
   b = testdata(j,1:4); 
   dist = [];
   class1 = 0;
   class2 = 0;
   class3 = 0;
   class_votes = [];
dist = Minkowshi_Distance(traindata(:,1:4),b,r);
c = [traindata,dist];
s = sortrows(c,6);
neighbors = s(1:k,5:6);
n = neighbors(:,1);
for i = 1:length(n) 
    if n(i,1) == 1
        class1 = 1+class1;
    elseif n(i,1)==2
        class2 = 1+class2;
    else
        class3 = 1+class3;
    end
end
class_votes = [class1,class2,class3];
     if class_votes (1,1) == max(class_votes)
         pred(j,1) = 1;
     elseif class_votes(1,2) == max(class_votes)
         pred(j,1) = 2;
     else
        pred(j,1) = 3;
     end
 j = j+1;
 end
end

 %average weight%
if opt ==2 
 for j = 1:length(testdata)
   neighbors = [];
   c = [];
   b = testdata(j,1:4); 
   dist = [];
   sd_1 = 0;
   sd_2 = 0;
   sd_3 = 0;
   l_1 = [];
   l_2 = [];
   l_3 = [];
   avg = [];
    a_1 = traindata(:,1:4);
dist = Minkowshi_Distance(a_1,b,r);
c = [traindata(:,5),dist];
s = sortrows(c,2);
neighbors = s(1:k,:);
f = neighbors(:,:);
for i = 1:length(f)
    if f(i,1) == 1
        d_1 = f(i,2);
        l_1 = [l_1,d_1];
        sd_1 = [sd_1 + d_1];
    elseif f(i,1) ==2
        d_2 = f(i,2);
        l_2 = [l_2,d_2];
        sd_2 = [sd_2 + d_2];
    else
        d_3 = f(i,2);
        l_3 = [l_3,d_3];
        sd_3 = [sd_3 + d_3];
 end
end
    avg_1 = (sd_1/length(l_1));
    avg_2 = (sd_2/length(l_2));
    avg_3 = (sd_3/length(l_3));
    avg = [avg_1,avg_2,avg_3];
    
     if avg (1,1) == min(avg(1,:))
         pred(j,1) = 1;
     elseif avg(1,2) == min(avg(1,:))
         pred(j,1) = 2;
     else
         pred(j,1) = 3;
     end
j = j+1;
end
end
end


    
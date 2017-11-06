EvalMatrix=ClusterSizes;
ClusterCount=zeros(N,1);
for i=1:N
    ClusterCount(i,1)=size(find(EvalMatrix==i),1);
end

scatter([1:N],ClusterCount)
edges=[1:1:9, 10:10:90, 100:100:900, 1000:1000:10000]
Y = discretize(ClusterCount,edges)
EvalMatrix=ClusterSizes;
ClusterCount=zeros(N,1);
for i=1:N
    ClusterCount(i,1)=size(find(EvalMatrix==i),1);
end
logClusters=10*log10(ClusterCount);
x = 10*log10([1:N]);
figure;
plot(x,logClusters);
axis([1 max(x) 0 max(logClusters)+1]);
edges=[1:1:9, 10:10:90, 100:100:900, 1000:1000:10000];
%Y = discretize(ClusterCount,edges)
%------------Initialise model
clear all

%------------- CONFIG ------------------------
M=6400; % no of connections
N=3200; % no of people
k=2*M/N; % avg degree
gamma=20; % N/G
G=N/gamma; % number of opinion
phi=0.04; % transition probability


no_of_runs= 10; % amount of times to run simulation
duration= 100000; % number of iterations
%------------- ENDCONFIG -----------------------

ClusterSizes = opinion_change_model(N,M,k,G,phi,no_of_runs,duration);

for r = 1:2:no_of_runs
    ClusterCount = squeeze(ClusterSizes(:,r));
    for s = 1:2*max(ClusterCount)
        p(s,r) = size(find(ClusterCount(:) == s),1);
        P(s,r) = p(s,r)./N;   %The probability of the group size;
    end
    
end
figure;
hold on;plot(P(:,r),'-.');
grid on;
axis([0 2*G 0 0.01]);
%hold on;plot(p(:,5),'color','b');
%hold on;plot(p(:,r),'color','k');


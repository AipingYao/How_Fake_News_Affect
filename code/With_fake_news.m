%------------Initialise model
clear all

%------------- CONFIG ------------------------
M=6400; % no of connections
N=3200; % no of people
k=2*M/N; % avg degree
gamma=20; % N/G
G=N/gamma; % number of opinion
G = 2;
phi=0.98; % transition probability


Fake.no = 50;   % number of fake news
Fake.target = 1;  % target opinion fake news want to be;
Fake.beta = 0.1;   % fake news affect possibility;


no_of_runs= 1; % amount of times to run simulation
duration= 100000; % number of iterations
%------------- ENDCONFIG -----------------------

ClusterSizes = OP_change(N,M,k,G,phi,no_of_runs,duration,Fake);


for r = 1:2:no_of_runs
    ClusterCount = squeeze(ClusterSizes(:,r));
    for s = 1:2*max(ClusterCount)
        p(s,r) = size(find(ClusterCount(:) == s),1);
        P(s,r) = p(s,r)./N;   %The possiblity of the group size;
    end
    
end
figure;
hold on;plot(P(:,r),'-.');
grid on;
axis([0 2*G 0 0.01]);
%hold on;plot(p(:,5),'color','b');
%hold on;plot(p(:,r),'color','k');
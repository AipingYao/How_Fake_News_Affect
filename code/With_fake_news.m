%------------Initialise model

close all;
clear all;

%------------- CONFIG ------------------------
M=6400; % no of connections
N=3200; % no of people
k=2*M/N; % avg degree
gamma=20; % N/G
G=N/gamma; % number of opinion
G = 2;
phi=0.98; % transition probability

Fake.add = 1;
Fake.target = 1;    % target opinion fake news want to be;

Fake.medium = {'CNN','20mins','both'};
Fake.beta = [0.5,0.1];           % fake news affect possibility;
Fake.no = [1,3];               % number of fake news
Fake.affect_person = [2,1,1]; 

cost = 100*Fake.no(1) + 10*Fake.no(2)  %this is just a random equatioin, need to change
        



no_of_runs= 1; % amount of times to run simulation
duration= 10000; % number of iterations
%------------- ENDCONFIG -----------------------

%[ClusterSizes, Connections] = OP_change_Cell(N,M,G,phi,duration,Fake);
[ClusterSizes,Connections] =  OP_change(N,M,k,G,phi,duration,Fake);


% for r = 1:2:no_of_runs
%     ClusterCount = squeeze(ClusterSizes(:,r));
%     for s = 1:2*max(ClusterCount)
%         p(s,r) = size(find(ClusterCount(:) == s),1);
%         P(s,r) = p(s,r)./N;   %The possiblity of the group size;
%     end
%     
% end
% figure;
% hold on;plot(P(:,r),'-.');
% grid on;
% axis([0 2*G 0 0.01]);
%hold on;plot(p(:,5),'color','b');
%hold on;plot(p(:,r),'color','k');
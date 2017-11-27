%------------Initialise model
clear all

%------------- CONFIG ------------------------
M=6400; % no of connections
N=3200; % no of people
k=2*M/N; % avg degree
gamma=10; % N/G
G=N/gamma; % number of opinion
phi=0.04; % transition probability


no_of_runs= 5; % amount of times to run simulation
duration= 1000000; % number of iterations
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
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
dim = [.6 .5 1.0 0.4];
box_string_format= ...
    "Phi: %d\n M: %d\n N: %d\n Opinions: %d\n Runs: %d\n Timesteps: %d";
box_string=sprintf(box_string_format,round(phi,3),M,N,G,no_of_runs,duration);
annotation('textbox',dim,'String',box_string,'FitBoxToText','on');
%hold on;plot(P(:,r),'-.');
hold on; plot(P(:,r),'o');
grid on;
%axis([0 2*G 0 0.01]);
axis([0 N 0 0.1])
%hold on;plot(p(:,5),'color','b');
%hold on;plot(p(:,r),'color','k');


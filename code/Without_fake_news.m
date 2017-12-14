%------------Initialise model
clear all

%------------- CONFIG -------------------------
M=640; % no of connections
N=320; % no of people
k=2*M/N; % avg degree
gamma=10; % N/G
G=N/gamma; % number of opinion
phi=0.04; % transition probability
Fake.add = 0;

no_of_runs= 10; % amount of times to run simulation
abort_threshold = 10000; % number of times clusters have to stay the same
duration= 1000000; % number of iterations within each run
%------------- ENDCONFIG -----------------------

[ClusterSizes,average_iterations] = ...
    opinion_change_model(N,M,k,G,phi,no_of_runs,duration,abort_threshold);

[bla, s_averaged] = ...
    plot_averaged_results(ClusterSizes,N,M,G,phi,duration,...
    average_iterations,no_of_runs,Fake);

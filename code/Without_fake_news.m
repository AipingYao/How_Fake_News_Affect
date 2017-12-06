%------------Initialise model
clear all

%------------- CONFIG -------------------------
M=6400; % no of connections
N=3200; % no of people
k=2*M/N; % avg degree
gamma=10; % N/G
G=N/gamma; % number of opinion
phi=0.04; % transition probability

no_of_runs= 10; % amount of times to run simulation
duration= 1000000; % number of iterations within each run
%------------- ENDCONFIG -----------------------

ClusterSizes = opinion_change_model(N,M,k,G,phi,no_of_runs,duration);

[bla, s_averaged] = plot_averaged_results(ClusterSizes,N,M,G,phi,duration,no_of_runs);

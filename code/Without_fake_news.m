% Runs Holme's model once with abort criterion

%------------Initialise model
clear all

%------------- CONFIG -------------------------
M=640; % no of connections
N=320; % no of people
k=2*M/N; % avg degree
gamma=10; % N/G
G=N/gamma; % number of opinion
phi=0.04; % transition probability
Fake.add = 0; % to denote absence of fake news

no_of_runs= 10; % amount of times to run simulation
abort_threshold = 10000; % number of times clusters have to stay the same

%------------- ENDCONFIG -----------------------

[ClusterSizes,average_iterations] = ...
    opinion_change_model(N,M,G,phi,no_of_runs,abort_threshold);

plot_averaged_results(ClusterSizes,N,G,phi,...
    average_iterations,no_of_runs);

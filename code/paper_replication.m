%------------Initialise 1st model
clear all

%------------- CONFIG -------------------------
M=60; % no of connections
N=30; % no of people
k=2*M/N; % avg degree
gamma=10; % N/G
G=N/gamma; % number of sopinion
phi_1=0.04; % transition probability

no_of_runs= 10; % amount of times to run simulation
abort_threshold = 1000;
duration= 1000000; % number of iterations within each run
%------------- ENDCONFIG -----------------------

ClusterSizes_1 = opinion_change_model(N,M,k,G,phi_1,no_of_runs,duration);
% 
[s_averaged_binned_1, s_averaged_1] = plot_averaged_results(ClusterSizes_1,N,M,G,phi_1,duration,no_of_runs);

%------------Initialise 2nd model

%------------- CONFIG -------------------------
phi_2=0.458; % transition probability
%------------- ENDCONFIG -----------------------

ClusterSizes_2 = opinion_change_model(N,M,k,G,phi_2,no_of_runs,duration);
% 
[s_averaged_binned_2, s_averaged_2] = plot_averaged_results(ClusterSizes_2,N,M,G,phi_2,duration,no_of_runs);

%------------Initialise 3rd model

%------------- CONFIG -------------------------
phi_3=0.96; % transition probability
%------------- ENDCONFIG -----------------------

ClusterSizes_3 = opinion_change_model(N,M,k,G,phi_3,no_of_runs,duration);

[s_averaged_binned_3, s_averaged_3] = plot_averaged_results(ClusterSizes_3,N,M,G,phi_3,duration,no_of_runs);

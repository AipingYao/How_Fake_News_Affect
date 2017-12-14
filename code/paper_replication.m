% Runs and plots model 3 times for each phi in Holme's (0.04, 0.458, 0.96)

%------------Initialise 1st model
clear all

%------------- CONFIG -------------------------
M=6400; % no of connections
N=3200; % no of people
k=2*M/N; % avg degree
gamma=10; % N/G
G=N/gamma; % number of sopinion
phi_1=0.04; % transition probability
Fake.add=0; % to denote absence of fake news input

no_of_runs= 1; % amount of times to run simulation
abort_threshold = 1;
%------------- ENDCONFIG -----------------------

[ClusterSizes_1,average_iterations_1] = ...
    opinion_change_model(N,M,G,phi_1,no_of_runs,abort_threshold);

plot_averaged_results(ClusterSizes_1,N,G,phi_1,average_iterations_1,no_of_runs);

 %save('20_runs 004')
%------------Initialise 2nd model

%------------- CONFIG -------------------------
  phi_2=0.458; % transition probability
% %------------- ENDCONFIG -----------------------
% 
[ClusterSizes_2,average_iterations_2] = ...
    opinion_change_model(N,M,G,phi_2,no_of_runs,abort_threshold);

plot_averaged_results(ClusterSizes_2,N,G,phi_2,average_iterations_2,no_of_runs);

% %save('100 runs 0458')
% %------------Initialise 3rd model
% 
%------------- CONFIG -------------------------
phi_3=0.96; % transition probability
%------------- ENDCONFIG -----------------------

[ClusterSizes_3,average_iterations_3] = ...
    opinion_change_model(N,M,G,phi_3,no_of_runs,abort_threshold);

plot_averaged_results(ClusterSizes_3,N,G,phi_3,average_iterations_3,no_of_runs);
% save('50 runs 0458')
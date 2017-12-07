%------------Initialise model
close all;
clear all;

%------------- CONFIG ------------------------
M=600; % no of connections
N=300; % no of people
k=2*M/N; % avg degree
gamma=20; % N/G
G=N/gamma; % number of opinion
%G = 2;
phi=0.2; % transition probability
withGraphics = 0;

Fake.add = 1; % 1 for fake news included, 0 for initial model
Fake.target = 1;    % target opinion fake news want to be;

Fake.add = 1; % 1 for fake news included, 0 for initial model
Fake.target = 1;    % target opinion fake news want to be;
Fake.budget = 100;

Fake.strategy = 2;
Fake.medium = {'CNN','20mins','both'};
Fake.beta = [0.8,0.1];           % fake news affect possibility;
Fake.no = [1,0];               % number of fake news
Fake.affect_person = [1,0,0]; 

no_of_runs= 3; % amount of times to run simulation
abort_threshold = 1000; % Number of times network has to stay the same before abort
duration= 20; % number of iterations with each run
%------------- ENDCONFIG -----------------------

% Initialize for both runs
[IndividualsInit,ConnectionsInit] = initialize(N,M,G);

% Run with fake news
[ClusterSizes,average_iterations] = ...
    extended_model_with_ext_init(N,M,k,G,phi,IndividualsInit, ...
    ConnectionsInit,abort_threshold,no_of_runs,Fake);

% Run without fake news but same initial conditions
Fake_without.add = 0;
[ClusterSizes_no_fake_news,average_iterations_no_fake_news] = ...
    extended_model_with_ext_init(N,M,k,G,phi,IndividualsInit, ...
    ConnectionsInit,abort_threshold,no_of_runs,Fake);

% Plot results
plot_averaged_results(ClusterSizes,N,M,G,phi,duration, ...
    average_iterations,no_of_runs,Fake);
plot_averaged_results(ClusterSizes_no_fake_news,N,M,G,phi,duration, ...
    average_iterations_no_fake_news,no_of_runs,Fake_without);

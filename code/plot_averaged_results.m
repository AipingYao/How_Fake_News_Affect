function [averaged_binned_cluster_sizes, s_averaged] = ...
    plot_averaged_results(ClusterSizes,N,M,G,phi,duration, ...
    average_iterations, no_of_runs,Fake)
%PLOT_AVERAGED_RESULTS takes results from all runs of the model and plots
% it as in Holme's paper, i.e. averaged and binned logarithmically,P(s) vs.
% s

% no_of_runs is the number times the model was run
% G is the number of opinions
% N is the number of individuals in the model
% ClusterSizes is a matrix with dimensions Gxno_of_runs which contains for
% each run the cluster sizes of all opinions
% ... describe rest of params
% Fake struct containing all info on fake news input; 0 means no input

% TODO nicen up and comment a bit

P=zeros(G,no_of_runs);
p=zeros(G,no_of_runs);

for r = 1:no_of_runs
    ClusterCount = squeeze(ClusterSizes(:,r));
    for s = 1:N
        p(s,r) = size(find(ClusterCount(:) == s),1);
        P(s,r) = p(s,r)./N;   %The probability of the group size;
    end 
end

s_averaged = sum(P,2)./no_of_runs;

exponent = ceil(log10(N));
bins = 10.^((0:exponent));
final_bins = [];

for i=2:length(bins)
    arr = bins(i-1):10^(i-2):(bins(i)-1);
    final_bins = [final_bins arr];
end

for j=2:length(final_bins)
    binsum = 0;
    if final_bins(j)>N
        arr=s_averaged(final_bins(j):N);
        binsum=sum(arr);
        s_averaged_binned(j-1)=binsum;
        break;
    else
        for k=final_bins(j-1):(final_bins(j)-1)
            binsum = binsum+s_averaged(k);
            s_averaged_binned(j-1)=binsum;
        end
    end
end

% Number of bins to plot
no_of_bins = length(s_averaged_binned);
% [indices, values]=log_bin(s_averaged, 10);

figure
set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
grid on;
axis([0 N*1.1 0 1.1]);

% Textbox --
dim = [.6 .5 1.0 0.4];
box_string_format = ...
    "Phi: 0.%d\n M: %d\n N: %d\n Opinions: %d\n Runs: %d\n Mean timesteps: %d";
box_string = sprintf(box_string_format, ...
    uint32(phi*1000),M,N,G,no_of_runs,uint32(average_iterations));
annotation('textbox',dim,'String',box_string,'FitBoxToText','on');
if ~isempty(Fake)
    title('Results with Fake News')
else
    title('Results without Fake News')
% -----

hold on;

plot(final_bins(1:no_of_bins),s_averaged_binned,'o');
averaged_binned_cluster_sizes=ClusterSizes;
end
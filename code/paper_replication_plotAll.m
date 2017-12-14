% Plot with abort criterion if true
abort = false;

close all
if abort
    plot_averaged_results(ClusterSizes_1,N,G,phi_1,...
        average_iterations_1,no_of_runs);
    
    plot_averaged_results(ClusterSizes_2,N,G,phi_2,...
        average_iterations_2,no_of_runs);
    
    plot_averaged_results(ClusterSizes_3,N,G,phi_3,...
        average_iterations_3,no_of_runs);

else
    plot_averaged_results(ClusterSizes_1,N,G,phi_1,...
        duration,no_of_runs);
    
    plot_averaged_results(ClusterSizes_2,N,G,phi_2,...
        duration,no_of_runs);
    
    plot_averaged_results(ClusterSizes_3,N,G,phi_3,...
        duration,no_of_runs);
end
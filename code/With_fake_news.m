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

%[ClusterSizes,average_iterations,Connec_matrix,Opinion_matrix] = ...
%    extended_model_v2(N,M,k,G,phi,duration,abort_threshold,no_of_runs,Fake);
[ClusterSizes,average_iterations] = ...
    extended_model_v2(N,M,k,G,phi,duration,abort_threshold,no_of_runs,Fake);
Fake_without.add = 0;
[ClusterSizes_no_fake_news,average_iterations_no_fake_news] = ...
    opinion_change_model(N,M,k,G,phi,no_of_runs,duration,abort_threshold);


if ( withGraphics )
    
    for t =1:no_of_runs
        mask = ones(N,no_of_runs);
        mask(:,t:end) = 0;
        bla = Opinion_matrix.*mask;
     
        clf; 
        subplot(121);hold on; imagesc(bla);
        xlabel('iteration time');
        ylabel('People');
        title('Opinion\_Change')
        text(0.8*no_of_runs,N-100,['G(1) = ',num2str(ClusterSizes(1,t))],'fontsize',14,'color','r');
        text(0.8*no_of_runs,N-300,['G(2) = ',num2str(ClusterSizes(2,t))],'fontsize',14,'color','r');        
        axis([1 no_of_runs 0 N])


        
        subplot(122);hold on;imagesc(Connec_matrix(:,:,t));
        axis([0 N 0 N]);
        set(gcf,'position',[-58 387 1132 500]);
        
        
        A(t) = getframe();
        pause(.1)
    end
    
    kermach = VideoWriter('Fake_news.avi');
    open(kermach)
    writeVideo(kermach,A)
    close(kermach)
    
else
    
    plot_averaged_results(ClusterSizes,N,M,G,phi,duration, ...
        average_iterations,no_of_runs,Fake);
    plot_averaged_results(ClusterSizes_no_fake_news,N,M,G,phi,duration, ...
        average_iterations_no_fake_news,no_of_runs,Fake_without);

end

% figure;
% hold on;f1 = plot([1:no_of_runs],ClusterSizes(1,:));
% hold on;f2 = plot([1:no_of_runs],ClusterSizes(2,:));
% 
% hold on;f3 = plot([1:no_of_runs],ClusterSizes_no_fake_news(1,:),'-');
% hold on;f4 = plot([1:no_of_runs],ClusterSizes_no_fake_news(2,:),'-');
% grid on;
% 
% set(f1,'MarkerSize',10);
% set(f2,'MarkerSize',10);







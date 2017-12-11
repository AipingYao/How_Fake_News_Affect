%------------Initialise model
close all;
clear all;

%------------- CONFIG ------------------------
M=10000; % no of connections
N=3200; % no of people
k=2*M/N; % avg degree
gamma=20; % N/G
G=N/gamma; % number of opinion
G = 2;
phi=0.9; % transition probability
withGraphics = 1;

Fake.add = 1; % 1 for fake news included, 0 for initial model
Fake.target = 1;    % target opinion fake news want to be;
Fake.budget = 10000;

Fake.strategy = 2;
Fake.medium = {'CNN','20mins','both'};
Fake.beta = [0.3,0.1];           % fake news affect possibility;
Fake.no = [1,0];               % number of fake news
Fake.affect_person = [1,0,0]; 



no_of_runs= 200;% amount of times to run simulation
duration= 5; % number of iterations with each run
%%
%------------- ENDCONFIG -----------------------
[ClusterSizes,Opinion_matrix] = extend_model_v2(N,M,k,G,phi,duration,no_of_runs,Fake);


ClusterSizes_no_fake_news = opinion_change_model(N,M,k,G,phi,no_of_runs,duration);

%%
if ( withGraphics )
    
    for t =1:no_of_runs
        mask = ones(N,no_of_runs);
        mask(:,t:end) = 0;
        bla = Opinion_matrix.*mask;
     
        clf; 
        hold on; imagesc(bla);
        xlabel('iteration time','fontsize',15);
        ylabel('People','fontsize',15);
        title('Opinion\_Distribution','fontsize',15)
        text(0.8*no_of_runs,N-100,['De = ',num2str(ClusterSizes(1,t))],'fontsize',14,'color','r');
        text(0.8*no_of_runs,N-300,['Re = ',num2str(ClusterSizes(2,t))],'fontsize',14,'color','r');        
        axis([1 no_of_runs 0 N])


        
%         subplot(122);hold on;imagesc(Connec_matrix(:,:,t));
%         axis([0 N 0 N]);
%         set(gcf,'position',[-58 387 1132 500]);
        
        
        A(t) = getframe();
        pause(.1)
    end
    
    kermach = VideoWriter(['stragety_',num2str(Fake.strategy),'_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1)),'.avi']);
    open(kermach)
    writeVideo(kermach,A)
    close(kermach)
    
else
    
    plot_averaged_results(ClusterSizes,N,M,G,phi,duration,no_of_runs,Fake);

end

figure(2);
subplot(211)
hold on;f1 = plot([1:no_of_runs],ClusterSizes(1,:),'color','r');
hold on;f2 = plot([1:no_of_runs],ClusterSizes(2,:),'color','b');


xlabel('iteration time','fontsize',15);
ylabel('People','fontsize',15);
axis([0 no_of_runs 0 N])
grid on;
legend('G1\_with\_Fake','G2\_with\_Fake');
title('Opinion\_Distribution','fontsize',15)

dim = [.2 .5 1.0 0.4];
box_string_format = ...
    'Strategy: %s\n M: %s\n N: %s\n Budget: %s\n Beta: %s\n';
box_string = sprintf(box_string_format, ...
    num2str(Fake.strategy),num2str(M),num2str(N),num2str(Fake.budget),num2str(Fake.beta(1)));
annotation('textbox',dim,'String',box_string,'FitBoxToText','on');

subplot(212)
hold on;f3 = plot([1:no_of_runs],ClusterSizes_no_fake_news(1,:),'-','color','r');
hold on;f4 = plot([1:no_of_runs],ClusterSizes_no_fake_news(2,:),'-','color','b');
grid on;
axis([0 no_of_runs 0 N])

xlabel('iteration time','fontsize',15);
ylabel('People','fontsize',15);

legend('G1\_no\_Fake','G2\_no\_Fake');

saveas(figure(2),['stragety_',num2str(Fake.strategy),'_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1)),'.png'])
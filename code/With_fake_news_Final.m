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

Fake.strategy = 1;
Fake.medium = {'CNN','20mins','both'};
Fake.beta = [0.8,0.1];           % fake news affect possibility;
Fake.no = [1,0];               % number of fake news
Fake.affect_person = [1,0,0]; 



no_of_runs= 200;% 
duration= 5; % 
%%
%------------- ENDCONFIG -----------------------
[ClusterSizes,Opinion_matrix] = extend_model_v2(N,M,k,G,phi,duration,no_of_runs,Fake);   
clusterSizes = ClusterSizes./N.*100;

Fake.strategy = 2;
[ClusterSizes_2,Opinion_matrix_2] = extend_model_v2(N,M,k,G,phi,duration,no_of_runs,Fake);
clusterSizes_2 = ClusterSizes_2./N.*100;

Fake.add = 0;
ClusterSizes_no_fake_news = extend_model_v2(N,M,k,G,phi,duration,no_of_runs,Fake);
clusterSizes_no_fake_news = ClusterSizes_no_fake_news./N.*100;



%%
if ( withGraphics )
    
    for t =1:no_of_runs
        mask = ones(N,no_of_runs);
        mask(:,t:end) = 0;
        bla = Opinion_matrix.*mask;
        
        clf;
        hold on;
        axis([1 no_of_runs 0 N]);
        ax = gca;
        ax.XTickLabel = {'100','200','300','400','500','600','700','800','900','1000'}
        imagesc(bla);
        xlabel('iteration time:','fontsize',15);
        ylabel('People','fontsize',15);
        title('Opinion\_Distribution','fontsize',15)
        text(0.8*no_of_runs,0.9*N,['G1 = ',num2str(ClusterSizes(1,t))],'fontsize',14,'color','r');
        text(0.8*no_of_runs,0.8*N,['G2 = ',num2str(ClusterSizes(2,t))],'fontsize',14,'color','r');
        
        
        pause(.1)
        mov(t) = getframe(gcf);
        im = frame2im(mov(t));
        [imind,cm] = rgb2ind(im,256);
        if t == 1
            imwrite(imind,cm,['stragety_',num2str(Fake.strategy),'_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1))],'gif','Loopcount',inf);
        else 
            imwrite(imind,cm,['stragety_',num2str(Fake.strategy),'_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1))],'gif','WriteMode','append');
        end
    end
    
%     kermach = VideoWriter(['stragety_',num2str(Fake.strategy),'_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1)),'.avi']);
%     open(kermach)
%     writeVideo(kermach,A)
%     close(kermach)
%     
    
end


figure(2);
subplot(211)
hold on;f1 = plot([1:no_of_runs],clusterSizes(1,:),'color','r');
hold on;f2 = plot([1:no_of_runs],clusterSizes(2,:),'color','b');

hold on;f3 = plot([1:no_of_runs],clusterSizes_2(1,:),'-o','color','r');
hold on;f4 = plot([1:no_of_runs],clusterSizes_2(2,:),'-o','color','b');

set(f3,'markersize',3);
set(f4,'markersize',3);

xlabel('iteration time','fontsize',15);
ylabel('Percent of Population (%)','fontsize',15);
axis([0 no_of_runs 0 100])
ax = gca;
ax.XTickLabel = {'0','100','200','300','400','500','600','700','800','900','1000'}

grid on;
legend('G1\_strategy1','G2\_strategy1','G1\_strategy2','G2\_strategy2','Location','northoutside','Orientation','horizental')
title('With Fake News','fontsize',15)



subplot(212)
title('Without Fake News','fontsize',15);
hold on;f5 = plot([1:no_of_runs],clusterSizes_no_fake_news(1,:),'-','color','r');
hold on;f6 = plot([1:no_of_runs],clusterSizes_no_fake_news(2,:),'-','color','b');
grid on;
axis([0 no_of_runs 0 100])
ax = gca;
ax.XTickLabel = {'0','100','200','300','400','500','600','700','800','900','1000'}


xlabel('iteration time','fontsize',15);
ylabel('Percent of Population (%)','fontsize',15);

legend('G1','G2');
set(gcf,'position',[635 215 603 486]);

saveas(figure(2),['_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1)),'_phi_',num2str(phi),'_2.fig'])
saveas(figure(2),['_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1)),'_phi_',num2str(phi),'_2.png'])
save(['_M_',num2str(M),'_N_',num2str(N),'_Bud_',num2str(Fake.budget),'_Beta_',num2str(Fake.beta(1)),'_phi_',num2str(phi),'.mat'],'ClusterSizes','Opinion_matrix','Opinion_matrix_2','ClusterSizes_2','ClusterSizes_no_fake_news')


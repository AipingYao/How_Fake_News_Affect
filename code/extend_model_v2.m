function [ClusterSizes,Opinion_matrix] = extended_model(N,M,k,G,phi,duration,no_of_runs,Fake)

% set up opinions and connectivity matrix

COST = 0;   %Total connection cost;
[Individuals,Connections]=initialize(N,M,G);
Opinion_matrix=zeros(N,no_of_runs);
%%
for i=1:no_of_runs
    
    run = 'Run %d of %d\n';
    run_str = sprintf(run, i, no_of_runs);
    fprintf(run_str)
    Opinion_matrix(:,i) = Individuals;
    %Connec_matrix(:,:,i) = Connections;
    
    for j = 1:duration
        

        
        cost_1 = 0;  % strategy 1 cost for each iteration;
        cost_2 = 0;  % strategy 2 cost for each iteration;
        person=randi(N);
        op=Individuals(person);
        Friends=find(Connections(person,:)==1); % person's friends (indices)
        no_of_friends=size(Friends,2);
        if no_of_friends==0 % Skip if no friends
            continue
        else
            number=rand();
            
            
            
            %%% ------ ADD FAKE NEWS ---------------- %%%
            if COST <= Fake.budget       
                if Fake.add~=0
                    for ind = 1%:length(Fake.medium)          %affect different reader groups of the medium
                        for fk = 1%:Fake.affect_person(ind)    % person in each groups
                            
                            opp = find(Individuals ~= Fake.target);  %find opponents who have opposite opinion
                            if opp ~= 0
                                opp_connection = zeros(size(opp));   
                                for ind_opp =1:length(opp)
                                    opp_connection(ind_opp) = length(find(Connections(opp(ind_opp),:) == 1));  %find the connection numbers of each opponent;
                                end
                                connect_number = unique(opp_connection);  % find the possible connection numbers
                                Star_ind = find(opp_connection == max(opp_connection(:)));  %find the super star whos we want to influence;
                                Star = opp(Star_ind(1));
                                connect_max = max(opp_connection(:));  %the connection number of the Super star
                                
                                
                                %--- Target one people (Sper Star)------------ %
                                if Fake.strategy == 1
                                    person_affect = Star;
                                    person_affect_op = Individuals(person_affect);
                                    Individuals(person_affect) = fake_news_effect(Individuals,person,person_affect_op,Fake,ind);
                                    cost_1 = cost_1+ connect_max;

                                else
                                    
                                    %---Target several people ---%
                                    while cost_2 < connect_max
                                        ind_bla = find(abs(connect_number -(connect_max-cost_2)) == min(abs(connect_number -(connect_max-cost_2))));
                                        if ind_bla <1
                                            cost_2 = connect_max;
                                        else
                                        bla = randi(ind_bla);
                                        average_connection = connect_number(bla);  %choose random connection number  which is less than (connect_max-cost_2) ;
                                        cost_2 = cost_2 + average_connection;         
                                        opp_connection_small = find(opp_connection == average_connection);  %find people who has the selected connection number
                                        opp_connection_ind = randi(length(opp_connection_small)); %random choose one people from the group;
                                        person_affect = opp(opp_connection_small(opp_connection_ind));
                                        person_affect_op = Individuals(person_affect);
                                        Individuals(person_affect) = fake_news_effect(Individuals,person,person_affect_op,Fake,ind);
                                        end
                                    end

                                end
                                
                            else
                                continue
                                
                                
                            end
                            
                        end
                    end
                end
                COST = COST+cost_1+cost_2;
            end
            
            
            %%%-----------------------------------------------%%%
            
            if number<phi % move edge
                % remove random friend
                goodbye_friend=randi(no_of_friends);
                Connections(person,Friends(goodbye_friend))=0;
                Connections(Friends(goodbye_friend),person)=0;
                % find people with same opinion and set connection
                % indices of people having same opinion
                same_opinion_individuals = find(Individuals==op);
                % Remove person itself from it
                same_opinion_individuals = ...
                    same_opinion_individuals(same_opinion_individuals~=person);
                % Drop friends with existing connections
                same_opinion_individuals = ...
                    setdiff(same_opinion_individuals,Friends);
                
                if isempty(same_opinion_individuals)
                    continue
                end
                new_friend_number=randi(size(same_opinion_individuals,1));
                new_friend=same_opinion_individuals(new_friend_number,1);
                Connections(person,new_friend)=1;
                Connections(new_friend,person)=1;
            else % change opinion
                opinion_friend=randi(no_of_friends);
                Individuals(person)=Individuals(Friends(opinion_friend));
            end
        end
        
        
    end
    
    for g=1:G
        ClusterSizes(g,i)=size(find(Individuals==g),1);
    end
    
end



function [ClusterSizes,average_iterations,Connec_matrix,Opinion_matrix] = ...
    extended_model_with_ext_init(N,M,k,G,phi,IndividualsInit,ConnectionsInit, ...
    abort_threshold,no_of_runs,Fake)

% set up opinions and connectivity matrix

COST = 0;   %Total connection cost;

ClusterSizes = zeros(G,no_of_runs);
Iterations = zeros(1,no_of_runs);

% This is giving me an error because it is too large
% Connec_matrix=zeros(N,N,no_of_runs);
% Opinion_matrix=zeros(N,no_of_runs);
%%
for i=1:no_of_runs
 
    run = 'Run %d of %d\n';
    run_str = sprintf(run, i, no_of_runs);
    fprintf(run_str)
    
    abort = 0;
    count = 0;
    Individuals = IndividualsInit;
    Connections = ConnectionsInit;
    IndividualsBefore = zeros(size(Individuals));
    % This is giving me an error because it is too large
    %Opinion_matrix(:,i) = Individuals;
    %Connec_matrix(:,:,i) = Connections;
    
    %for j = 1:duration
    while abort<abort_threshold
        
        count = count+1;
        % Storing connections and opinion array at every iteration
        % Timeconsuming?!
        % Connec_matrix(:,:,i) = Connections;
        
        % Store current state of opinions to check later
        IndividualsBefore = Individuals;
        
        cost = 0;  % strategy 2 cost for each iteration;
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
                                
                                
                                %--- Target one people (Super Star)------------ %
                                if Fake.strategy == 1
                                    person_affect = Star;
                                    person_affect_op = Individuals(person_affect);
                                    Individuals(person_affect) = fake_news_effect(Individuals,person,person_affect_op,Fake,ind);
                                    COST = COST+ connect_max;
                                else
                                    
                                    %---Target several people ---%
                                    while cost <= connect_max
                                        bla = randi(round(length(connect_number)./2));
                                        average_connection = connect_number(bla);  %choose a connection number  which is less than half of the super star;
                                        cost = cost + average_connection;         
                                        opp_connection_small = find(opp_connection == average_connection);  %find people who has the selected connection number
                                        opp_connection_ind = randi(length(opp_connection_small)); %random choose one people from the group;
                                        person_affect = opp(opp_connection_small(opp_connection_ind));
                                        person_affect_op = Individuals(person_affect);
                                        Individuals(person_affect) = fake_news_effect(Individuals,person,person_affect_op,Fake,ind);
                                    end
                                    COST = COST + cost;
                                end
                                
                            else
                                continue
                            end
                            
                        end
                    end
                end
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
                
                % Abort criterion
                %  -> When connection set to person with different opinion
                % reset abort counter
                if (Individuals(new_friend)==Individuals(person))
                    abort = abort+1;
                else
                    abort = 0;
                end
                
            else % change opinion
                opinion_friend=randi(no_of_friends);
                Individuals(person)=Individuals(Friends(opinion_friend));
                
                % Abort criterion
                % -> When the opinions have changed set counter back to 0
                if isequal(Individuals,IndividualsBefore)
                    abort = abort+1;
                else
                    abort = 0;
                end
                
            end
        end
    end
    
    iterations = "Number of fake news iterations was %d\n";
    iterations_str = sprintf(iterations, count);
    fprintf(iterations_str)
    
    for j=1:G
        ClusterSizes(j,i)=size(find(Individuals==j),1);
    end
    Iterations(i) = count;
end
average_iterations = mean(Iterations);

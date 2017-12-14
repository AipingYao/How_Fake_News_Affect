function [ClusterSizes,average_iterations] = ...
    opinion_change_model(N,M,G,phi,no_of_runs,abort_threshold)
% OPINION_CHANGE_MODEL is the implementation of Holme's model. Returns a
% matrix ClusterSizes (G * no_of_runs) containing all cluster sizes for
% each run in a column. average_iterations is the average number of
% iterations needed to fulfill the abort criterion

% N is the number of individuals in the model
% M is the total number of connections in the network
% G is the number of opinions
% phi the transition probability used in the runs
% no_of_runs is the number of times the model has run
% abort_threshold specifies how many times the cluster sizes have to stay
% the same before stopping iterating

% --------------------------------------------------------

% set up opinions and connectivity matrix
[IndividualsInit,ConnectionsInit] = initialize(N,M,G);

ClusterSizes = zeros(G,no_of_runs);
Iterations = zeros(1,no_of_runs);

for i=1:no_of_runs

    iterations = "Run %d of %d\n";
    iterations_str = sprintf(iterations, i, no_of_runs);
    fprintf(iterations_str)
    
    Individuals = IndividualsInit;
    Connections = ConnectionsInit;
    IndividualsBefore = zeros(size(Individuals));
    abort = 0;
    count = 0;
    
    while abort<abort_threshold
    %for j=1:duration
        count = count+1;
        
        % Store current state of opinions to check later
        IndividualsBefore = Individuals;
        
        person=randi(N);
        opinion=Individuals(person);
        Friends=find(Connections(person,:)==1); % person's friends (indices)
        no_of_friends=size(Friends,2);
        if no_of_friends==0 % Skip if no friends
            continue
        else
            number=rand();
            
            % MOVE EDGE
            
            if number<phi
                % remove random friend
                goodbye_friend=randi(no_of_friends);
                Connections(person,Friends(goodbye_friend))=0;
                Connections(Friends(goodbye_friend),person)=0;
                
                % find people with same opinion and set connection
                % indices of people having same opinion
                same_opinion_individuals = find(Individuals==opinion);
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
            
            % CHANGE OPINION
            
            else
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
    
    iterations = "Number of iterations was %d\n";
    iterations_str = sprintf(iterations, count);
    fprintf(iterations_str)
    
    % Store cluster sizes of current run j for evaluation
    for g=1:G
        ClusterSizes(g,i)=size(find(Individuals==g),1);
    end
    Iterations(i) = count;
end
average_iterations = mean(Iterations);
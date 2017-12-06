function [ClusterSizes,Connec_matrix,Opinion_matrix] = opinion_change_model(N,M,k,G,phi,no_of_runs,duration)

% set up opinions and connectivity matrix
[IndividualsInit,ConnectionsInit]=initialize(N,M,G);

ClusterSizes=zeros(G,no_of_runs);
%Connec_matrix=zeros(N,N,duration);
%Opinion_matrix=zeros(N,duration);

for i=1:no_of_runs

    iterations = "Run %d of %d\n";
    iterations_str = sprintf(iterations, i, no_of_runs);
    fprintf(iterations_str)
    
    Individuals = IndividualsInit;
    Connections = ConnectionsInit;
    IndividualsBefore = zeros(size(Individuals));
    ConnectionsBefore = zeros(size(Connections));
    abort = 0;
    count = 0;
    
    while abort<200
    %for j=1:duration
        count = count+1;
        
        % Store current state of opinions to check later
        ConnectionsBefore = Connections;
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
            
            % CHANGE OPINION
            
            else
                opinion_friend=randi(no_of_friends);
                Individuals(person)=Individuals(Friends(opinion_friend));
                
                % Abort criterion
                if isequal(Individuals,IndividualsBefore)
                    abort = abort+1;
                else
                    abort = 0;
                end
                
            end
            
%             % Abort criterion
%             if (isequal(Individuals,IndividualsBefore) && ...
%                     isequal(Connections,ConnectionsBefore))
%                 abort = abort+1;
%             else
%                 abort = 0;
%             end
        end
    end
    
    iterations = "Number of iterations was %d\n";
    iterations_str = sprintf(iterations, count);
    fprintf(iterations_str)
    
    % Store cluster sizes of current run j for evaluation
    for g=1:G
        ClusterSizes(g,i)=size(find(Individuals==g),1);
    end
end
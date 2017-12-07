function [ClusterSizes,Connec_matrix,Opinion_matrix] = extended_model(N,M,k,G,phi,duration,no_of_runs,Fake)

% Set up initial opinions and connectivity matrix
[IndividualsInit,ConnectionsInit]=initialize(N,M,G);

ClusterSizes=zeros(G,no_of_runs);
Connec_matrix=zeros(N,N,no_of_runs);

Opinion_matrix=zeros(N,no_of_runs);
%%
for i=1:no_of_runs
    
    Individuals = IndividualsInit;
    Connections = ConnectionsInit;
    run = "Run %d of %d\n";
    run_str = sprintf(run, i, no_of_runs);
    fprintf(run_str)
    Opinion_matrix(:,i) = Individuals;
    Connec_matrix(:,:,i) = Connections;

    for j = 1:duration

        % Storing connections and opinion array at every iteration
        % Timeconsuming?!   
        % Connec_matrix(:,:,i) = Connections;


        person=randi(N);
        op=Individuals(person);
        Friends=find(Connections(person,:)==1); % person's friends (indices)
        no_of_friends=size(Friends,2);
        if no_of_friends==0 % Skip if no friends
            continue
        else
            number=rand();


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
    
    %%% ------ ADD FAKE NEWS TO several person ---------------- %%%
    if Fake.add~=0
        for ind = 1:length(Fake.medium)          %affect different reader groups of the medium
            for fk = 1:Fake.affect_person(ind)    % person in each groups
                person_affect = randi(N);
                person_affect_op = Individuals(person_affect);
                Individuals(person_affect) = fake_news_effect(Individuals,person,person_affect_op,Fake,ind);
            end
        end
        
    end

    for j=1:G
        ClusterSizes(j,i)=size(find(Individuals==j),1);
    end
end




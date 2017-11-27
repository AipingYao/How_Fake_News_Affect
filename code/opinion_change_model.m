function ClusterSizes = opinion_change_model(N,M,k,G,phi,no_of_runs,duration)

% opinion array
Individuals=randi(G,N,1);

% connectivity matrix (NxN)
% choose random position and set to 1 representing a connection
% do M times
Connections=zeros(N,N);
for i=1:M
    x=randi(N);
    y=randi(N);
    % fill both entries to represent full connectivity
    Connections(x,y)=1;
    Connections(y,x)=1;
end

% I assign 2 times M entries in the connection matrix
% Except for when the value is in the diagonal, I set it twice to the same
% index, so subtract it
double_connections=(2*M-sum(sum(Connections))-sum(diag(Connections)))/2;

init = "Initialisation complete: %d double connections\n";
init_str = sprintf(init, double_connections);
fprintf(init_str)

ClusterSizes=zeros(G,no_of_runs);

for j=1:no_of_runs
    %------------- Iteration
    %disp("Run " + j + " of " + no_of_runs + " runs")
    run = "Run %d of %d\n";
    run_str = sprintf(run, j, no_of_runs);
    fprintf(run_str)
    for i=1:duration
        person=randi(N);
        op=Individuals(person);
        Friends=find(Connections(person,:)==1); % person's friends (indices)
        no_of_friends=size(Friends,2);
        if no_of_friends==0 % Skip if no friends
            continue
        else
            number=rand();
            if number<phi % move edge
                % remove random friend
                conn_before = sum(sum(Connections));
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
    for i=1:G
        ClusterSizes(i,j)=size(find(Individuals==i),1);
    end
end
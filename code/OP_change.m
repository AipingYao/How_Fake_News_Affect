function [ClusterSizes,Connec_matrix,Opinion_matrix] = OP_change(N,M,k,G,phi,duration,no_of_runs,Fake)

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
    
    if x==y
        Connections(x,y)=0;
    end
end


Connec_matrix = zeros(N,N);


ClusterSizes=zeros(G);
%%
if Fake.add == 0
    for i = 1:duration
        
       % Connec_matrix(:,:,i) = Connections;
        Opinion_matrix(:,i) = Individuals;

        for j=1:no_of_runs
            person=randi(N);
            op=Individuals(person);
            Friends=find(Connections(person,:)==1); % person's friends (indices)
            no_of_friends=size(Friends,2);
            if no_of_friends==0 % Skip if no friends
                continue
            else
                number=rand();
                if number<phi % move edge
                    % remove random friend  %comments:why do we need goodbye friend? where did you move the friends to?
                    goodbye_friend=randi(no_of_friends);
                    Connections(person,Friends(goodbye_friend))=0;
                    Connections(Friends(goodbye_friend),person)=0;
                    % find people with same opinion and set connection
                    SameOpinionFriends=find(Individuals==op); % indices of friends
                    new_friend_number=randi(size(SameOpinionFriends,2));
                    new_friend=SameOpinionFriends(new_friend_number,1);
                    Connections(person,new_friend)=1;
                    Connections(new_friend,person)=1;
                else % change opinion
                    opinion_friend=randi(no_of_friends);
                    Individuals(person)=Individuals(Friends(opinion_friend));
                end
            end
        end
            

        
    end
    for i=1:G
        ClusterSizes(i,j)=size(find(Individuals==i),1);
    end

else
    
    for i=1:duration
        
       % Connec_matrix(:,:,i) = Connections;
        Opinion_matrix(:,i) = Individuals;
        
        for j = 1:no_of_runs
            person=randi(N);
            op=Individuals(person);
            Friends=find(Connections(person,:)==1); % person's friends (indices)
            no_of_friends=size(Friends,2);
            if no_of_friends==0 % Skip if no friends
                continue
            else
                number=rand();
                %%% ------ ADD FAKE NEWS TO several person ---------------- %%%
                for ind = 1:length(Fake.medium)          %affect different reader groups of the medium
                    for fk = 1:Fake.affect_person(ind)    % person in each groups
                        person_affect = randi(N);
                        person_affect_op = Individuals(person_affect);
                        Individuals(person_affect) = fake_news_effect(Individuals,person,person_affect_op,Fake,ind);
                    end
                end
                
                %%%-----------------------------------------------%%%
                
                if number<phi % move edge
                    % remove random friend
                    goodbye_friend=randi(no_of_friends);
                    Connections(person,Friends(goodbye_friend))=0;
                    Connections(Friends(goodbye_friend),person)=0;
                    % find people with same opinion and set connection
                    SameOpinionFriends=find(Individuals==op); % indices of friends
                    new_friend_number=randi(size(SameOpinionFriends,2));
                    new_friend=SameOpinionFriends(new_friend_number,1);
                    Connections(person,new_friend)=1;
                    Connections(new_friend,person)=1;
                else % change opinion
                    opinion_friend=randi(no_of_friends);
                    Individuals(person)=Individuals(Friends(opinion_friend));
                end
            end
        end
        
        
    end
    for i=1:G
        ClusterSizes(i)=size(find(Individuals==i),1);
    end
end




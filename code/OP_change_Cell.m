function [ClusterSizes, Connections] = OP_change_Cell(N,M,G,phi,duration,Fake)

% opinion array
Individuals=randi(G,N,2);
target = Fake.target;
fake_news = Fake.no;
beta = Fake.beta;

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
disp("Initialisation complete. " + double_connections + ...
    " double connection(s).")


ClusterSizes=zeros(G,duration);

if fake_news == 0
    
    for d = double(1:duration)
        person=randi(N);
        op=Individuals(person);
        
        number=rand();
        if number<phi % move edge
            
            %people have same opinion creat connection
            SameOpinionFriends=find(Individuals==op); % indices of friends
            new_friend_number=randi(size(SameOpinionFriends,2));
            new_friend=SameOpinionFriends(new_friend_number,1);
            Connections(person,new_friend)=1;
            Connections(new_friend,person)=1;
            
        else % change opinion
            Friends=find(Connections(person,:)==1); % person's friends (indices)
            no_of_friends=size(Friends,2);
            
            opinion_friend=randi(no_of_friends);
            Individuals(person)=Individuals(Friends(opinion_friend));
        end
        for g =1:G
            ClusterSizes(g,d)=size(find(Individuals==g),1);
        end
    end
    
    
    
else
    
    for d =1:duration
        person=randi(N);
        op=Individuals(person);
        op = fake_news_effect(Individuals,person,op,target,fake_news,beta);
        
        number=rand();
        if number<phi % move edge
            
            %people have same opinion creat connection
            SameOpinionFriends=find(Individuals==op); % indices of friends
            new_friend_number=randi(size(SameOpinionFriends,2));
            new_friend=SameOpinionFriends(new_friend_number,1);
            Connections(person,new_friend)=1;
            Connections(new_friend,person)=1;
            
        else % change opinion
            Friends=find(Connections(person,:)==1); % person's friends (indices)
            no_of_friends=size(Friends,2);
            
            opinion_friend=randi(no_of_friends);
            Individuals(person)=Individuals(Friends(opinion_friend));
        end
        for g = 1:G
            ClusterSizes(g,d)=size(find(Individuals==g),1);
        end
    end
    
    
end




end
function [Individuals,Connections] = initialize(N,M,G)
% INITIALIZE initializes model, i.e. assigns opinions to people and sets
% initial connections among the individuals

% N number of individuals/nodes present in the social network
% M number of connections between the N nodes in the network
%    (assigned at random, double and self connections allowed, as in Holme)
% G number of opinions present
% -----------------------------------------------------------------------

% opinion array
Individuals_=randi(G,N,1);

% connectivity matrix (NxN)
% choose random position and set to 1 representing a connection
% do M times
Connections_=zeros(N,N);
for i=1:M
    x=randi(N);
    y=randi(N);
    % fill both entries to represent full connectivity
    Connections_(x,y)=1;
    Connections_(y,x)=1;
% Not needed. They allow for self-connections
%     if x==y
%         Connections(x,y)=0;
%     end
end

% I assign 2 times M entries in the connection matrix
% Except for when the value is in the diagonal, I set it twice to the same
% index, so subtract it
double_connections=(2*M-sum(sum(Connections_))-sum(diag(Connections_)))/2;
init = "Initialisation complete: %d double connections\n";
init_str = sprintf(init, double_connections);
fprintf(init_str)

Individuals = Individuals_;
Connections = Connections_;
end


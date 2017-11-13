
%% define fake news effect function %%
% target is the target opinion;
% fake_news is the No. of fake news;

%%

function op = fake_news_effect(Individuals,person,op,target,fake_news,beta)
if op == target
    Individuals(person) = op;
else
    infpro = 1-(1-beta).^(fake_news);
    if rand < infpro
        Individuals(person) = target;   %% change the opinion to the target one;
        op = Individuals(person);
    end
end

%% define fake news effect function %%
% target is the target opinion;
% fake_news is the No. of fake news;

%%

function op = fake_news_effect(Individuals,person,op,Fake,ind)

if op == Fake.target
    Individuals(person) = op;
else
    if ind == 1       %if the reader is CNN
        infpro = 1-(1-Fake.beta(1)).^(Fake.no(1));
    elseif ind == 2   %if the reader is 20mins
        infpro = 1-(1-Fake.beta(2)).^(Fake.no(2));
    elseif ind == 3   %if the reader is both
        infpro = 1-(1-Fake.beta(1)).^Fake.no(1)*(1-Fake.beta(2)).^Fake.no(2);
    end
    %infpro = 1-(1-beta).^(fake_news);
    if rand < infpro
        Individuals(person) = Fake.target;   %% change the opinion to the target one;
        op = Individuals(person);
    end
end
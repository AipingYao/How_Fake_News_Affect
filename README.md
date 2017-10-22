# MATLAB Fall 2017 – Research Plan


> * Group Name: Make America Great Again
> * Group participants names: Yannick Bertschy, Mario Blatter, Guido Gandus, Aiping Yao
> * Project Title: Investigating the Influence of Fake News on the Opinion Formation

## General Introduction

In light of recent discussions about the importance of so-called Fake News story having made appearance on social networks such as facebook, questions about their influence have been brought up.
The undoubtedly most popular example are the US elections in which this problem was controversely discussed.

## The Model
The model presented in this research plan bases largely on the one presented in the paper from P.Holme et. al [1], but with the additional implementation of an external influence.
It figures N individuals as vertices. Each of these vertices (i) can have an arbitrary number of pairwise connections k(i) to another vertex representing friendship/acquaintance.
What's more, each individual holds one out of G possible opinions on a topic (g(i)). For an initial example we intend to use the 2016 US elections and thus G = {Hillary Clinton, Donald Trump}. In a second step we will extend this to higher number of possible opinions/candidates.
As the starting conditions for the model, we distribute the total number of connections M at random and assign each vertex an opinion in G.
The dynamic of the system follows two rules:
1. Pick a vertex i at random. With the probability /phi a random connection to a vertex of a different opinion is changed to a random vertex of its same opinion g(i).
2. With probability 1-\phi the vertex i adopts the (different) opinion of one of its neighbouring vertices.

In our model we extend the dynamics in the following way:
3. At each iteration we are able to change the opinion of L random vertices to a previously defined one with a certain probability \psi. This implementation lets us introduce an external influence corresponding to Fake News impact, favoring one particular candidate.
Hence, the variable L is meant to represent the influence of media outlets on top of ideas spreading among acquaintances, modeling more accurately the increased internet-based media reality, which is not accounted for in the existing paper.

We will assume the number of individuals N and their connections M, as well as the number of possible opinions G are fixed values.
Therefore, the varying parameters in this model are L, \psi and \phi. The latter is the same as in the original work of [1] in order to be able to compare our results with theirs.
For obtaining rough but realistic estimates on L and \psi we will partly rely on a Stanford study [2].

## Fundamental Questions

The goal of this project is to find out the impact of Fake News on opinion formation.
In particular, we want to investigate the number of individuals L in a system which need to be influenced to a significantly shift of the initial distribution of opinions in a society, which can also be interpreted as the cluster sizes. (Referred to as "consensus" state, as denoted in [1].
Additionally, it will be interesting to find out how the effect changes with varying probabilities \psi, i.e. how convincing these Fake News inputs are.

## Expected Results

In the previous work conducted by [1], with time going to infinity, clusters will form with each cluster having only members of a certain opinion. 
In our adapted model we expect that with large L and/or \psi one of these clusters will end up being substantially larger in size than the others. This corresponds to saying that the internet has the power to influence the formation of opinions.
Additionally, we expect that the system will reach consensus faster, as we have introduced an additional mechanism to change the opinions of individuals.

## References 

[1] Holme, Petter; Newman, M.E.J. (2006): Nonequilibrium phase transition in the coevolution of networks and opinions.
[2] Hunt Allcott and Matthew Gentzkow, Social Media and Fake News in the 2016 Election, Journal of Economic Perspectives—Volume 31, Number 2—Spring 2017—Pages 211–236

## Research Methods

Agent-Based Model

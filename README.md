# MATLAB Fall 2017 – Research Plan


> * Group Name: Make America Great Again
> * Group participants names: Yannick Bertschy, Mario Blatter, Guido Gandus, Aiping Yao
> * Project Title: Investigating the Influence of Fake News on the Opinion Formation

## General Introduction

In light of recent discussions about the importance of so-called Fake News story having made appearance on social networks such as facebook, questions about their influence have been brought up.
The undoubtedly most popular example are the US elections in which this problem was controversely discussed.

## The Model
The model presented in this research plan moves from the one described in the paper from P.Holme et. al [1], but with the additional implementation of an external influence. The model in [] figures N 
people as vertices and each of these vertices (i) can have an arbitrary number of pairwise connections k(i) representing friendships. Each individual holds 1 out of G possible opinions on a specific current 
topic. As the starting conditions for the model, the authors distribute the M total number of connections k(i) at random and assign a small range of possible opinions G. Further, the number of people 
N and the connections M are fixed values. The dynamic of the system follows two rules:
1. Pick a vertex i at random. With the probability /phi a random connection to a vertex of a different opinion is changed to a random vertex of its same opinion g(i).
2. With probability 1-\phi the vertex i adopts the (different) opinion of one of its neighbouring vertices.

In our model we extend the dynamics in a way that at each iteration with a certain probability \psi we are able to change the opinion of L random vertices. This implementation lets us introduce an additional external influence corresponding to Fake News.
Hence, the variable L is meant to represent the influence of media outlets on top of ideas spreading among acquaintances, modeling more accurately the increased internet-based reality,
which is not accounted for in the existing paper.

The varying parameters in this model are L, \psi and \phi. The latter are the same as in the original work of [1] in order to be able to compare our results with them.

## Fundamental Questions

The goal of this project is to find out the impact of Fake News on opinion formation.
In particular, we want to investigate the number of individuals L in a system which need to be influenced to a significantly shift of the initial distribution of opinions in a society, which can also be interpreted as the cluster sizes.
Additionally, it will be interesting to find out how the effect changes with varying probabilities \psi, i.e. how convincing these Fake News inputs are.

## Expected Results

In the previous work conducted by [1], with time going to infinity, clusters will form with each cluster having only members of a certain opinion. 
In our adapted model we expect that with large L and/or \psi one of these clusters will end up being substantially larger in size than the others. This corresponds to saying that the internet has the power to influence the formation of opinions.
Additionally, we expect that the system will reach consensus faster, as we have introduced an additional mechanism to change the opinions of individuals.

## References 

[1] Holme, Petter; Newman, M.E.J. (2006): Nonequilibrium phase transition in the coevolution of networks and opinions. 

## Research Methods

Agent-Based Model

(Cellular Automata, Agent-Based Model, Continuous Modeling...) (If you are not sure here: 1. Consult your colleagues, 2. ask the teachers, 3. remember that you can change it afterwards)

# Algorithmic Fairness in Recidivism Scores
**CS7290 Final Project**

## Overview
In this project, we attempt to evaluate the algorithmic fairness of recidivism scores using techniques from causal inference. We construct a causal model using data provided by the original [propublica](https://www.propublica.org/article/machine-bias-risk-assessments-in-criminal-sentencing) study exposing possible biases in COMPAS scores.  We evaluate sevaral scores:
- False Positive/Negative 
- Total Causal Effect
- Natural Direct/Indirect Effects
- Counterfactual Fairness
- Probabilities of Necessity and Sufficiency

## Challenges
Some of the challenges involved with this project include:
- missing some critical variables present in the real COMPAS model
- deciding on a causal model (DAG) with the provided COMPAS variables
- working with real numerical values as opposed to just categorical values

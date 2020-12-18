# generate all models with bnlearn and save probabilities

#setwd("~/neu/cs7290/final-project")

library(dplyr)
library(bnlearn)
library(Rgraphviz)

# read in simplified compas data
df <- read.csv('data/compas-scores-two-years-short.csv', stringsAsFactors=TRUE)

df <- df %>%
  mutate(two_year_recid = factor(two_year_recid)) %>%
  mutate(priors_count = factor(priors_count))

nodes = c("race", "sex", "age_cat", "priors_count", "two_year_recid")
e = empty.graph(nodes)

# ==========================================================================================
# Model 1

modelstring(e) = "[race][sex][age_cat][priors_count|race:sex:age_cat][two_year_recid|priors_count]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model1 = bn.fit(x = dag, data = df)

write.csv(model1$race$prob,"data/model1_race.csv", row.names = TRUE)
write.csv(model1$sex$prob,"data/model1_sex.csv", row.names = TRUE)
write.csv(model1$age_cat$prob,"data/model1_age_cat.csv", row.names = TRUE)
write.csv(model1$priors_count$prob,"data/model1_priors_count.csv", row.names = TRUE)
write.csv(model1$two_year_recid$prob,"data/model1_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# Model 2
modelstring(e) = "[race][sex][age_cat][priors_count|race:sex:age_cat][two_year_recid|priors_count:race]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model2_race = bn.fit(x = dag, data = df)

write.csv(model2_race$race$prob,"data/model2_race_race.csv", row.names = TRUE)
write.csv(model2_race$sex$prob,"data/model2_race_sex.csv", row.names = TRUE)
write.csv(model2_race$age_cat$prob,"data/model2_race_age_cat.csv", row.names = TRUE)
write.csv(model2_race$priors_count$prob,"data/model2_race_priors_count.csv", row.names = TRUE)
write.csv(model2_race$two_year_recid$prob,"data/model2_race_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# Model 3
modelstring(e) = "[race][sex][age_cat][priors_count|sex:age_cat][two_year_recid|priors_count]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model3_race = bn.fit(x = dag, data = df)

write.csv(model3_race$race$prob, "data/model3_race_race.csv", row.names = TRUE)
write.csv(model3_race$sex$prob, "data/model3_race_sex.csv", row.names = TRUE)
write.csv(model3_race$age_cat$prob, "data/model3_race_age_cat.csv", row.names = TRUE)
write.csv(model3_race$priors_count$prob, "data/model3_race_priors_count.csv", row.names = TRUE)
write.csv(model3_race$two_year_recid$prob, "data/model3_race_two_year_recid.csv", row.names = TRUE)
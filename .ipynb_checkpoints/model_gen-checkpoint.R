# generate all models with bnlearn and save probabilities

setwd("~/neu/cs7290/final-project")

library(dplyr)
library(bnlearn)
library(Rgraphviz)

# read in simplified compas data
df <- read.csv('compas-scores-two-years-short.csv', stringsAsFactors=TRUE) %>%
  mutate(two_year_recid = factor(two_year_recid)) %>%
  select(0:ncol(df))

biased_df <- read.csv('compas-scores-two-years-short-biased.csv', stringsAsFactors=TRUE) %>%
  mutate(two_year_recid = factor(two_year_recid)) %>%
  select(0:ncol(df))

nodes = c("race", "sex", "age_cat", "c_charge_degree", "two_year_recid")

# ==========================================================================================
# model 1

e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|race:sex:age_cat][two_year_recid|c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model1 = bn.fit(x = dag, data = df)

write.csv(model1$race$prob,"model1_race.csv", row.names = TRUE)
write.csv(model1$sex$prob,"model1_sex.csv", row.names = TRUE)
write.csv(model1$age_cat$prob,"model1_age_cat.csv", row.names = TRUE)
write.csv(model1$c_charge_degree$prob,"model1_c_charge_degree.csv", row.names = TRUE)
write.csv(model1$two_year_recid$prob,"model1_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# model 2

e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|race:sex:age_cat][two_year_recid|race:c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model2 = bn.fit(x = dag, data = df)

write.csv(model2$race$prob,"model2_race.csv", row.names = TRUE)
write.csv(model2$sex$prob,"model2_sex.csv", row.names = TRUE)
write.csv(model2$age_cat$prob,"model2_age_cat.csv", row.names = TRUE)
write.csv(model2$c_charge_degree$prob,"model2_c_charge_degree.csv", row.names = TRUE)
write.csv(model2$two_year_recid$prob,"model2_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# model 3

e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|sex:age_cat][two_year_recid|c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model3 = bn.fit(x = dag, data = df)

write.csv(model3$race$prob, "model3_race.csv", row.names = TRUE)
write.csv(model3$sex$prob, "model3_sex.csv", row.names = TRUE)
write.csv(model3$age_cat$prob, "model3_age_cat.csv", row.names = TRUE)
write.csv(model3$c_charge_degree$prob, "model3_c_charge_degree.csv", row.names = TRUE)
write.csv(model3$two_year_recid$prob, "model3_two_year_recid.csv", row.names = TRUE)


# ==========================================================================================
# model 2

e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|sex:age_cat][two_year_recid|c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model3 = bn.fit(x = dag, data = biased_df)

write.csv(model3$race$prob, "model4_race.csv", row.names = TRUE)
write.csv(model3$sex$prob, "model4_sex.csv", row.names = TRUE)
write.csv(model3$age_cat$prob, "model4_age_cat.csv", row.names = TRUE)
write.csv(model3$c_charge_degree$prob, "model4_c_charge_degree.csv", row.names = TRUE)
write.csv(model3$two_year_recid$prob, "model4_two_year_recid.csv", row.names = TRUE)

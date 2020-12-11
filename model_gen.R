# generate all models with bnlearn and save probabilities

setwd("~/neu/cs7290/final-project")

library(dplyr)
library(bnlearn)
library(Rgraphviz)

# read in simplified compas data
#df <- read.csv('data/compas-scores-two-years_short.csv', stringsAsFactors=TRUE)
df <- read.csv('data/compas-scores-two-years_short-priors_count.csv', stringsAsFactors=TRUE)

df <- df %>%
  mutate(two_year_recid = factor(two_year_recid)) %>%
  select(0:ncol(df))

# biased_df <- read.csv('data/compas-scores-two-years-short.csv', stringsAsFactors=TRUE) 
# 
# biased_df <- biased_df %>%
#   mutate(two_year_recid = factor(two_year_recid)) %>%
#   select(0:ncol(df))

nodes = c("race", "sex", "age_cat", "c_charge_degree", "two_year_recid")

# ==========================================================================================
# model 1

e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|race:sex:age_cat][two_year_recid|c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model1 = bn.fit(x = dag, data = df)

write.csv(model1$race$prob,"data/model1_race.csv", row.names = TRUE)
write.csv(model1$sex$prob,"data/model1_sex.csv", row.names = TRUE)
write.csv(model1$age_cat$prob,"data/model1_age_cat.csv", row.names = TRUE)
write.csv(model1$c_charge_degree$prob,"data/model1_c_charge_degree.csv", row.names = TRUE)
write.csv(model1$two_year_recid$prob,"data/model1_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# model 2

e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|race:sex:age_cat][two_year_recid|race:c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model2 = bn.fit(x = dag, data = df)

write.csv(model2$race$prob,"data/model2_race.csv", row.names = TRUE)
write.csv(model2$sex$prob,"data/model2_sex.csv", row.names = TRUE)
write.csv(model2$age_cat$prob,"data/model2_age_cat.csv", row.names = TRUE)
write.csv(model2$c_charge_degree$prob,"data/model2_c_charge_degree.csv", row.names = TRUE)
write.csv(model2$two_year_recid$prob,"data/model2_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# model 3

e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|sex:age_cat][two_year_recid|c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model3 = bn.fit(x = dag, data = df)

write.csv(model3$race$prob, "data/model3_race.csv", row.names = TRUE)
write.csv(model3$sex$prob, "data/model3_sex.csv", row.names = TRUE)
write.csv(model3$age_cat$prob, "data/model3_age_cat.csv", row.names = TRUE)
write.csv(model3$c_charge_degree$prob, "data/model3_c_charge_degree.csv", row.names = TRUE)
write.csv(model3$two_year_recid$prob, "data/model3_two_year_recid.csv", row.names = TRUE)


# ==========================================================================================
# model 4

# e = empty.graph(nodes)
# modelstring(e) = "[race][sex][age_cat][c_charge_degree|sex:age_cat][two_year_recid|c_charge_degree]"
# dag = model2network(modelstring(e), ordering = nodes)
# graphviz.plot(dag)
# 
# model3 = bn.fit(x = dag, data = biased_df)
# 
# write.csv(model3$race$prob, "data/model4_race.csv", row.names = TRUE)
# write.csv(model3$sex$prob, "data/model4_sex.csv", row.names = TRUE)
# write.csv(model3$age_cat$prob, "data/model4_age_cat.csv", row.names = TRUE)
# write.csv(model3$c_charge_degree$prob, "data/model4_c_charge_degree.csv", row.names = TRUE)
# write.csv(model3$two_year_recid$prob, "data/model4_two_year_recid.csv", row.names = TRUE)

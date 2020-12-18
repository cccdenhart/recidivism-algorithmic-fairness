# generate all models with bnlearn and save probabilities

#setwd("~/neu/cs7290/final-project")

library(dplyr)
library(bnlearn)
library(Rgraphviz)

# read in simplified compas data
df <- read.csv('data/compas-scores-two-years-short.csv', stringsAsFactors=TRUE)

df <- df %>%
  mutate(two_year_recid = factor(two_year_recid)) #%>%
  #mutate(priors_count = factor(priors_count))

nodes = c("race", "sex", "age_cat", "priors_count", "two_year_recid")
e = empty.graph(nodes)

# ==========================================================================================
# Model 1 - Indirect by Race and Gender

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
# Model 2 - Direct by Race, and Indirect by Race + Gender
modelstring(e) = "[race][sex][age_cat][priors_count|race:sex:age_cat][two_year_recid|priors_count:race]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model2 = bn.fit(x = dag, data = df)

write.csv(model2$race$prob,"data/model2_race.csv", row.names = TRUE)
write.csv(model2$sex$prob,"data/model2_sex.csv", row.names = TRUE)
write.csv(model2$age_cat$prob,"data/model2_age_cat.csv", row.names = TRUE)
write.csv(model2$priors_count$prob,"data/model2_priors_count.csv", row.names = TRUE)
write.csv(model2$two_year_recid$prob,"data/model2_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# Model 3 - Unaware by Race
modelstring(e) = "[race][sex][age_cat][priors_count|sex:age_cat][two_year_recid|priors_count]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model3 = bn.fit(x = dag, data = df)

write.csv(model3$race$prob, "data/model3_race.csv", row.names = TRUE)
write.csv(model3$sex$prob, "data/model3_sex.csv", row.names = TRUE)
write.csv(model3$age_cat$prob, "data/model3_age_cat.csv", row.names = TRUE)
write.csv(model3$priors_count$prob, "data/model3_priors_count.csv", row.names = TRUE)
write.csv(model3$two_year_recid$prob, "data/model3_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# Model 4 - Direct by Gender, and Indirect by Race + Gender
modelstring(e) = "[race][sex][age_cat][priors_count|race:sex:age_cat][two_year_recid|priors_count:sex]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model4 = bn.fit(x = dag, data = df)

write.csv(model4$race$prob,"data/model4_race.csv", row.names = TRUE)
write.csv(model4$sex$prob,"data/model4_sex.csv", row.names = TRUE)
write.csv(model4$age_cat$prob,"data/model4_age_cat.csv", row.names = TRUE)
write.csv(model4$priors_count$prob,"data/model4_priors_count.csv", row.names = TRUE)
write.csv(model4$two_year_recid$prob,"data/model4_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# Model 5 - Direct and Indirect by Race + Gender
modelstring(e) = "[race][sex][age_cat][priors_count|race:sex:age_cat][two_year_recid|priors_count:race:sex]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model5 = bn.fit(x = dag, data = df)

write.csv(model5$race$prob,"data/model5_race.csv", row.names = TRUE)
write.csv(model5$sex$prob,"data/model5_sex.csv", row.names = TRUE)
write.csv(model5$age_cat$prob,"data/model5_age_cat.csv", row.names = TRUE)
write.csv(model5$priors_count$prob,"data/model5_priors_count.csv", row.names = TRUE)
write.csv(model5$two_year_recid$prob,"data/model5_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# Model 6 - Unaware by Gender
modelstring(e) = "[race][sex][age_cat][priors_count|race:age_cat][two_year_recid|priors_count]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model6 = bn.fit(x = dag, data = df)

write.csv(model6$race$prob, "data/model6_race.csv", row.names = TRUE)
write.csv(model6$sex$prob, "data/model6_sex.csv", row.names = TRUE)
write.csv(model6$age_cat$prob, "data/model6_age_cat.csv", row.names = TRUE)
write.csv(model6$priors_count$prob, "data/model6_priors_count.csv", row.names = TRUE)
write.csv(model6$two_year_recid$prob, "data/model6_two_year_recid.csv", row.names = TRUE)

# ==========================================================================================
# Model 7 - Unaware by Race and Gender
modelstring(e) = "[race][sex][age_cat][priors_count|age_cat][two_year_recid|priors_count]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)

model7 = bn.fit(x = dag, data = df)

write.csv(model7$race$prob, "data/model7_race.csv", row.names = TRUE)
write.csv(model7$sex$prob, "data/model7_sex.csv", row.names = TRUE)
write.csv(model7$age_cat$prob, "data/model7_age_cat.csv", row.names = TRUE)
write.csv(model7$priors_count$prob, "data/model7_priors_count.csv", row.names = TRUE)
write.csv(model7$two_year_recid$prob, "data/model7_two_year_recid.csv", row.names = TRUE)

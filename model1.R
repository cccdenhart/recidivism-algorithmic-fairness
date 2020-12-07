setwd("E:/2020/fairness/")

library(dplyr)
library(bnlearn)
library(Rgraphviz)


df <- read.csv('compas-scores-two-years_short.csv',stringsAsFactors=TRUE)

df_new <- df %>%
  mutate(two_year_recid = factor(two_year_recid)) %>%
  select(0:ncol(df))


nodes = c("race","sex","age_cat","c_charge_degree","two_year_recid")
e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|race:sex:age_cat][two_year_recid|c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)


model1 = bn.fit(x = dag, data = df_new)

write.csv(model1$race$prob,"model1_race.csv", row.names = TRUE)
write.csv(model1$sex$prob,"model1_sex.csv", row.names = TRUE)
write.csv(model1$age_cat$prob,"model1_age_cat.csv", row.names = TRUE)
write.csv(model1$c_charge_degree$prob,"model1_c_charge_degree.csv", row.names = TRUE)
write.csv(model1$two_year_recid$prob,"model1_two_year_recid.csv", row.names = TRUE)

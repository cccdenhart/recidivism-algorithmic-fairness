#setwd("E:/2020/fairness/")
setwd("~/OneDrive/Documents/Career/Northeastern/causal_inf/cs7290-final-project")
library(dplyr)
library(bnlearn)
library(Rgraphviz)


df <- read.csv('compas-scores-two-years_short-biased.csv',stringsAsFactors=TRUE)

df_new <- df %>%
  mutate(two_year_recid = factor(two_year_recid)) %>%
  select(0:ncol(df))


nodes = c("race","sex","age_cat","c_charge_degree","two_year_recid")
e = empty.graph(nodes)
modelstring(e) = "[race][sex][age_cat][c_charge_degree|sex:age_cat][two_year_recid|c_charge_degree]"
dag = model2network(modelstring(e), ordering = nodes)
graphviz.plot(dag)


model3 = bn.fit(x = dag, data = df_new)

write.csv(model3$race$prob,"model5_race.csv", row.names = TRUE)
write.csv(model3$sex$prob,"model5_sex.csv", row.names = TRUE)
write.csv(model3$age_cat$prob,"model5_age_cat.csv", row.names = TRUE)
write.csv(model3$c_charge_degree$prob,"model5_c_charge_degree.csv", row.names = TRUE)
write.csv(model3$two_year_recid$prob,"model5_two_year_recid.csv", row.names = TRUE)
print('Done')
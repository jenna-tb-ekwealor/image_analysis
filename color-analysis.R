library("readbitmap")
#install.packages("imager")
library("imager")
library(tidyr)
library(ggplot2)
library(ggpubr)
library(car)
library(rstatix)
setwd("/Users/jennaekwealor/Documents/image_analysis")



UV.filtered<-"#66C2A5" #teal
UV.transmitted<-"#FC8D62" #orange
Site.reference<-"#8DA0CB" #purple


#### REPEAT FOR EACH A, B, C ####
# need to fix this to be a loop or lapply

RG_ratio_C <- numeric()
prop_G_C <- numeric()

files <- list.files(path="masked/C/", pattern="*.jpg", full.names=TRUE, recursive=FALSE)

for (i in files) {
  img <- load.image(i) 
  
  R <- numeric()
  G <- numeric()
  B <- numeric()
  
  R <- img[,,1]
  G <- img[,,2]
  B <- img[,,3]
  
  sum_R <- sum(R)
  sum_G <- sum(G)
  sum_B <- sum(B)
  
  # RG_ratio <- sum_R/sum_G
  RG_ratio_C <- append(RG_ratio_C, sum_R/sum_G)
  
  # prop_G <- sum_G/(sum_R+sum_G+sum_B)
  prop_G_C <- append(prop_G_C, sum_G/(sum_R+sum_G+sum_B))
}

#### make data frames of all 3 ####

RG_ratio <- data.frame(
  UV_filtered = RG_ratio_A,
  UV_transmitted = RG_ratio_B,
  Site_reference = RG_ratio_C)


prop_G <- data.frame(
  UV_filtered = prop_G_A,
  UV_transmitted = prop_G_B,
  Site_reference = prop_G_C)


# write to files
write.table(RG_ratio, "RG_ratio.csv", sep=",", quote=FALSE, row.names=FALSE, col.names=TRUE)
write.table(prop_G, "prop_G.csv", sep=",", quote=FALSE, row.names=FALSE, col.names=TRUE)




#### STATISTICAL TESTS and summaries ####

# convert to "long" format data frame
RG_ratio_long <- tidyr::gather(RG_ratio, Treatment, Value, UV_filtered:Site_reference, factor_key=TRUE)
RG_ratio_long_mean <- RG_ratio_long %>% group_by(Treatment) %>% summarize(mean = mean(Value), sd = sd(Value))

# using wilcoxon test due to small sample size
stat.test.RG_ratio <- rstatix::pairwise_wilcox_test(data = RG_ratio_long, Value ~ Treatment, paired = F, p.adjust.method = "BH") 
stat.test.RG_ratio <- stat.test.RG_ratio %>% mutate(y.position = c(1.31,1.35,1.33))
                                                                         
                                                                         
# convert to "long" format data frame
prop_G_long <- tidyr::gather(prop_G, Treatment, Value, UV_filtered:Site_reference, factor_key=TRUE)

prop_G_long_mean <- prop_G_long %>% group_by(Treatment) %>% summarize(mean = mean(Value), sd = sd(Value))

# using wilcoxon test due to small sample size
stat.test.prop_G <- rstatix::pairwise_wilcox_test(data = prop_G_long, Value ~ Treatment, paired = F, p.adjust.method = "BH") 
stat.test.prop_G <- stat.test.prop_G %>% mutate(y.position = c(0.348,0.356,0.352))


#### plot results ####



p.RG_ratio<-ggboxplot(data = RG_ratio_long, x="Treatment", y="Value",
                               fill = "Treatment",
                               color = "gray30",
                               size = 0.5,
                               point.size = 0.75,
                               outlier.size = 0.25,
                               line.color = "#4D4D4D66", 
                               scales = "free_y",
                               width = 0.7,
                               xlab = "",
                               ylab = "Ratio of  Red : Green",
                               ggtheme = theme_light()) +
  stat_pvalue_manual(stat.test.RG_ratio, label = "p.adj.signif") +
  scale_fill_manual(name = "Field Treatment", 
                    values = c("UV_filtered" = UV.filtered, "UV_transmitted" = UV.transmitted, "Site_reference" = Site.reference),
                    labels = c("UV-Filtered", "UV-Transmitted", "Site Reference")) +
  theme_light() +
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    axis.ticks = element_blank())



p.RG_ratio







p.prop_G<-ggboxplot(data = prop_G_long, x="Treatment", y="Value",
                      fill = "Treatment",
                      color = "gray30",
                      size = 0.5,
                      point.size = 0.75,
                      outlier.size = 0.25,
                      line.color = "#4D4D4D66", 
                      scales = "free_y",
                      width = 0.7,
                      xlab = "",
                      ylab = "Proportion Green",
                      ggtheme = theme_light()) +
  stat_pvalue_manual(stat.test.prop_G, label = "p.adj.signif") +
  scale_fill_manual(name = "Field Treatment", 
                    values = c("UV_filtered" = UV.filtered, "UV_transmitted" = UV.transmitted, "Site_reference" = Site.reference),
                    labels = c("UV-Filtered", "UV-Transmitted", "Site Reference")) +
  theme_light() +
  theme(
    axis.text.x = element_blank(),
    axis.title.x = element_blank(),
    axis.ticks = element_blank())



p.prop_G




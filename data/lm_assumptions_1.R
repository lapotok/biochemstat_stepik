library(tidyverse) # pipelines
library(ggrepel)

# # генерируем данные
# set.seed(1)
# n = 200
# x = runif(n, 0, 40) # "независимая" переменная
# y =                    # задаваемая переменная
#   exp(-5.5 + 0.075 * x +   # формула зависимости
#   rnorm(n, 0, .5))       # распределение ошибок
# d = tibble(x, y)

theme_set(
  theme_cowplot(10) + background_grid(size.major = .15)
)

d = rio::import(str_glue("https://github.com/lapotok/",
                         "biochemstat_stepik/blob/main/",
                         "data/lm_assumptions_1.tsv"))
#> x           y
#> 1 10.620347 0.006646550
#> 2 14.884956 0.012745585
#> 3 22.914135 0.014452314

# just points
ggplot(d,aes(x,y)) +
  geom_point(alpha=.7)

# fit
m = lm(y~x, d)
ggplot(d,aes(x,y)) +
  geom_point(alpha=.7) +
  geom_line(aes(y=predict(m)), col="red")

mf = fortify(m)
ggplot(m,aes(x,.resid)) +
  geom_point() +
  geom_hline(yintercept = 0, col="red", linetype="dashed")

ggpubr::ggqqplot(resid(m))

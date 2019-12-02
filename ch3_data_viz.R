# Chapter 3: Data Visualization

## Uses ggplot2

library(tidyverse)

# do cars w big engines use more fuel than cars w small engines?
# relationship between size and fuel efficiency?

# use mpg data frame in ggplot2
## data frame: rectangular collection of vars (cols) and obs (rows).

head(mpg)
summary(mpg)
colnames(mpg)

ggplot(data = mpg) + # creates a coordinate system/empty graph - you add layers to this
  geom_point(mapping = aes(x = displ, y = hwy)) #  geom_point adds a scatterplot
# each geom fn takes a mapping arg - defines how vars are mapped to visual properties
# an aes is a visual property of the objects in your plot

# Conclusion: cars w bigger engines use more fuel, less fuel efficient

# Hypothesis: outlier cars are hybrids

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# Outliers are 2-seaters

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

?mpg

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))
# error - cont var can't be mapped to shape

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cty)
# big yike

ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)
# type of drive on x 

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cty)
# cty mpg on y

?facet_wrap
?facet_grid

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv),
              show.legend = FALSE)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # treated as global mappings
  geom_point(mapping = aes(color = class)) + # local mapping - extends/overwrites global.
  geom_smooth()

#layer other data on top of global data set
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE)

?geom_smooth

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth(se = FALSE)

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(line = drv),se = FALSE)

# Bar charts

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut)) # can use stats and geoms interchangeablly

?stat_summary
?geom_col # needs a y, where _bar uses count by default
?stat_smooth # 

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..))

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut))
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut)) # more useful

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = 'fill')
# compare proportions

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = 'dodge')
# compare individ values

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point(position = "jitter")
nrow(mpg)

?geom_jitter
?geom_count 
?geom_boxplot

ggplot(data = mpg, fill = factor(vs)) +
  geom_boxplot(mapping = aes(x = manufacturer, y = hwy))
?geom_boxplot

# coordinate systems

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() + 
  coord_flip()

install.packages("maps")
library(maps)
nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") + 
  coord_quickmap()

# polar coords reveal cnxn between bar chart and coxcomb chart
bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) + 
  labs(x = NULL, y = NULL)

bar + coord_flip()
bar + coord_polar()

# stacked bar chart into pie chart
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = 'fill') + 
  coord_polar()

?labs

?coord_map # _quickmap = quick approximation that preserves straight lines
# map projections don't generally

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() + # adds reference lines
  coord_fixed() # normalizes plot viz
?geom_abline


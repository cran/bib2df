## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  warning = FALSE
)

## ----eval = FALSE-------------------------------------------------------------
#  install.packages("bib2df")

## -----------------------------------------------------------------------------
library(bib2df)

path <- system.file("extdata", "LiteratureOnCommonKnowledgeInGameTheory.bib", package = "bib2df")

df <- bib2df(path)
df

## -----------------------------------------------------------------------------
head(df$AUTHOR)

## -----------------------------------------------------------------------------
df <- bib2df(path, separate_names = TRUE)
head(df$AUTHOR)

## -----------------------------------------------------------------------------
bib1 <- system.file("extdata", "LiteratureOnCommonKnowledgeInGameTheory.bib", package = "bib2df")
bib2 <- system.file("extdata", "r.bib", package = "bib2df")
paths <- c(bib1, bib2)

x <- lapply(paths, bib2df)
class(x)
head(x)

res <- dplyr::bind_rows(x)
class(res)
head(res)

## ----message=FALSE------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(tidyr)

df %>%
  filter(!is.na(JOURNAL)) %>%
  group_by(JOURNAL) %>%
  summarize(n = n()) %>%
  arrange(desc(n)) %>%
  slice(1:3)

## -----------------------------------------------------------------------------
df %>%
  mutate(age = 2017 - YEAR) %>%
  summarize(m = median(age))

## ----fig.height = 5, fig.width = 7--------------------------------------------
df %>% 
  select(YEAR, AUTHOR) %>% 
  unnest() %>% 
  ggplot() + 
  aes(x = YEAR, y = reorder(full_name, desc(YEAR))) + 
  geom_point()

## -----------------------------------------------------------------------------
df$AUTHOR[[10]]

## -----------------------------------------------------------------------------
df$AUTHOR[[10]]$first_name[2] <- "Eddie"
df$AUTHOR[[10]]$full_name[2] <- "Eddie Dekel"

df$AUTHOR[[10]]

## ----eval=FALSE---------------------------------------------------------------
#  newFile <- tempfile()
#  df2bib(df, file = newFile)


library(tercen)
library(dplyr, warn.conflicts = FALSE)
library(flowCore)

# http://localhost:5402/admin/w/93fd4674e154604dd39e1863840078ca/ds/b1c658a9-59c0-4416-b8d9-6f735d32333f

options("tercen.workflowId" = "93fd4674e154604dd39e1863840078ca")
options("tercen.stepId"     = "b1c658a9-59c0-4416-b8d9-6f735d32333f")

getOption("tercen.workflowId")
getOption("tercen.stepId")

do.transform = function(df, ...) {
  scale.m = try(transform(new("flowFrame", exprs = as.matrix(df)), `.y` =
                            logicleTransform("logicle")(`.y`))@exprs[, 3],
                silent = TRUE)
  
  if (inherits(scale.m, 'try-error')) {
    return (data.frame(
      .ri = integer(),
      .ci = integer(),
      scale = double()
    ))
  }
  
  browser()
  
  result = as_tibble(scale.m) %>%
    rename_all(
      .funs = function(x)
        'transform'
    ) %>%
    mutate(.ri = df$.ri, .ci = df$.ci)
  
  return (result)
}

ctx = tercenCtx()

ctx %>%
  select(.ci, .ri, .y) %>%
  group_by(.ci, .ri) %>%
  summarise(.y = mean(.y)) %>%
  group_by(.ri) %>%
  do(do.transform(.,)) %>%
  ctx$addNamespace() %>%
  ctx$save()

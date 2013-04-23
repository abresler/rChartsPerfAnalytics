require(PerformanceAnalytics)
require(reshape2)
data(managers)
xtsMelt <- function(xtsData,metric){
  df <- data.frame(index(xtsData),coredata(xtsData),stringsAsFactors=FALSE)
  df.melt <- melt(df,id.vars=1)
  df.melt <- data.frame(df.melt,rep(metric,NROW(df.melt)))
  #little unnecessary housekeeping
  df.melt <- df.melt[,c(1,2,4,3)]
  colnames(df.melt) <- c("date","indexname","metric","value")
  df.melt$date <- as.Date(df.melt$date)
  return(df.melt)
}
getCumul <- function(dat){
  data.cumul <- cumprod(1 + dat)
  data.melt <- xtsMelt(data.cumul, "CumulativeGrowth")
  i <- sapply(data.melt, is.factor)
  data.melt[i] <- lapply(data.melt[i], gsub, pattern="\\.", replacement="")
  #get date as text
  data.melt$date <- format(data.melt$date,"%Y-%m-%d")
  return(data.melt)
}
getDrawdowns <- function(dat) {
  data.drawdowns <- Drawdowns(dat)
  data.melt <- xtsMelt(data.drawdowns, "Drawdown")
  i <- sapply(data.melt, is.factor)
  data.melt[i] <- lapply(data.melt[i], gsub, pattern="\\.", replacement="")
  #get date as text
  data.melt$date <- format(data.melt$date,"%Y-%m-%d")  
  return(data.melt) 
}
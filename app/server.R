## @knitr server.R
## server.R
require(rCharts)
shinyServer(function(input, output) {
  output$chart1 = renderChart({
    dat = getCumul(managers[,c(as.integer(input$manager), 8, 9)])
    p1 <- rPlot(height = 400, value ~ date, data = dat, 
      color = 'indexname', type = 'point', size = list(const=1)) 
    p1$set( legendPosition = "top", dom = 'chart1')
    p1$facet(type = "wrap",var = "metric", cols = 1,
      formatter="function(object) {return object.metric;}")
    p1$set(title = paste('Manager', input$manager))
    return(p1)
  })
  output$chart2 = renderChart({
    dat = getDrawdowns(managers[,c(as.integer(input$manager), 8, 9)])
    p2 <- rPlot(height = 200, value ~ date, data = dat, 
                color = 'indexname', type = 'line', size = list(const = 1)) 
    p2$set( legendPosition = "top", dom = 'chart2')
    p2$facet(type = "wrap", var="metric", cols=1,
      formatter = "function(object) {return object.metric;}")
    return(p2)
  })
})
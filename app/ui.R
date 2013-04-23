## @knitr ui.R
## ui.R
require(rCharts)
shinyUI(pageWithSidebar(
  headerPanel("Performance Analytics, using rCharts, Shiny and PolychartJS"),
  
  sidebarPanel(
    selectInput(inputId = 'manager',
      label = "Manager",
      choices = 1:6,
      selected = 1)
  ),
  mainPanel(
    showOutput("chart1", "polycharts"),
    showOutput("chart2", "polycharts")
  )
))
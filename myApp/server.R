#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(dplyr)

# Define server logic required to draw a histogram
function(input, output) {
  
sumRevenue <- reactive({
centralized <- centralized %>% mutate(attendance_rate = attendance_rate + .01*input$sliderAttendance)
centralized <- centralized %>% mutate(participation_rate = .01*input$stayAllDayRate)
centralized <- centralized %>% mutate(dynamic_revenue = enrollment*days_service*attendance_rate*participation_rate*8.31)
sum(centralized$dynamic_revenue)
})

dynamicRevenues <- reactive({
  centralized <- centralized %>% mutate(attendance_rate = attendance_rate + .01*input$sliderAttendance)
  centralized <- centralized %>% mutate(participation_rate = .01*input$stayAllDayRate)
  centralized <- centralized %>% mutate(dynamic_revenue = enrollment*days_service*attendance_rate*participation_rate*8.31)
  return(centralized$dynamic_revenue)
  
})

foodCost <- reactive({
  sumRevenue() * .5
})

netPosition <- reactive({
  sumRevenue() - foodCost() - 423666
})

someText <- reactive({ 
  
  if(netPosition() > 0){
    return(paste("<span style=\"color:green\">Surplus</span>"))
    
  }else if(netPosition() < 0){
    return(paste("<span style=\"color:red\">Deficit</span>"))
  }
  
  else {
    return(paste("<span style=\"color:blue\">Break even</span>"))
  }
})

sumCosts <- reactive({
  sum(foodCost()) + 423666
})

output$plot1 <- renderPlot({
  plot(centralized$month,dynamicRevenues(), xlab = "Month", ylab = "Revenue", ylim= c(0,120000))
  abline(h=(foodCost() + 423666)/12,col = "blue",lwd = 2)
})

output$plot2 <- renderPlot({
  data <- c(sumRevenue(), sumCosts())
  barplot(data, xlab = "Dollars", col = c("green","red"),names.arg = c("Revenue","Costs"), ylim = c(0,1000000))
})


output$sumRevenue <-  renderText({sumRevenue()})
output$foodCost <-  renderText({foodCost()})
output$laborCost <- renderText(423666)
output$netPosition <- renderText({netPosition()})
output$someText <- renderText({someText()})

}

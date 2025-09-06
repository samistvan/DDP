#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Data Science FTW"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            h3("Sidebar text"),
            sliderInput("sliderAttendance","Change in attendance rate %", -10,10,value = 0),
            sliderInput("stayAllDayRate", "At what rate do students stay all day?",60,100,value = 92)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Revenue:"),
            textOutput("sumRevenue"),
            h5("Food Cost:"),
            textOutput("foodCost"),
            h5("Labor Cost:"),
            textOutput("laborCost"),
            h3(strong("Net Position:")),
            textOutput("netPosition"),
            htmlOutput("someText"),
            plotOutput("plot1"),
            plotOutput("plot2")
            
            
        )
    )
))


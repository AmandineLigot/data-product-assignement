library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Vapor Pressure (in mm) from Temperature (in degC)"),
  sidebarLayout(
    sidebarPanel(
      radioButtons("degree1", label = h3("Polynomial degree of the first regression model"),
                   choices = list("Polynome of degree 1" = 1, "Polynome of degree 2" = 2, "Polynome of degree 3" = 3, "Polynome of degree 4" = 4), 
                   selected = 1),
      radioButtons("degree2", label = h3("Polynomial degree of the second regression model"),
                   choices = list("Polynome of degree 1" = 1, "Polynome of degree 2" = 2, "Polynome of degree 3" = 3, "Polynome of degree 4" = 4), 
                   selected = 1),
      sliderInput("sliderT", label = h3("For which temperature would you like to know the vapor pressure of Mercury?"), 0, 360, value = 20),
      submitButton("Submit")
    ),
    mainPanel(
      plotOutput("plot1"),
      h3("Predicted Pressure (in mm) from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Pressure (in mm) from Model 2:"),
      textOutput("pred2")
    )
  )
))
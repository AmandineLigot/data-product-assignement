library(shiny)
shinyServer(function(input, output) {
  model1 <- reactive({
    lm(pressure ~ poly(temperature, as.integer(input$degree1)), data = pressure) 
  })
    
  model2 <- reactive({ 
    lm(pressure ~ poly(temperature, as.integer(input$degree2)), data = pressure)
  })
  
  model1pred <- reactive({
    TInput <- input$sliderT
    predict(model1(), newdata = data.frame(temperature = TInput))
  })
  
  model2pred <- reactive({
    TInput <- input$sliderT
    predict(model2(), newdata = 
              data.frame(temperature = TInput))
  })
  
  output$plot1 <- renderPlot({
    TInput <- input$sliderT
    
    plot(pressure$temperature, pressure$pressure, xlab = "Temperature (in degC)", 
         ylab = "Vapor Pressure (in mm)", bty = "n", pch = 16,
         xlim = c(0, 360), ylim = c(-200, 806))
    
      lines(x= pressure$temperature, y = model1()$fitted.values, col = "red", lwd = 2)
      lines(x= pressure$temperature, y = model2()$fitted.values, col = "blue", lwd = 2)
      
    legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
           col = c("red", "blue"), bty = "n", cex = 1.2)
    
    points(TInput, model1pred(), col = "red", pch = 16, cex = 2)
    points(TInput, model2pred(), col = "blue", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})
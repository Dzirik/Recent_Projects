library(shiny)

# definition of serve logic
shinyServer(function(input, output) {  
  #true classes plot
  output$TruePlot <- renderPlot({    
    plot(iris[iris[,5]=="setosa",c(1,3)],
         main="Original",
         pch=0,
         xlim=c(min(iris[,1]),max(iris[,1])),
         ylim=c(min(iris[,3]),max(iris[,3])),
         asp=1)
    points(iris[iris[,5]=="virginica",c(1,3)],pch=16)
    points(iris[iris[,5]=="versicolor",c(1,3)],pch=3)
    plotOutput("whatever", height="auto")
  })
  
  #clustering plot with selected parameters
  output$ClusterPlot <-renderPlot({ 
    input$go
    irisClustering<-kmeans(iris[,c(1,3)],centers=input$nOfClusters,iter.max=input$maxNOfIteration)
    plot(iris[,c(1,3)],col=irisClustering$cluster, asp=1)
    points(irisClustering$centers,col=1:input$nOfClusters,pch=8,cex=2)     
  })
  
  #table
  output$table <- renderTable({
    iris[,c(5,1,3)]
  })
})
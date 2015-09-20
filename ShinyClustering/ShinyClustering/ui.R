library(shiny) 

# definition of UI
shinyUI(fluidPage(
  
  # main title and text
  titlePanel("Clustering Tutorial with Shiny"),
  p("This is a simple tutorial for k-means clustering with Iris data set. 
    You can set the parameters in the left part and then see the changes in the figure."),  
  
  # Sidebar with a number of clusters
  sidebarLayout(
    sidebarPanel(
      p("You can select the number of clusters in following part from 1 to 6. This part is reacting GUI, so you can see immediate
      change in the 'Clustering Plot' on the right side."),
      sliderInput("nOfClusters",
                  "Number of Clusters:",
                  min = 1,
                  max = 6,
                  value = 3),
      
      p("Moreover, you can select the maximal number of iterations here."),
      numericInput("maxNOfIteration", "Maximal Number of Iterations:", value = 1,min = 1, max = 10),
      
      p("When you can rerun the clutering again with the same parameters, please push this button."),
      actionButton("go", "Rerun"),
      strong(div("It is possible that the results will be the same; there is some randomisation in the algorithm. 
        For different resuls try lower number of iteration 
        and/or higher number of clusters. After that the results will change when you push the button.", style = "color:red"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      strong("Clustering Plot"),
      p("It shows the results of clustering with selected parameters 'Number of Clusters' and 'Maximal Number of Iterations'.
        Membeship to the cluster is marked by the same color and there is a centroid of each cluster there too."),
      strong("True Class Plot"),
      p("This plot shows the original class labels for the data set."),
      strong("Table"),
      p("The values for all observations are in this table."),
      tabsetPanel(type="tabs",
        tabPanel("Clustering Plot",plotOutput("ClusterPlot")),
        tabPanel("True Classes Plot",plotOutput("TruePlot")),
        tabPanel("Table",tableOutput("table"))
      )
    )
  )
))
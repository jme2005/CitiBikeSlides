library(shiny)
library(RCurl)
tmp1=getURL("https://raw.githubusercontent.com/jme2005/DataProd/master/data/StartStations.csv") #StartStation=read.csv("./data/StartStations.csv",colClasses="character")
StartStations<-read.csv(text=tmp1)
shinyUI(fluidPage(
        titlePanel("Citi Bike User Data"),
        
        sidebarLayout(
                sidebarPanel(
                        helpText("Pick a start station to see where people traveled from there and how long it took them."),
                        
                        selectInput("startstation", 
                                    label = "Select a start station",
                                    choices = StartStations$x,
                                    selected="E 43 St & Vanderbilt Ave"),
                        submitButton('Plot!'),
                        h4(" "),
                        sliderInput('mp','Set the color bar midpoint (fraction of the range):',value=0.5,min=0,max=1,step=0.05),
                        h4(" "),
                        h4("Results:"),
                        textOutput("text2"),
                        h4(" "),
                        h4("User Guide"),
                        p("1. Select start station using the scroll down bar."),
                        p("2. Push 'Plot!'."),
                        p("3. Plot will appear to the right, please be patient, 
                          the first time this might take a few seconds."),
                        p("4. If you want to, you can adjust the center of the color scale using the slider. 
                          Remember to press 'Plot!' for the changes to appear."),
                        h5("Figure Legend"),
                        p("Each point on the map represents a Citi Bike docking station. 
                          The color of the points corresponds to the daily average 
                          number of trips from the selected start station to the indicated end stations. 
                          The size of the points indicates the average time it takes for a user 
                          to make the trip from the start station to the respective end stations.
                          The selected start station is marked on the map with a red box.")
                        ),
                
                mainPanel(
                        
                        h4(textOutput("text1"),align="center"),
                        plotOutput("bikeMapPlot")
                )
                
                        
        )
))
        
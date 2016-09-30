library(shiny)

shinyServer(
    function(input, output) {
        
        
        # Fill in the spot we created for a plot
        output$crimePlot <- renderPlot({

            if(input$radio == "All Crimes") {
                data <- filter(crimeData, 
                          neighborhood %in% input$hood)
            } else {
                data <- filter(crimeData, 
                               neighborhood %in% input$hood & 
                                   offense %in% input$offense)
            }
            
                ggplot(data, aes(x = year, y = n)) +
                    geom_bar(aes(fill = offense), stat="identity") +
                    labs(title = paste('Total Occurrences in', input$hood),
                         x = "", y = "Occurrences") +
                    theme(text = element_text(colour="white"),
                          axis.text = element_text(size = 14, colour="white"),
                          plot.title = element_text(size = 26),
                          legend.position="bottom",
                          legend.key= element_blank(),
                          legend.title = element_blank(),
                          legend.text = element_text(size=12),
                          legend.background=element_blank(),
                          panel.background=element_blank(),
                          panel.grid=element_blank(),
                          plot.background=element_blank()
                          )
                
        }, bg="transparent" )
    })        
    

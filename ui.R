library(shiny)

shinyUI(fluidPage(theme = "superhero.css",
    titlePanel("Denver Crime Data Neighborhood Analysis"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("Explore Denver's crime data by selecting a neighborhood below. Then select either all crimes, or choose crime categories."),
            selectInput(
                inputId="hood", 
                label = h3("Select Neighborhood"), 
                choices = as.character(crime.hoods)
                ),
            
            radioButtons(
                inputId="radio",
                label="Choose Crime Categories:",
                choices=list(
                    "All Crimes",
                    "Select Individual Categories"
                ),
                selected="All Crimes"),
            
            conditionalPanel(
                condition = "input.radio != 'All Crimes'",
                checkboxGroupInput(
                    "offense", 
                    label = h3("Crime Type"),
                    choices = as.character(crime.types), 
                    selected="aggravated assault")
            ),
            helpText( a(href="https://www.denvergov.org/opendata/dataset/city-and-county-of-denver-crime", "Source: Denver Open Data", target="_blank"))
        ),
        mainPanel(
            fluidRow(column(plotOutput("crimePlot"), width = 11))
        )
    )
)
)
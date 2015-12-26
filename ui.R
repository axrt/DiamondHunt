carat.min.max<- carat.min.max()
depth.min.max<- depth.min.max()
table.min.max<- table.min.max()
price.min.max<- price.min.max()

shinyUI(fluidPage(
        
        tags$head(
                tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
        ),
        titlePanel("How badly is a diamond overpriced?"),
        fluidRow(
                column(width = 5,
                       wellPanel(
                               h4("Select your parameters below:"),
                               sliderInput("carat", label = h3("Weight (carat)"), min = carat.min.max[1], 
                                           max = carat.min.max[2],  value = carat.min.max, step = 0.01),
                               sliderInput("price", label = h3("Price ($)"), min = price.min.max[1], 
                                           max = price.min.max[2], value = price.min.max, step = 0.01),
                               checkboxGroupInput("cut", h3("Cut:"), cuts(),  inline = TRUE),
                               checkboxGroupInput("color", h3("Color:"), colors(),  inline = TRUE),
                               checkboxGroupInput("clarity", h3("Clarity:"), clarities(),  inline = TRUE),
                               sliderInput("depth", label = h3("Depth (%)"), min = depth.min.max[1], 
                                           max = depth.min.max[2], value = depth.min.max, step = 0.01),
                               sliderInput("table", label = h3("Table (%)"), min = table.min.max[1], 
                                           max = table.min.max[2], value = table.min.max, step = 0.01)
                       ),
                       wellPanel(
                               selectInput("xvar", "X values", axis.labels, selected = "price"),
                               selectInput("yvar", "Y values", axis.labels, selected = "carat")
                       )
                ),
                column(9,
                       ggvisOutput("plot1")
                )
        )
))
carat.min.max<- carat.min.max()
shinyUI(fluidPage(
        titlePanel("How badly is a diamond overpriced?"),
        fluidRow(
                column(width = 4,
                       wellPanel(
                               h4("Select your parameters below:"),
                               sliderInput("carat", label = h3("Weight (carat)"), min = carat.min.max$min.carat, 
                                           max = carat.min.max$max.carat,  value = c(0.1, 10), step = 0.01)
                       ),
                       checkboxGroupInput("cut", h3("Cut:"), cuts(),  inline = TRUE),
                       checkboxGroupInput("color", h3("Color:"), colors(),  inline = TRUE),
                       checkboxGroupInput("clarity", h3("Clarity:"), clarities(),  inline = TRUE),
                       sliderInput("carat", label = h3("Weight (carat)"), min = 0.1, 
                                   max = 10, value = c(0.1, 10), step = 0.01)
                )
        )
))
library(ggvis)
carat.min.max<- carat.min.max()
if(carat.min.max[2]>2){
        carat.max.start<-2  
}else{
        carat.max.start<-carat.min.max[2] 
}
depth.min.max<- depth.min.max()
table.min.max<- table.min.max()
price.min.max<- price.min.max()
if(price.min.max[2]>5000){
        price.max.start<- 5000   
}else{
        price.max.start<- price.min.max[2]
}

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
                                           max = carat.min.max[2],  value = c(carat.min.max[1],carat.max.start), step = 0.01),
                               sliderInput("price", label = h3("Price ($)"), min = price.min.max[1], 
                                           max = price.min.max[2], value = c(price.min.max[1],price.max.start), step = 0.01),
                               checkboxGroupInput("cut", h3("Cut:"), cuts(), selected=c("Ideal","Premium"), inline = TRUE),
                               checkboxGroupInput("color", h3("Color:"), colors(), selected=c("D", "E", "G", "F"), inline = TRUE),
                               checkboxGroupInput("clarity", h3("Clarity:"), clarities(), selected=c("VVS1", "VVS2", "IF"), inline = TRUE),
                               sliderInput("depth", label = h3("Depth (%)"), min = depth.min.max[1], 
                                           max = depth.min.max[2], value = depth.min.max, step = 0.01),
                               sliderInput("table", label = h3("Table (%)"), min = table.min.max[1], 
                                           max = table.min.max[2], value = table.min.max, step = 0.01)
                       )
                      
                ),
                column(width=7,
                       ggvisOutput(plot_id = "diamond_plot"),
                       wellPanel(
                               selectInput("xlab", "X values", axis.labels, selected = "carat"),
                               selectInput("ylab", "Y values", axis.labels, selected = "price"),
                               selectInput("fill", "Fill", axis.labels, selected = "color")
                       )
                )
        )
))
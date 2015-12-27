library(ggvis)
#collect the minimal and maximal weights
carat.min.max<- carat.min.max()
if(carat.min.max[2]>2){ #I wanted to set the slider to some
        #sensible weights like 2 crats, so this checks of the maximum is larger than
        #this value, then just stop at two carats
        carat.max.start<-2  
}else{
        carat.max.start<-carat.min.max[2] 
}
#collect depth values range
depth.min.max<- depth.min.max()
#collect table values range
table.min.max<- table.min.max()
#collect the miminal and maximal 
price.min.max<- price.min.max()
if(price.min.max[2]>5000){
        #same as above, I wanted to set the initial price at some value, that still
        #makes sence
        price.max.start<- 5000   
}else{
        price.max.start<- price.min.max[2]
}

#UI function
shinyUI(fluidPage(
        #the header tag contails a link to the custom css, which in this case only helps color the price
        #slider red
        tags$head(
                tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
        ),
        #title
        titlePanel("Know your diamonds!"),
        #load in the help file
        includeHTML("howto.html"), 
        #a row that contains the whole UI
        fluidRow(
                #the leftmost column that contains all the controls
                column(width = 5,
                       wellPanel(
                               h4("Select your parameters below:"),
                               #weight
                               sliderInput("carat", label = h3("Weight (carat)"), min = carat.min.max[1], 
                                           max = carat.min.max[2],  value = c(carat.min.max[1],carat.max.start), step = 0.01),
                               #price
                               sliderInput("price", label = h3("Price ($)"), min = price.min.max[1], 
                                           max = price.min.max[2], value = c(price.min.max[1],price.max.start), step = 0.01),
                               #cut
                               checkboxGroupInput("cut", h3("Cut:"), cuts(), selected=c("Ideal","Premium"), inline = TRUE),
                               #color
                               checkboxGroupInput("color", h3("Color:"), colors(), selected=c("D", "E", "G", "F"), inline = TRUE),
                               #clarity
                               checkboxGroupInput("clarity", h3("Clarity:"), clarities(), selected=c("VVS1", "VVS2", "IF"), inline = TRUE),
                               #depth
                               sliderInput("depth", label = h3("Depth (%)"), min = depth.min.max[1], 
                                           max = depth.min.max[2], value = depth.min.max, step = 0.01),
                               #table
                               sliderInput("table", label = h3("Table (%)"), min = table.min.max[1], 
                                           max = table.min.max[2], value = table.min.max, step = 0.01)
                       )
                ),
                #this column contains the plot and the panel, that allows to switch axis
                column(width=7,
                       #the plot itself, pulled by id
                       ggvisOutput(plot_id = "diamond_plot"),
                       #a small panel to make it possible to switch variables
                       wellPanel(
                               selectInput("xlab", "X values", axis.labels, selected = "carat"),
                               selectInput("ylab", "Y values", axis.labels, selected = "price"),
                               selectInput("fill", "Fill", axis.labels, selected = "color")
                       )
                )
        )
))
################
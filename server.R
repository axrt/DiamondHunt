library("shiny")
library("ggvis")
library("dplyr")

#connect to the embedded diamond database
db<- dbConnect(SQLite(), dbname="diamonds")

#server function
shinyServer(function(input, output, session ) {#not entirely sure I do the session right..
        #this function will be used from reactive context below.
        #it simply joins the main diamondlistings table with the
        #lookup tables and slices to the given parameters, such
        #as price, weight etc.
        diamonds.list<- function() {
                #get the paramters fromt he input
                #(had some misterious troubles had i not assign to new varibales)
                carat<- input$carat
                cut<- input$cut
                color<- input$color
                clarity<- input$clarity
                depth<- input$depth
                table<- input$table
                price<- input$price
                #the database query itself
                diamonds.data<- dbGetQuery(db, paste0("select diamondlistings.id,
                                         carat, cuts.cut, colors.color, 
                                         clarities.clarity, depth, `table`, price
                                         from diamondlistings
                                         inner join cuts on cuts.id=diamondlistings.cut
                                         inner join colors on colors.id=diamondlistings.color
                                         inner join clarities on clarities.id=diamondlistings.clarity
                                         where 
                                         carat>=",carat[1],
                                                      " and carat<=", carat[2],
                                                      " and price>=", price[1],
                                                      " and price<=", price[2],
                                                      " and cuts.cut in (", paste(sapply(cut,function(x){
                                                              return(paste0("\'",x,"\'"))
                                                      }), collapse=","), ")",
                                                      " and colors.color in (", paste(sapply(color,function(x){
                                                              return(paste0("\'",x,"\'"))
                                                      }), collapse=","), ")",
                                                      " and clarities.clarity in (", paste(sapply(clarity,function(x){
                                                              return(paste0("\'",x,"\'"))
                                                      }), collapse=","), ")",
                                                      " and `table`>=", table[1],
                                                      " and `table`<=", table[2],
                                                      " and depth>=", depth[1],
                                                      " and depth<=", depth[2],
                                                      ";"))
                return(diamonds.data)#returns the dataframe of diamonds for a given set of parameters
        }
        
        
        observe( {#do not use reactive here! it has a bug leading to null ids on the points added to the
                #plot later on
                
                #find the one that is currently selected for the axis
                #and get the variable name by varibale
                xvar.label <- names(axis.labels)[axis.labels == input$xlab]
                yvar.label <- names(axis.labels)[axis.labels == input$ylab]
                #as we are going to use these in a formula, convert to variable object
                xvar <- prop("x", as.symbol(input$xlab))
                yvar <- prop("y", as.symbol(input$ylab))
                fill.color <- prop("fill", as.symbol(input$fill))
                
                #get the diamond listings set with the given parameters
                dl<- diamonds.list()
                #plot out
                dl %>%
                        ggvis(x=xvar, y=yvar) %>% #initiate plot
                        layer_points(fill=fill.color, size := ~carat*100, 
                                     stroke :="grey", strokeWidth := 0.2, size.hover := ~carat*500,
                                     fillOpacity := 0.2, fillOpacity.hover := 0.7, key := ~id) %>% #overlay with points
                        add_tooltip(function(x){ #add a tooltip (the thing that appears on hover over a dot)
                                x<- filter(dl, id==x$id)
                                paste(
                                        "Carat: ", x$carat, "</br>",
                                        "Cut: ", x$cut, "</br>",
                                        "Color: ", x$color, "</br>",
                                        "Clarity: ", x$clarity, "</br>",
                                        "Price: ", x$price, "</br>"
                                      )#print out the 4C parameters and price
                        }, "hover")%>%#scale the plot to fill the space dedicated
                        set_options(width = 800, height = 500) %>%
                        add_axis("x", title = xvar.label, title_offset = 60) %>% #push the axis names back a little
                        add_axis("y", title = yvar.label, title_offset = 60) %>%
                        bind_shiny(plot_id = "diamond_plot") #bind to an id
        })
        
        return(output)
})
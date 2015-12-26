library("shiny")
library("ggvis")

db<- dbConnect(SQLite(), dbname="diamonds")

shinyServer(function(input, output, session) {
        diamonds.list<- reactive({
                #get the paramters fromt he input
                carat<- input$carat
                cut<- input$cut
                color<- input$color
                clarity<- input$clarity
                depth<- input$depth
                table<- input$table
                price<- input$price
                
                diamonds.data<- dbGetQuery(db, paste0("select 
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
                                                      ";"))
                return(diamonds.data)
        })
        
        reactive({
                
                xvar.label <- names(axis.labels)[axis.labels == input$xlab]
                yvar.label <- names(axis.labels)[axis.labels == input$ylab]
                xvar <- prop("x", as.symbol(input$xlab))
                yvar <- prop("y", as.symbol(input$ylab))
                
                diamonds.list %>%
                        ggvis(x=xvar, y=yvar) %>%
                        layer_points()
                
        })%>% bind_shiny(plot_id = "diamond_plot")
        
        return(output)
})
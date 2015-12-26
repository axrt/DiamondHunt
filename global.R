library(RSQLite)

#'
#'This function selects all maximal and minimal weight for the diamonds that
#'exist in the database. The extreme values will be the edge values within the 
#'sliders in the UI
#'
carat.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(carat) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(carat) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.carat"=min.carat, "max.carat"= max.carat))     
}

#'
#'Selects all cut types from the database to use in the UI
#'
cuts<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        ret<- dbReadTable(db, "cuts")$cut
        dbDisconnect(db)
        return(ret)
}

#'
#'Selects all colors from the database to use in the UI
#'
colors<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        ret<- dbReadTable(db, "colors")$color
        dbDisconnect(db)
        return(ret)
}

#'
#'Selects all types of clarity from the database to use in the UI
#'
clarities<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        ret<- dbReadTable(db, "clarities")$clarity
        dbDisconnect(db)
        return(ret)
}

#'
#'Selects all maximal and minimal depth values for the diamonds that
#'exist in the database. The extreme values will be the edge values within the 
#'sliders in the UI
#'
depth.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(depth) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(depth) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.depth"=min.carat, "max.depth"= max.carat))     
}

#'
#'This function selects all maximal and minimal weights for a the diamonds that
#'exist in the database. The extreme values will be the edge values within the 
#'sliders in the UI
#'
table.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(`table`) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(`table`) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.table"=min.carat, "max.table"= max.carat))     
}

#'
#'This function selects all maximal and minimal prices for a the diamonds that
#'exist in the database. The extreme values will be the edge values within the 
#'sliders in the UI
#'
price.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(price) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(price) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.price"=min.carat, "max.price"= max.carat))    
}

#'
#'Types of variables that can be selected for each axis in the UI
#'
axis.labels<- c("Carat"="carat","Cut"="cut","Color"="color",
                "Clarity"="clarity","Depth"="depth","Table"="table",
                "Price"="price")


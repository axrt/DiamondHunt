library(RSQLite)
carat.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(carat) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(carat) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.carat"=min.carat, "max.carat"= max.carat))     
}
cuts<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        ret<- dbReadTable(db, "cuts")$cut
        dbDisconnect(db)
        return(ret)
}
colors<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        ret<- dbReadTable(db, "colors")$color
        dbDisconnect(db)
        return(ret)
}
clarities<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        ret<- dbReadTable(db, "clarities")$clarity
        dbDisconnect(db)
        return(ret)
}
depth.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(depth) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(depth) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.depth"=min.carat, "max.depth"= max.carat))     
}
table.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(`table`) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(`table`) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.table"=min.carat, "max.table"= max.carat))     
}
price.min.max<- function(){
        db<- dbConnect(SQLite(), dbname="diamonds")
        max.carat<- dbGetQuery(db, "select max(price) from diamondlistings")[1,1]
        min.carat<- dbGetQuery(db, "select min(price) from diamondlistings")[1,1]
        dbDisconnect(db)
        return(c("min.price"=min.carat, "max.price"= max.carat))    
}

axis.labels<- c("Carat"="carat","Cut"="cut","Color"="color",
                "Clarity"="clarity","Depth"="depth","Table"="table",
                "Price"="price")


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

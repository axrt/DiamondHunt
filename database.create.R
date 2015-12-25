library(sqldf)
library(ggplot2)
library(dplyr)
library(data.table)
data("diamonds")
#create the database connection
db <- dbConnect(SQLite(), dbname="diamonds")
#create a lookup table for the CUT parameter
dbSendQuery(conn=db, "create table cuts (
id integer primary key autoincrement,
cut text not null unique
);")
#create a lookup table for the COLOR parameter
dbSendQuery(conn=db, "create table colors (
id integer primary key autoincrement,
            color text not null unique
);")
#create a lookup table for the CLARITY parameter
dbSendQuery(conn=db, "create table clarities (
id integer primary key,
            clarity text not null unique
);")
dbSendQuery(conn=db, "create table diamondlistings (
id integer primary key autoincrement,
carat real not null,
cut integer,
color integer,
clarity integer,
depth real not null,
tbl real not null,
price real not null,
x real not null,
y real not null,
z real not null,
foreign key(cut) references cuts(id),
foreign key(color) references colors(id),
foreign key(clarity) references clarities(id)
);")
dbSendQuery(conn=db,"create index carat_idx ON diamondlistings (carat);")

#check how the tables are doing
dbListTables(conn=db)
#as all seems in place, we need to populate the lookup tables
diamonds %>% select(cut) %>% distinct() %>% dbWriteTable(conn = db, "cuts", value =., append=TRUE, row.names=TRUE)
diamonds %>% select(color) %>% distinct() %>% dbWriteTable(conn = db, "colors", value =., append=TRUE, row.names=TRUE)
diamonds %>% select(clarity) %>% distinct() %>% dbWriteTable(conn = db, "clarities", value =., append=TRUE, row.names=TRUE)
colors<- levels(diamonds$color)
clarities<- levels(diamonds$clarity)
#now we prepare and fill in the diamond data
diamonds %>% mutate(cut=as.character(cut), color=as.character(color), clarity=as.character(clarity))%>% 
        merge(.,dbReadTable(db,"cuts"),by="cut") %>% select(-id) %>%
        merge(.,dbReadTable(db,"colors"),by="color") %>% select(-id) %>%
        merge(.,dbReadTable(db,"clarities"),by="clarity") %>% select(-id) %>% 
        select(carat, cut, color, clarity, depth, table, price, x, y, z) %>%
        dbWriteTable(conn = db, "diamondlistings", value =., append=TRUE, row.names=TRUE)
#car read with dbReadTable(db, "diamondlistings") to make sure it's all there
dbDisconnect(db)
library(bit64)
library(RMariaDB)
library(data.table)

RunSQL <- function (
    SQL = 'select * from Connections;'
    , prepare="set @i := 1;") {
  
  rmariadb.settingsfile <- path.expand('~/R/sql.conf.d/Snowflake.conf')
  
  rmariadb.db <- "Snowflake"
  
  DB <- dbConnect(
    RMariaDB::MariaDB()
    , default.file=rmariadb.settingsfile
    , group=rmariadb.db
    , bigint="numeric"
  )
  dbExecute(DB, prepare)
  rsQuery <- dbSendQuery(DB, SQL)
  dbRows<-dbFetch(rsQuery)
  
  # Clear the result.
  
  dbClearResult(rsQuery)
  
  dbDisconnect(DB)
  
  return(dbRows)
}

ExecSQL <- function (
    SQL 
) {
  
  rmariadb.settingsfile <- path.expand('~/R/sql.conf.d/Snowflake.conf')
  
  rmariadb.db <- "Snowflake"
  
  DB <- dbConnect(
    RMariaDB::MariaDB()
    , default.file=rmariadb.settingsfile
    , group=rmariadb.db
    , bigint="numeric"
  )
  
  count <- dbExecute(DB, SQL)
  
  dbDisconnect(DB)
  
  return (count)
  
}
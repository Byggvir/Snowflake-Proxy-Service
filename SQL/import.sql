use Snowflake;

drop table if exists Snowflake;

create table if not exists `Snowflake` (
  `Zeit` DATETIME,
  `Connections` int(11) NOT NULL DEFAULT 0,
  `Upload` bigint(20) NOT NULL DEFAULT 0,
  `Download` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Zeit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOAD DATA LOCAL 
INFILE '/tmp/snowflake.csv'      
INTO TABLE `Snowflake`
FIELDS TERMINATED BY ';'
IGNORE 0 ROWS;

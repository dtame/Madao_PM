CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `description` varchar(100) NOT NULL,
  `organisation` varchar(50) NOT NULL,
  `url` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `actor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(50) NOT NULL,
  `adresse` varchar(100) NOT NULL,
  `telephone` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `datetb`(
	`datekey` INT NOT NULL AUTO_INCREMENT
	,`date` DATETIME NOT NULL
	,`datename` VARCHAR (50)
	,`month` INT NOT NULL
	,`monthname` VARCHAR (50) NOT NULL
	,`quarter` INT NOT NULL
	,`quartername` VARCHAR (50) NOT NULL
	,`year` INT NOT NULL
	,`yearname` VARCHAR (50) NOT NULL
	, PRIMARY KEY (`datekey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `todo`(
	`id` INT NOT NULL AUTO_INCREMENT
	,`projectid` INT NOT NULL
	,`autorid` INT NOT NULL
	,`nom` VARCHAR(50) NOT NULL
	,`place` VARCHAR(50) NOT NULL
	,`startdate` DATETIME NOT NULL
	,`enddate` DATETIME NOT NULL
	,`priority` VARCHAR(10) NOT NULL
	,`colorcode` VARCHAR(6) NOT NULL
	,`delivrable` VARCHAR(200) NOT NULL 
	, PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE todo ADD FOREIGN KEY (projectid) REFERENCES project(id);
ALTER TABLE todo ADD FOREIGN KEY (autorid) REFERENCES actor(id);


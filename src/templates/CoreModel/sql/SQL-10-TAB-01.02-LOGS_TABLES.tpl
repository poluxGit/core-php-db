-- -----------------------------------------------------
-- Table `CORE_LOGS_DATAEVTS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CORE_LOGS_DATAEVTS` ;

CREATE TABLE IF NOT EXISTS `CORE_LOGS_DATAEVTS` (
  `tid` VARCHAR(30) NOT NULL DEFAULT 'TID-NOTDEF',
  `obj_tid` VARCHAR(30) NOT NULL,
  `message` VARCHAR(400) NOT NULL,
  `cuser` VARCHAR(100) NOT NULL DEFAULT 'NOTDEFINED',
  `ctime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`tid`),
  CONSTRAINT `FK_LOGDTAEVT_USER`
    FOREIGN KEY (`cuser`)
    REFERENCES `CORE_USER_ACCOUNTS` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Data events logs table.';

CREATE INDEX `FK_LOGDTAEVT_USER_idx` ON `CORE_LOGS_DATAEVTS` (`cuser` ASC);

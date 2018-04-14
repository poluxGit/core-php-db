
USE `{$TARGET_SCHEMA}`;

DELIMITER $$

USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_TYPEOBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_TYPEOBJECTS BEFORE INSERT ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN

	DECLARE lStrNewTID VARCHAR(30);
  DECLARE lIntNbRows LONG;

  SELECT count(*) INTO lIntNbRows FROM CORE_TYPEOBJECTS;
  SET lStrNewTID = CONCAT('TYOBJ','-',LPAD(CONVERT(lIntNbRows+1,CHAR),24,'0'));

	SET NEW.tid = lStrNewTID;
  SET NEW.bid = lStrNewTID;
	SET NEW.cuser = CURRENT_USER;
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_TYPEOBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_TYPEOBJECTS AFTER INSERT ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN
	  CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_TYPEOBJECTS');
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_TYPEOBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_TYPEOBJECTS BEFORE UPDATE ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_TYPEOBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_TYPEOBJECTS AFTER UPDATE ON CORE_TYPEOBJECTS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_TYPELINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_TYPELINKS BEFORE INSERT ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	DECLARE lStrTID VARCHAR(30);
	DECLARE lStrObjPrefix VARCHAR(5);
	DECLARE lStrObjSrcPrefix VARCHAR(5);
	DECLARE lStrObjDstPrefix VARCHAR(5);
	DECLARE lStrNewBID VARCHAR(50);

  SELECT CORE_GenNewTIDForTable('CORE_TYPELINKS') INTO lStrTID;

	SELECT obj_prefix INTO lStrObjPrefix
	FROM CORE_TYPEOBJECTS WHERE obj_tablename = 'CORE_TYPELINKS';

	SELECT obj_prefix INTO lStrObjSrcPrefix
	FROM CORE_TYPEOBJECTS WHERE tid = NEW.typobj_src;

	SELECT obj_prefix INTO lStrObjDstPrefix
	FROM CORE_TYPEOBJECTS WHERE tid = NEW.typobj_dst;

	SET NEW.bid = CONCAT(lStrObjPrefix,'-',lStrObjSrcPrefix,'_',lStrObjDstPrefix);
	SET NEW.tid = lStrTID;
  SET NEW.cuser = CURRENT_USER;
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_TYPELINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_TYPELINKS AFTER INSERT ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_TYPELINKS');
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_TYPELINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_TYPELINKS BEFORE UPDATE ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_TYPELINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_TYPELINKS AFTER UPDATE ON CORE_TYPELINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_ATTRDEFS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_ATTRDEFS BEFORE INSERT ON CORE_ATTRDEFS FOR EACH ROW
BEGIN
	DECLARE lStrTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('CORE_ATTRDEFS') INTO lStrTID;

	IF NEW.bid IS NULL THEN
  	SET NEW.bid = lStrTID;
	END IF;
	SET NEW.tid = lStrTID;
  SET NEW.cuser = CURRENT_USER;
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_ATTRDEFS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_ATTRDEFS AFTER INSERT ON CORE_ATTRDEFS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_ATTRDEFS');
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_ATTRDEFS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_ATTRDEFS BEFORE UPDATE ON `CORE_ATTRDEFS` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_ATTRDEFS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_ATTRDEFS AFTER UPDATE ON `CORE_ATTRDEFS` FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_ATTROBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_ATTROBJECTS BEFORE INSERT ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	DECLARE lStrTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('CORE_ATTROBJECTS') INTO lStrTID;

	SET NEW.tid = lStrTID;
	IF NEW.bid IS NULL THEN
  	SET NEW.bid = lStrTID;
	END IF;
  SET NEW.cuser = CURRENT_USER;
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_ATTROBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_ATTROBJECTS AFTER INSERT ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
    CALL CORE_RegisterNewTID(NEW.tid,'CORE_ATTROBJECTS');
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_ATTROBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_ATTROBJECTS BEFORE UPDATE ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
    SET NEW.utime = NOW();
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_ATTROBJECTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_ATTROBJECTS AFTER UPDATE ON `CORE_ATTROBJECTS` FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_LOGS_DATAEVTS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_LOGS_DATAEVTS BEFORE INSERT ON CORE_LOGS_DATAEVTS FOR EACH ROW
BEGIN

	DECLARE lIntNbLogs BIGINT;
	SELECT COUNT(tid) INTO lIntNbLogs FROM CORE_LOGS_DATAEVTS WHERE YEAR(ctime) = YEAR(NOW());
	SET NEW.tid = CONCAT('LDEVT-',CONVERT(YEAR(NOW()),CHAR),'-',LPAD(CONVERT(lIntNbLogs+1,CHAR),19,'0'));
	SET NEW.cuser = CURRENT_USER;
END$$

USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFINSERT_CORE_LINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFINSERT_CORE_LINKS BEFORE INSERT ON CORE_LINKS FOR EACH ROW
BEGIN
	DECLARE lStrNewTID VARCHAR(30);
  SELECT CORE_GenNewTIDForTable('CORE_LINKS') INTO lStrNewTID ;
	SET NEW.tid = lStrNewTID;
	IF NEW.bid IS NULL THEN
  	SET NEW.bid = lStrNewTID;
	END IF;
	SET NEW.CUSER = CURRENT_USER;
END$$

USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTINSERT_CORE_LINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTINSERT_CORE_LINKS AFTER INSERT ON CORE_LINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Insert(NEW.tid);
  CALL CORE_RegisterNewTID(NEW.tid,'CORE_LINKS');
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_BEFUPDATE_CORE_LINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_BEFUPDATE_CORE_LINKS BEFORE UPDATE ON CORE_LINKS FOR EACH ROW
BEGIN
	SET NEW.uuser = CURRENT_USER;
  SET NEW.utime = NOW();
END$$


USE `{$TARGET_SCHEMA}`$$
DROP TRIGGER IF EXISTS `TRIG_AFTUPDATE_CORE_LINKS` $$
USE `{$TARGET_SCHEMA}`$$
CREATE DEFINER = CURRENT_USER TRIGGER TRIG_AFTUPDATE_CORE_LINKS AFTER UPDATE ON CORE_LINKS FOR EACH ROW
BEGIN
	CALL LOGS_LogDataEvent_Update(NEW.tid);
END$$


























DELIMITER ;

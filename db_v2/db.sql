USE sys;
DROP DATABASE IF EXISTS cashcoin;

CREATE DATABASE cashcoin;
USE cashcoin;

CREATE TABLE clients (
	cuuid VARCHAR(16) NOT NULL UNIQUE PRIMARY KEY,
    fname VARCHAR(25) NOT NULL,
    lname VARCHAR(45) NOT NULL,
    ouccupation VARCHAR(50) NOT NULL,
    ccd DATETIME NOT NULL DEFAULT current_timestamp
);

CREATE TABLE addresses (
	adduuid VARCHAR(16) NOT NULL UNIQUE PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(35) NOT NULL,
    state VARCHAR(35) NOT NULL,
    street VARCHAR(50) NOT NULL,
    bnumber INT NOT NULL,
    cp VARCHAR(12) NOT NULL
);

CREATE TABLE accounts (
	auuid VARCHAR(16) NOT NULL UNIQUE PRIMARY KEY,
    cuuid VARCHAR(16) NOT NULL UNIQUE,
    adduuid VARCHAR(16) NOT NULL UNIQUE,
    email VARCHAR(50) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    pass VARCHAR(64) NOT NULL,
    balance DOUBLE NOT NULL,
    acd DATETIME NOT NULL DEFAULT current_timestamp,
    astatus VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',
    CONSTRAINT `fk_client_account` FOREIGN KEY (`cuuid`) REFERENCES `clients` (`cuuid`),
    CONSTRAINT `fk_address_account` FOREIGN KEY (`adduuid`) REFERENCES `addresses` (`adduuid`)
);

CREATE TABLE txnslocations (
	tluuid VARCHAR(16) NOT NULL UNIQUE PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(35) NOT NULL,
    state VARCHAR(35) NOT NULL,
    lat DOUBLE NOT NULL,
    lon DOUBLE NOT NULL
);

CREATE TABLE transactions (
	tuuid VARCHAR(16) NOT NULL UNIQUE PRIMARY KEY,
    tluuid VARCHAR(16) NOT NULL UNIQUE,
    ttype VARCHAR(25) NOT NULL,
    auuid VARCHAR(16) NOT NULL,
    refdata VARCHAR(50) NOT NULL,
    amount DOUBLE NOT NULL,
    clas TINYINT NOT NULL, 
    dot DATETIME NOT NULL DEFAULT current_timestamp,
    concept VARCHAR(25),
    CONSTRAINT `fk_transaction_location` FOREIGN KEY (`tluuid`) REFERENCES `txnslocations` (`tluuid`),
    CONSTRAINT `fk_account_transaction` FOREIGN KEY (`auuid`) REFERENCES `accounts` (`auuid`)
);
####################################################CLIENT METHODS##################################################
##--------------------------------------------------------------------FUNCTIONS
 DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_auth`(
	p_email VARCHAR(50),
    p_phone VARCHAR(15),
    p_pass VARCHAR(16)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	IF p_email != '' AND p_phone = '' THEN
		RETURN EXISTS(SELECT
			accounts.email
		FROM accounts 
		WHERE accounts.email = p_email AND accounts.pass = SHA2(p_pass, 256));
	ELSEIF p_email = '' AND p_phone != '' THEN
		RETURN EXISTS(SELECT
			accounts.phone
		FROM user_account 
		WHERE accounts.phone = p_phone AND accounts.pass = SHA2(p_pass, 256));
	END IF;
END$$
DELIMITER ;

##--------------------------------------------------------------------ACCOUNT RELATED SP
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_auth_user`(
    IN p_email VARCHAR(50),
    IN p_phone VARCHAR(15),
    IN p_pass VARCHAR(16)
)
BEGIN
	DECLARE auth BOOL;
    SELECT `cashcoin`.`fn_auth`(p_email, p_phone, p_pass) INTO auth;
    
    IF auth = FALSE THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BAD REQUEST';
    END IF;
    SELECT * FROM accounts WHERE accounts.email = p_email;
    
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_account`(
	IN p_auuid VARCHAR(16),
    IN p_cuuid VARCHAR(16),
    IN p_adduuid VARCHAR(16),
    IN p_email VARCHAR(50),
    IN p_phone VARCHAR(15),
    IN p_pass VARCHAR(16),
    IN p_balance DOUBLE,
    IN p_city VARCHAR(35),
    IN p_state VARCHAR(35),
    IN p_street VARCHAR(50),
    IN p_bnumber INT,
    IN p_cp VARCHAR(12),
    IN p_country VARCHAR(50),
    IN p_fname VARCHAR(25),
    IN p_lname VARCHAR(45),
    IN p_ouccupation VARCHAR(50)
)
BEGIN
	INSERT INTO `cashcoin`.`addresses`(`adduuid`,`city`,`state`,`street`,`bnumber`,`cp`, `country`)
		VALUES(p_adduuid,p_city,p_state,p_street,p_bnumber,p_cp, p_country);
	INSERT INTO `cashcoin`.`clients`(`cuuid`,`fname`,`lname`,`ouccupation`,`ccd`)
		VALUES(p_cuuid,p_fname,p_lname,p_ouccupation);
	INSERT INTO `cashcoin`.`accounts`(`auuid`,`cuuid`,`adduuid`,`email`,`phone`,`pass`,`balance`,`acd`)
		VALUES(p_auuid,p_cuuid,p_adduuid,p_email,p_phone, SHA2(p_pass, 256),p_balance);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_delete_account`(
    IN p_email VARCHAR(50),
    IN p_phone VARCHAR(15),
    IN p_pass VARCHAR(16)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE p_cuuid VARCHAR(16);
    DECLARE p_adduuid VARCHAR(16);
    
    SELECT `cashcoin`.`fn_auth`(p_email, p_phone, p_pass) INTO auth;
    
    IF auth = FALSE THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BAD REQUEST';
    END IF;
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;
    
    SELECT cuuid INTO p_cuuid FROM accounts WHERE auuid = p_auuid;
    SELECT adduuid INTO p_adduuid FROM accounts WHERE auuid = p_auuid;
    
    DELETE FROM addresses WHERE adduuid = p_adduuid;
    DELETE FROM clients WHERE cuuid = p_cuuid;
    DELETE FROM accounts WHERE auuid = p_auuid;
    
END$$
DELIMITER 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_astatus`(
    IN p_email VARCHAR(50),
    IN p_phone VARCHAR(15),
    IN p_status VARCHAR(10)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;
    
    IF p_status = '' THEN
		SELECT astatus INTO p_status FROM accounts WHERE auuid = p_auuid;
	END IF;
    
    UPDATE accounts SET
		astatus = p_status
	WHERE accounts.auuid = p_auuid;
    
    
END$$
DELIMITER 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_account`(
    IN p_email VARCHAR(50),
    IN p_nemail VARCHAR(50),
    IN p_nphone VARCHAR(15),
    IN p_phone VARCHAR(15),
    IN p_pass VARCHAR(16)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE current_email VARCHAR(50);
    DECLARE current_phone VARCHAR(15);
    
    SELECT `cashcoin`.`fn_auth`(p_email, p_phone, p_pass) INTO auth;
    
    IF auth = FALSE THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BAD REQUEST';
    END IF;
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;
    
    IF p_nemail = '' THEN
		SELECT email INTO p_nemail FROM accountes WHERE accounts.auuid = p_auuid;
	END IF;
    IF p_nphone = '' THEN
		SELECT phone INTO p_nphone FROM accountes WHERE accounts.auuid = p_auuid;
	END IF;
    
    UPDATE accounts SET
		email = p_nemail,
        phone = p_nphone
	WHERE auuid = p_auuid;
    
END$$
DELIMITER 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_address`(
    IN p_email VARCHAR(50),
	IN p_phone VARCHAR(15),
    IN p_city VARCHAR(35),
    IN p_state VARCHAR(35),
    IN p_street VARCHAR(50),
    IN p_bnumber INT,
    IN p_cp VARCHAR(12)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE p_adduuid VARCHAR(16);
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;
    SELECT adduuid INTO p_adduuid FROM accounts WHERE auuid = p_auuid;
    
    IF p_city = '' THEN
		SELECT city INTO p_city FROM addresses WHERE addresses.adduuid = p_adduuid;
	END IF;
    IF p_state = '' THEN
		SELECT state INTO p_state FROM addresses WHERE addresses.state = p_state;
	END IF;
	IF p_street = '' THEN
		SELECT street INTO p_street FROM addresses WHERE addresses.street = p_street;
	END IF;
	IF p_bnumber = '' THEN
		SELECT bnumber INTO p_bnumber FROM addresses WHERE addresses.bnumber = p_bnumber;
	END IF;
	IF p_cp = '' THEN
		SELECT cp INTO p_cp FROM addresses WHERE addresses.cp = p_cp;
	END IF;
    
    
	UPDATE `cashcoin`.`addresses` SET
		`city` = p_city,
		`state` = p_state,
		`street` = p_street,
		`bnumber` = p_bnumber,
		`cp` = p_cp
	WHERE `adduuid` = p_adduuid;

    
END$$
DELIMITER 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_password`(
    IN p_email VARCHAR(50),
	IN p_phone VARCHAR(15),
	IN p_pass VARCHAR(16),
	IN p_npass VARCHAR(16)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE p_adduuid VARCHAR(16);
    
	IF p_npass = '' THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BAD REQUEST';
    END IF;
    
    SELECT `cashcoin`.`fn_auth`(p_email, p_phone, p_pass) INTO auth;
    
    IF auth = FALSE THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BAD REQUEST';
    END IF;
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;
    
	UPDATE `cashcoin`.`accounts` SET
		`pass` = p_npass
	WHERE `auuid` = p_auuid;

    
END$$
DELIMITER 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_client`(
    IN p_email VARCHAR(50),
	IN p_phone VARCHAR(15),
	IN p_fname VARCHAR(25),
    IN p_lname VARCHAR(45),
    IN p_ouccupation VARCHAR(50)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE p_cuuid VARCHAR(16);
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;
    
    SELECT cuuid INTO p_cuuid FROM accounts WHERE auuid = p_auuid;
    
    IF p_fname = '' THEN
		SELECT fname INTO p_fname FROM clients WHERE `cuuid` = p_cuuid;
    END IF;
    IF p_lname = '' THEN
		SELECT lname INTO p_lname FROM clients WHERE `cuuid` = p_cuuid;
    END IF;
    IF p_ouccupation = '' THEN
		SELECT ouccupation INTO p_ouccupation FROM clients WHERE `cuuid` = p_cuuid;
    END IF;
    
	UPDATE `cashcoin`.`clients`
	SET
	`fname` = p_fname,
	`lname` = p_lname,
	`ouccupation` = p_ouccupation
	WHERE `cuuid` = p_cuuid;


    
END$$
DELIMITER 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_user`(
    IN p_email VARCHAR(50),
	IN p_phone VARCHAR(15)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE p_cuuid VARCHAR(16);
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;
    
    SELECT cuuid INTO p_cuuid FROM accounts WHERE auuid = p_auuid;

    SELECT
		accounts.auuid,
        accounts.email,
        accounts.phone,
        accounts.balance,
        accounts.astatus,
        clients.fname,
        clients.lname,
        addresses.city,
        addresses.state,
        addresses.country
    FROM accounts
    JOIN addresses ON accounts.adduuid = addresses.adduuid
    JOIN clients ON accounts.cuuid = clients.cuuid
    WHERE auuid = p_auuid;
END$$
DELIMITER 
##--------------------------------------------------------------------TRANSACTION RELATED SP
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_txn`(
	IN p_email VARCHAR(50),
    IN p_phone VARCHAR(15),
    IN p_pass VARCHAR(16),
    IN p_tuuid VARCHAR(16),
    IN p_tluuid VARCHAR(16),
    IN p_ttype VARCHAR(25),
    IN p_refdata VARCHAR(50),
    IN p_amount DOUBLE,
    IN p_clas TINYINT,
    IN p_concept VARCHAR(25),
    IN p_country VARCHAR(50),
    IN p_city VARCHAR(35),
    IN p_state VARCHAR(35),
    IN p_lat DOUBLE,
    IN p_lon DOUBLE
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE p_cuuid VARCHAR(16);
    
	SELECT `cashcoin`.`fn_auth`(p_email, p_phone, p_pass) INTO auth;
    
    IF auth = FALSE THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BAD REQUEST';
    END IF;
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;

    INSERT INTO `cashcoin`.`txnslocations`(`tluuid`,`city`,`state`,`lat`,`lon`, `country`)
		VALUES(p_tluuid,p_city,p_state,p_lat,p_lon, p_country);
	INSERT INTO `cashcoin`.`transactions`(`tuuid`,`tluuid`,`ttype`,`auuid`,`clas`,`refdata`,`amount`,`dot`,`concept`)
		VALUES(p_tuuid,p_tluuid,p_ttype,p_clas,p_refdata,p_refdata,p_amount,p_concept);


END$$
DELIMITER 

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_txns`(
	IN p_email VARCHAR(50),
    IN p_phone VARCHAR(15)
)
BEGIN
	DECLARE auth BOOL;
    DECLARE p_auuid VARCHAR(16);
    DECLARE p_cuuid VARCHAR(16);
    
	SELECT `cashcoin`.`fn_auth`(p_email, p_phone, p_pass) INTO auth;
    
    IF auth = FALSE THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'BAD REQUEST';
    END IF;
    
	IF p_email != '' AND p_phone = '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE email = p_email;
	ELSEIF p_email = '' AND p_phone != '' THEN
		SELECT auuid INTO p_auuid FROM accounts WHERE phone = p_phone;
	END IF;

    SELECT
		transactions.tuuid,
        transactions.ttype,
        transactions.refdata,
        transactions.amount,
        transactions.clas,
        transactions.dot,
        transactions.concept,
        txnslocations.state,
        txnslocations.country
    FROM transactions
    JOIN txnslocations ON transactions.tluuid = txnslocations.tluuid
    WHERE transactions.auuid = p_auuid;


END$$
DELIMITER 
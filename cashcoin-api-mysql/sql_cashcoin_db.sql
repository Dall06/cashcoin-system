USE sys;

DROP DATABASE db_cashcoin;

CREATE DATABASE db_cashcoin;

USE db_cashcoin;

CREATE TABLE `user_account` (
  `user_account_id` int NOT NULL AUTO_INCREMENT,
  `user_account_email` varchar(100) NOT NULL,
  `user_account_password` varchar(120) NOT NULL,
  `user_account_phone` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`user_account_id`),
  UNIQUE KEY `user_account_id` (`user_account_id`),
  UNIQUE KEY `user_account_email` (`user_account_email`),
  UNIQUE KEY `user_account_phone` (`user_account_phone`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `user_data` (
  `user_data_id` int NOT NULL AUTO_INCREMENT,
  `user_data_name` varchar(100) NOT NULL,
  `user_data_lastname` varchar(100) NOT NULL,
  `user_data_code` varchar(100) NOT NULL,
  `user_data_balance` double NOT NULL DEFAULT '0',
  `user_account_id` int NOT NULL,
  PRIMARY KEY (`user_data_id`),
  UNIQUE KEY `user_data_id` (`user_data_id`),
  UNIQUE KEY `user_data_code` (`user_data_code`),
  KEY `user_account_id` (`user_account_id`),
  CONSTRAINT `user_data_ibfk_1` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`user_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `transaction_type` (
  `transaction_type_id` int NOT NULL AUTO_INCREMENT,
  `transaction_type_desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`transaction_type_id`),
  UNIQUE KEY `transaction_type_id` (`transaction_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transaction_order` (
  `transaction_order_id` int NOT NULL AUTO_INCREMENT,
  `transaction_order_qty` double NOT NULL,
  `transaction_order_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transaction_type_id` int NOT NULL,
  PRIMARY KEY (`transaction_order_id`),
  UNIQUE KEY `transaction_order_id` (`transaction_order_id`),
  KEY `transaction_type_id` (`transaction_type_id`),
  CONSTRAINT `transaction_order_ibfk_1` FOREIGN KEY (`transaction_type_id`) REFERENCES `transaction_type` (`transaction_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `transaction_detail` (
  `transaction_detail_id` int NOT NULL AUTO_INCREMENT,
  `transaction_detail_destination` varchar(100) NOT NULL,
  `transaction_detail_origin` varchar(100) NOT NULL,
  `transaction_detail_concept` varchar(100) DEFAULT NULL,
  `transaction_order_id` int NOT NULL,
  PRIMARY KEY (`transaction_detail_id`),
  UNIQUE KEY `transaction_detail_id` (`transaction_detail_id`),
  KEY `transaction_detail_destination` (`transaction_detail_destination`),
  KEY `transaction_detail_origin` (`transaction_detail_origin`),
  KEY `transaction_order_id` (`transaction_order_id`),
  CONSTRAINT `transaction_detail_ibfk_1` FOREIGN KEY (`transaction_detail_destination`) REFERENCES `user_data` (`user_data_code`),
  CONSTRAINT `transaction_detail_ibfk_2` FOREIGN KEY (`transaction_detail_origin`) REFERENCES `user_data` (`user_data_code`),
  CONSTRAINT `transaction_detail_ibfk_3` FOREIGN KEY (`transaction_order_id`) REFERENCES `transaction_order` (`transaction_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `transaction_user` (
  `transaction_user_type_id` int NOT NULL AUTO_INCREMENT,
  `user_data_id` int NOT NULL,
  `transaction_detail_id` int NOT NULL,
  `transaction_user_type` varchar(25) NOT NULL,
  `transaction_user_status` int NOT NULL,
  PRIMARY KEY (`transaction_user_type_id`),
  UNIQUE KEY `transaction_user_type_id` (`transaction_user_type_id`),
  KEY `user_data_id` (`user_data_id`),
  KEY `transaction_detail_id` (`transaction_detail_id`),
  CONSTRAINT `transaction_user_ibfk_1` FOREIGN KEY (`user_data_id`) REFERENCES `user_data` (`user_data_id`),
  CONSTRAINT `transaction_user_ibfk_2` FOREIGN KEY (`transaction_detail_id`) REFERENCES `transaction_detail` (`transaction_detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

##------------------------SP
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_transactiontype`(
	IN p_transaction_type_desc VARCHAR(50)
)
BEGIN
	INSERT INTO `db_cashcoin`.`transaction_type`(
		`transaction_type_desc`
	) VALUES (
		p_transaction_type_desc
	);
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_insert_user`(
	IN p_user_account_email VARCHAR(100),
    IN p_user_account_password VARCHAR(120),
    IN p_user_account_phone VARCHAR(25),
    IN p_user_data_name VARCHAR(100),
    IN p_user_data_lastname VARCHAR(100),
    IN p_user_data_code VARCHAR(100)
)
BEGIN
	INSERT INTO `db_cashcoin`.`user_account` (
		`user_account_email`,
		`user_account_password`,
		`user_account_phone`
    ) VALUES (
		p_user_account_email,
		SHA2(p_user_account_password, 256),
		p_user_account_phone
    );
    SET @last_id = LAST_INSERT_ID();
	INSERT INTO `db_cashcoin`.`user_data` (
		`user_data_name`,
		`user_data_lastname`,
		`user_data_code`,
		`user_account_id`
	)
	VALUES (
		p_user_data_name,
		p_user_data_lastname,
		p_user_data_code,
		@last_id
    );
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_make_transaction`(
	IN p_transaction_order_qty DOUBLE,
    IN p_transaction_type_id INT,
	IN p_concept VARCHAR(100),
    IN p_to TEXT,
    IN p_from TEXT
)
BEGIN
	DECLARE balanceTo DOUBLE;
    DECLARE balanceFrom DOUBLE;
    DECLARE totalTo DOUBLE;
    DECLARE totalFrom DOUBLE;
    DECLARE toId INT;
    DECLARE fromId INT;

	INSERT INTO `db_cashcoin`.`transaction_order`(
		`transaction_order_qty`,
		`transaction_type_id`
	)
	VALUES(
		p_transaction_order_qty,
		p_transaction_type_id
	);
    SET @last_id = LAST_INSERT_ID();
    INSERT INTO `db_cashcoin`.`transaction_detail`(
		`transaction_detail_destination`,
		`transaction_detail_origin`,
		`transaction_detail_concept`,
		`transaction_order_id`
	)
	VALUES(
		p_to,
		p_from,
		p_concept,
		@last_id
	);
    SET @last_id = LAST_INSERT_ID();
    
    SELECT user_data_balance INTO balanceTo FROM user_data WHERE user_data_code = p_to;
    SELECT user_data_balance INTO balanceFrom FROM user_data WHERE user_data_code = p_from;
    SELECT user_data_id INTO toId FROM user_data WHERE user_data_code = p_to;
    SELECT user_data_id INTO fromId FROM user_data WHERE user_data_code = p_from;
    
    SET totalTo := p_transaction_order_qty + balanceTo;
	SET totalFrom := balanceFrom - p_transaction_order_qty;
    
    IF balanceFrom > 0 THEN
		UPDATE `db_cashcoin`.`user_data`
		SET
			`user_data_balance` = totalTo
		WHERE `user_data_code` = p_to;
		
		UPDATE `db_cashcoin`.`user_data`
		SET
			`user_data_balance` = totalFrom
		WHERE `user_data_code` = p_from;
        
        INSERT INTO `db_cashcoin`.`transaction_user`
		(
			`user_data_id`,
			`transaction_detail_id`,
			`transaction_user_type`,
            `transaction_user_status`
		) VALUES (
			toId,
			@last_id,
			'Deposit',
            1
		);
        
		INSERT INTO `db_cashcoin`.`transaction_user`
		(
			`user_data_id`,
			`transaction_detail_id`,
			`transaction_user_type`,
            `transaction_user_status`
		) VALUES (
			fromId,
			@last_id,
			'Transfer',
            1
		);

        
	END IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_transactionuser_by_code`(
	IN p_code VARCHAR(100)
)
BEGIN
	SELECT
		transaction_user.transaction_user_type,
		transaction_detail.transaction_detail_destination,
		transaction_detail.transaction_detail_origin,
		transaction_detail.transaction_detail_concept,
		transaction_order.transaction_order_qty,
		transaction_order.transaction_order_date,
		transaction_type.transaction_type_desc
	FROM transaction_user
	JOIN transaction_detail ON transaction_detail.transaction_detail_id = transaction_user.transaction_detail_id
	JOIN transaction_order ON transaction_order.transaction_order_id = transaction_detail.transaction_order_id
	JOIN transaction_type ON transaction_type.transaction_type_id = transaction_order.transaction_type_id
	WHERE transaction_detail.transaction_detail_destination = p_code OR transaction_detail.transaction_detail_origin = p_code;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_select_user`(
	IN p_email VARCHAR(50)
)
BEGIN
SELECT
		user_data.user_data_id,
		user_data.user_data_name,
		user_data.user_data_lastname,
		user_data.user_data_code,
		user_data.user_data_balance,
		user_account.user_account_id,
		user_account.user_account_email,
		user_account.user_account_phone
		FROM db_cashcoin.user_data
		INNER JOIN user_account ON user_data.user_account_id = user_account.user_account_id WHERE user_account.user_account_email = p_email;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user`(
	IN p_user_current_email VARCHAR(100),
	IN p_user_account_email VARCHAR(100),
    IN p_user_account_phone VARCHAR(25),
	IN p_user_data_name VARCHAR(100),
    IN p_user_data_lastname VARCHAR(100)
)
BEGIN
	DECLARE dataName VARCHAR(100);
    DECLARE dataLastName VARCHAR(100);
	DECLARE accountId INT;
	DECLARE email VARCHAR(100);
    DECLARE phone VARCHAR(25);
    
    SELECT user_account_id INTO accountId FROM user_account WHERE user_account_email = p_user_current_email;
    
    # NAME VALIDATION
    IF p_user_data_name = '' THEN
		SELECT user_data_name INTO dataName FROM user_data WHERE user_account_id = accountId;
	ELSE
		SET dataName := p_user_data_name;
	END IF;
    
    # LAST NAME VALIDATION
    IF p_user_data_lastname = '' THEN
		SELECT user_data_lastname INTO dataLastName FROM user_data WHERE user_account_id = accountId;
	ELSE
		SET dataLastName := p_user_data_lastname;
	END IF;
    
	# EMAIL VALIDATION
	IF p_user_account_email = '' THEN
		SELECT user_account_email INTO email FROM user_account WHERE user_account_id = accountId;
	ELSE
		SET email := p_user_account_email;
	END IF;
    
    # PHONE VALIDATION
	IF p_user_account_phone = '' THEN
		SELECT user_account_phone INTO phone FROM user_account WHERE user_account_id = accountId;
	ELSE
		SET phone := p_user_account_phone;
	END IF;
    
    UPDATE `db_cashcoin`.`user_data`
	SET
		`user_data_name` = dataName,
		`user_data_lastname` = dataLastName
	WHERE `user_account_id` = accountId;

    UPDATE `db_cashcoin`.`user_account` SET
		`user_account_email` = email,
        `user_account_phone` = phone
	WHERE `user_account_email` = p_user_current_email AND `user_account_id` = accountId;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_update_user_pass`(
	IN p_user_current_email VARCHAR(100),
	IN p_user_account_password VARCHAR(50),
    IN p_user_new_password VARCHAR(50)
)
BEGIN
	DECLARE isAuthenticated BOOL;
    
    select db_cashcoin.fn_athenticate_credentials(p_user_current_email, p_user_account_password) INTO isAuthenticated;
	
	# EMAIL VALIDATION
	IF isAuthenticated = 0 THEN
		SELECT 'No CREDENTIALS ALLOWED';
	ELSEIF isAuthenticated = 1 AND p_user_new_password != '' THEN
		UPDATE `db_cashcoin`.`user_account`
			SET
			`user_account_password` = SHA2(p_user_new_password, 256)
			WHERE `user_account_email` = p_user_current_email;
	ELSE
		SELECT 'No update pass Allowed';
	END IF;
END$$
DELIMITER ;


##---------------------FUNCTIONS
DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `fn_athenticate_credentials`(
p_email VARCHAR(100), 
p_pass VARCHAR(100)
) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
	RETURN EXISTS (SELECT
		user_account.user_account_email
	FROM user_Account WHERE user_account.user_account_email = p_email AND user_account.user_account_password = SHA2(p_pass, 256));
END$$
DELIMITER ;




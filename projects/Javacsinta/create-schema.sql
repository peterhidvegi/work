CREATE TABLE pancake (
	pancake_id INTEGER NOT NULL,
	pancake_name CHARACTER VARYING(100) NOT NULL,
	pancake_price INTEGER NOT NULL,
	pancake_description CHARACTER VARYING(100),
	CONSTRAINT PK_PANCAKE_ID PRIMARY KEY (pancake_id)
);

ALTER TABLE pancake OWNER TO postgres;

CREATE TABLE address (
	address_id INTEGER NOT NULL,
	address_postcode INTEGER NOT NULL,
	address_street CHARACTER VARYING(100) NOT NULL,
	address_door CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT PK_ADDRESS_ID PRIMARY KEY (address_id)
	
);

ALTER TABLE address OWNER TO postgres;

CREATE TABLE payment_method (
	payment_method_id INTEGER NOT NULL,
	payment_method_description CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT PK_PAYMENT_METHOD_ID PRIMARY KEY (payment_method_id)
	
);

ALTER TABLE payment_method OWNER TO postgres;

CREATE TABLE customer (
	customer_id INTEGER NOT NULL,
	customer_address_id INTEGER NOT NULL,
	customer_payment_method_id INTEGER NOT NULL,
	customer_name CHARACTER VARYING(100) NOT NULL,
	customer_phone CHARACTER VARYING(100) NOT NULL,
	customer_email CHARACTER VARYING(100) NOT NULL,
	customer_other_details CHARACTER VARYING(100),
	CONSTRAINT PK_CUSTOMER_ID PRIMARY KEY (customer_id),
	CONSTRAINT FK_CUSTOMER_ADDRESS FOREIGN KEY (customer_address_id)
	  REFERENCES address (address_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT FK_CUSTOMER_PAYMENT_METHOD FOREIGN KEY (customer_payment_method_id)
	  REFERENCES payment_method (payment_method_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT
);

ALTER TABLE customer OWNER TO postgres;

CREATE TABLE employee (
	employee_id INTEGER NOT NULL,
	employee_address_id INTEGER NOT NULL,
	employee_name CHARACTER VARYING(100) NOT NULL,
	employee_phone CHARACTER VARYING(100) NOT NULL,
	employee_other_details CHARACTER VARYING(100),
	CONSTRAINT PK_EMPLOYEE_ID PRIMARY KEY (employee_id),
	CONSTRAINT FK_EMPLOYEE_ADDRESS FOREIGN KEY (employee_address_id)
	  REFERENCES address (address_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT
);

ALTER TABLE employee OWNER TO postgres;

CREATE TABLE delivery_status (
	delivery_status_id INTEGER NOT NULL,
	delivery_status_description CHARACTER VARYING(100) NOT NULL,
	CONSTRAINT PK_DELIVERY_STATUS_ID PRIMARY KEY (delivery_status_id)
	
);

ALTER TABLE delivery_status OWNER TO postgres;



CREATE TABLE order_master (
	order_master_id INTEGER NOT NULL,
	order_master_customer_id INTEGER NOT NULL,
	order_master_employee_id INTEGER NOT NULL,
	order_master_delivery_status_id INTEGER NOT NULL,
	order_master_total_price REAL NOT NULL,
	CONSTRAINT PK_ORDER_MASTER_ID PRIMARY KEY (order_master_id),
	CONSTRAINT FK_ORDER_MASTER_CUSTOMER FOREIGN KEY (order_master_customer_id)
	  REFERENCES customer (customer_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT FK_ORDER_MASTER_EMPLOYEE FOREIGN KEY (order_master_employee_id)
	  REFERENCES employee (employee_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT FK_ORDER_MASTER_DELIVERY FOREIGN KEY (order_master_delivery_status_id)
	  REFERENCES delivery_status (delivery_status_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT
);

ALTER TABLE order_master OWNER TO postgres;

CREATE TABLE order_detail (
	order_detail_id INTEGER NOT NULL,
	order_detail_pancake_id INTEGER NOT NULL,
	order_detail_order_master_id INTEGER NOT NULL,
	order_detail_amount INTEGER NOT NULL,
	order_detail_total_price REAL NOT NULL,
	CONSTRAINT PK_ORDER_DETAIL_ID PRIMARY KEY (order_detail_id),
	CONSTRAINT FK_ORDER_DETAIL_PANCAKE FOREIGN KEY (order_detail_pancake_id)
	  REFERENCES pancake (pancake_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT,
	CONSTRAINT FK_ORDER_DETAIL_MASTER FOREIGN KEY (order_detail_order_master_id)
	  REFERENCES order_master (order_master_id) MATCH SIMPLE ON UPDATE RESTRICT ON DELETE RESTRICT
);

ALTER TABLE order_detail OWNER TO postgres;

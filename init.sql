-- Create DATABASE
CREATE DATABASE ntutdb;

-- MEMBER
CREATE TABLE IF NOT EXISTS MEMBER (
    id INT,
    token VARCHAR(64),
    authority VARCHAR(20),
    username VARCHAR(25),
    nickname VARCHAR(25),
    phone VARCHAR(20),
    email VARCHAR(50),
    certificated TINYINT,
    permission TINYINT,
    register_time TIMESTAMP,
    PRIMARY KEY (id)
);

-- GOOD
CREATE TABLE IF NOT EXISTS GOOD (
    id INT,
    member_id INT,
    name VARCHAR(200),
    stock INT,
    price INT,
    description VARCHAR(2000),
    durability TINYINT,
    state TINYINT,
    publish_time TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES MEMBER(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- RATE
CREATE TABLE IF NOT EXISTS RATE (
    source_id INT,
    target_id INT,
    stars TINYINT,
    comment VARCHAR(400),
    time TIMESTAMP,
    PRIMARY KEY (source_id, source_id),
    FOREIGN KEY (source_id) REFERENCES MEMBER(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (target_id) REFERENCES MEMBER(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- MESSAGE_BOARD
CREATE TABLE IF NOT EXISTS MESSAGE_BOARD (
    id INT,
    source_id INT,
    good_id INT,
    content VARCHAR(800),
    PRIMARY KEY (id),
    FOREIGN KEY (source_id) REFERENCES MEMBER(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (good_id) REFERENCES GOOD(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- SHOPPING_CART
CREATE TABLE IF NOT EXISTS SHOPPING_CART (
    id INT,
    member_id INT,
    quantity INT,
    good_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (member_id) REFERENCES MEMBER(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (good_id) REFERENCES GOOD(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- SHIPPING
CREATE TABLE IF NOT EXISTS SHIPPING (
    id INT,
    service VARCHAR(40),
    fee INT,
    good_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (good_id) REFERENCES GOOD(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- PAYMENT
CREATE TABLE IF NOT EXISTS PAYMENT (
    id INT,
    good_id INT,
    service VARCHAR(40),
    PRIMARY KEY (id),
    FOREIGN KEY (good_id) REFERENCES GOOD(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ORDER
CREATE TABLE IF NOT EXISTS ORDER (
    id INT,
    member_id INT,
    shipping_id INT,
    payment_id INT,
    state TINYINT,
    transaction_time TIMESTAMP,
    PRIMARY KEY (id),
     FOREIGN KEY (member_id) REFERENCES MEMBER(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (shipping_id) REFERENCES SHIPPING(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES PAYMENT(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- ORDER_GOOD
CREATE TABLE IF NOT EXISTS ORDER_GOOD (
    good_id INT,
    order_id INT,
    quantity INT,
    PRIMARY KEY (good_id, order_id),
    FOREIGN KEY (good_id) REFERENCES GOOD(id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES ORDER(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- TAG
CREATE TABLE IF NOT EXISTS TAG (
    good_id INT,
    name VARCHAR(40),
    PRIMARY KEY (good_id, name),
    FOREIGN KEY (good_id) REFERENCES GOOD(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- IMAGE
CREATE TABLE IF NOT EXISTS IMAGE (
    good_id INT,
    path VARCHAR(50),
    PRIMARY KEY (good_id, path),
    FOREIGN KEY (good_id) REFERENCES GOOD(id)
        ON UPDATE CASCADE ON DELETE CASCADE
);
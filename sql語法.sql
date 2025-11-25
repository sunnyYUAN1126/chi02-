CREATE DATABASE secondBook_DB
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE secondBook_DB;

-- 二手書交易平台資料庫設計

-- 1. 使用者表
--主鍵自動生成
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    account VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    student_id VARCHAR(20) UNIQUE,
    department VARCHAR(100),
    email VARCHAR(100) UNIQUE NOT NULL,
    role ENUM('會員', '管理員') DEFAULT '會員',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);




-- 2. 書籍分類表
--主鍵自動生成
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL,
);

INSERT INTO categories (category_name) VALUES
('文學與人文類'),
('社會科學類'),
('商業與管理類'),
('理工與資訊類'),
('醫學與健康類');

-- 3. 書目表
--主鍵不能自動生成
CREATE TABLE books (
    book_id VARCHAR(13) PRIMARY KEY, -- ISBN
    category_id INT,
    book_name VARCHAR(255) NOT NULL,
    author VARCHAR(255),
    publisher VARCHAR(100),
    publish_date DATE,
    original_price DECIMAL(10, 2),
    stock_quantity INT DEFAULT 0,
    cover_image LONGBLOB, -- 書籍封面圖片二進位資料
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL
);
-- -------------------------
--  新增書籍
-- -------------------------

INSERT INTO books (
    book_id, 
    category_id, 
    book_name, 
    author, 
    publisher, 
    publish_date, 
    original_price, 
    stock_quantity,
    cover_image
) VALUES (
    '9789865030612',
    3,
    '計算機概論: 當代資訊通鑑 (第14版)',
    '趙坤茂/ 張雅惠/ 黃俊穎/ 黃寶萱',
    '全華圖書股份有限公司',
    '2019-03-21',  
    650.00,
    0,
    LOAD_FILE('C:/2.projectsJava/1.mysqldatabase/9789865030612.jpg')
	),
	(
    '9789869462686',
    3,
    '運籌視野之供應鏈管理 (10版)',
    'John J. Coyle, C. John Langley, Jr., Robert A. Novack, Brian J. Gibson',
    '東華',
    '2017-08-01',  
    750.00,
    0,
    LOAD_FILE('C:/2.projectsJava/1.mysqldatabase/9789869462686.jpg')
	),
	(
    '9789865774998',
    3,
    '資料庫的核心理論與實務 (7版)',
    '黃三益',
    '前程文化事業股份有限公司',
    '2018-02-01',  
    680.00,
    0,
    LOAD_FILE('C:/2.projectsJava/1.mysqldatabase/9789865774998.jpg')
	),
	(
    '9789867433633',
    3,
    '經濟學概論(三版)',
    '胡春田/巫和懋/霍德明/熊秉元',
    '雙葉書廊',
    '2006-09-01',  
    560.00,
    0,
    LOAD_FILE('C:/2.projectsJava/1.mysqldatabase/9789867433633.jpg')
	),
	(
    '9789579282130',
    3,
    '統計學：基礎與應用',
    'Gerald Keller',
    '新加坡商聖智學習亞洲私人有限公',
    '2006-09-01',  
    600.00,
    0,
    LOAD_FILE('C:/2.projectsJava/1.mysqldatabase/9789579282130.jpg')
	),
	(
    '9789865774141',
    3,
    '管理學: 整合觀點與創新思維 (第4版)',
    '中山大學企業管理學系',
    '前程文化事業股份有限公司',
    '2014-05-01',  
    720.00,
    0,
    LOAD_FILE('C:/2.projectsJava/1.mysqldatabase/9789865774141.jpg')
	)
	
	
);

INSERT INTO books (
    book_id, 
    category_id, 
    book_name, 
    author, 
    publisher, 
    publish_date, 
    original_price, 
    stock_quantity,
    cover_image
) VALUES (
    '9789865774141',
    3,
    '管理學: 整合觀點與創新思維 (第4版)',
    '中山大學企業管理學系',
    '前程文化事業股份有限公司',
    '2014-05-01',  
    720.00,
    0,
    LOAD_FILE('C:/2.projectsJava/1.mysqldatabase/9789865774141.jpg')
);






-- 4. 商品表（賣家上架的二手書）
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id VARCHAR(13) NOT NULL,
    seller_user_id INT NOT NULL,
    book_condition ENUM('九成新', '八成新', '七成新', '六成新', '五成新', '四成新', '三成新', '二成新', '一成新') NOT NULL,
    has_notes ENUM('無', '少量筆記', '大量筆記') DEFAULT '無',
    note TEXT,
    price DECIMAL(10, 2) NOT NULL,
    listing_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    image1 VARCHAR(255),
    image2 VARCHAR(255),
    image3 VARCHAR(255),
    image4 VARCHAR(255),
    stock INT DEFAULT 1,
    listing_status ENUM('上架', '下架') DEFAULT '上架',
    admin_review ENUM('待審核', '審核通過', '審核不通過') DEFAULT '待審核',
    admin_note TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 5. 購物車 Session 表
CREATE TABLE shopping_sessions (
    session_id INT PRIMARY KEY AUTO_INCREMENT,
    buyer_user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) DEFAULT 0.00,
    total_quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- 6. 購物車項目表
CREATE TABLE cart_items (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,
    session_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES shopping_sessions(session_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE,
    UNIQUE KEY unique_cart_item (session_id, product_id)
);

-- 7. 訂單表
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_user_id INT NOT NULL,
    buyer_user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    meetup_location VARCHAR(255),
    meetup_date DATE,
    meetup_time TIME,
    order_status ENUM('取消', '待面交', '完成') DEFAULT '待面交',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (seller_user_id) REFERENCES users(user_id) ON DELETE RESTRICT,
    FOREIGN KEY (buyer_user_id) REFERENCES users(user_id) ON DELETE RESTRICT
);

-- 8. 訂單細項表
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT DEFAULT 1,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
);

-- 建立索引以提升查詢效能
CREATE INDEX idx_products_seller ON products(seller_user_id);
CREATE INDEX idx_products_book ON products(book_id);
CREATE INDEX idx_products_status ON products(listing_status, admin_review);
CREATE INDEX idx_orders_buyer ON orders(buyer_user_id);
CREATE INDEX idx_orders_seller ON orders(seller_user_id);
CREATE INDEX idx_orders_status ON orders(order_status);
CREATE INDEX idx_cart_session ON cart_items(session_id);

-- 插入範例資料

-- 插入書籍分類
INSERT INTO categories (category_name, description) VALUES
('電腦科學', '程式設計、演算法、資料結構等'),
('商業管理', '企業管理、行銷、財務等'),
('文學小說', '各類文學作品與小說'),
('自然科學', '物理、化學、生物等'),
('語言學習', '英文、日文等語言學習書籍');

-- 插入管理員帳號
INSERT INTO users (account, password, student_id, department, email, role) VALUES
('admin', 'admin123', 'A000000', '資訊管理系', 'admin@example.com', '管理員');

-- 插入測試使用者
INSERT INTO users (account, password, student_id, department, email, role) VALUES
('student01', 'pass123', 'B110001', '資訊工程系', 'student01@example.com', '會員'),
('student02', 'pass123', 'B110002', '企業管理系', 'student02@example.com', '會員');
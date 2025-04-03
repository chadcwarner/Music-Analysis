-- Drop tables if they exist (to avoid errors)
IF OBJECT_ID('playlist_track', 'U') IS NOT NULL DROP TABLE playlist_track;
IF OBJECT_ID('track', 'U') IS NOT NULL DROP TABLE track;
IF OBJECT_ID('playlist', 'U') IS NOT NULL DROP TABLE playlist;
IF OBJECT_ID('media_type', 'U') IS NOT NULL DROP TABLE media_type;
IF OBJECT_ID('invoice_line', 'U') IS NOT NULL DROP TABLE invoice_line;
IF OBJECT_ID('invoice', 'U') IS NOT NULL DROP TABLE invoice;
IF OBJECT_ID('genre', 'U') IS NOT NULL DROP TABLE genre;
IF OBJECT_ID('employee', 'U') IS NOT NULL DROP TABLE employee;
IF OBJECT_ID('customer', 'U') IS NOT NULL DROP TABLE customer;
IF OBJECT_ID('artist', 'U') IS NOT NULL DROP TABLE artist;
IF OBJECT_ID('album', 'U') IS NOT NULL DROP TABLE album;

-- Create tables
CREATE TABLE album (
    album_id VARCHAR(30) PRIMARY KEY,
    title VARCHAR(150),
    artist_id VARCHAR(30)
);

CREATE TABLE artist (
    artist_id VARCHAR(30) PRIMARY KEY,
    name VARCHAR(150)
);

CREATE TABLE customer (
    customer_id VARCHAR(30) PRIMARY KEY,
    first_name CHAR(30),
    last_name CHAR(30),
    company VARCHAR(150),
    address VARCHAR(250),
    city VARCHAR(30),
    state VARCHAR(30),
    country VARCHAR(30),
    postal_code VARCHAR(30),
    phone VARCHAR(30),
    fax VARCHAR(30),
    email VARCHAR(30),
    support_rep_id VARCHAR(30)
);

CREATE TABLE employee (
    employee_id VARCHAR(30) PRIMARY KEY,
    last_name CHAR(50),
    first_name CHAR(50),
    title VARCHAR(250),
    reports_to VARCHAR(30),
    levels VARCHAR(10),
    birth_date DATETIME,
    hire_date DATETIME,
    address VARCHAR(120),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(30),
    postal_code VARCHAR(30),
    phone VARCHAR(30),
    fax VARCHAR(30),
    email VARCHAR(30)
);

CREATE TABLE genre (
    genre_id VARCHAR(30) PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE invoice (
    invoice_id VARCHAR(30) PRIMARY KEY,
    customer_id VARCHAR(30),
    invoice_date DATETIME,
    billing_address VARCHAR(120),
    billing_city VARCHAR(30),
    billing_state VARCHAR(30),
    billing_country VARCHAR(30),
    billing_postal VARCHAR(30),
    total FLOAT
);

CREATE TABLE invoice_line (
    invoice_line_id VARCHAR(30) PRIMARY KEY,
    invoice_id VARCHAR(30),
    track_id VARCHAR(30),
    unit_price NUMERIC,
    quantity INT
);

CREATE TABLE media_type (
    media_type_id VARCHAR(30) PRIMARY KEY,
    name VARCHAR(30)
);

CREATE TABLE playlist (
    playlist_id VARCHAR(30) PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE playlist_track (
    playlist_id VARCHAR(30),
    track_id VARCHAR(50)
);

CREATE TABLE track (
    track_id VARCHAR(30) PRIMARY KEY,
    name VARCHAR(250),
    album_id VARCHAR(30),
    media_type_id VARCHAR(30),
    genre_id VARCHAR(30),
    composer VARCHAR(250),
    milliseconds BIGINT,
    bytes INT,
    unit_price NUMERIC
);

-- Add foreign keys
ALTER TABLE album ADD CONSTRAINT fk_album_artist FOREIGN KEY (artist_id) REFERENCES artist (artist_id) ON DELETE CASCADE;
ALTER TABLE customer ADD CONSTRAINT fk_customer_employee FOREIGN KEY (support_rep_id) REFERENCES employee (employee_id) ON DELETE CASCADE;
ALTER TABLE employee ADD CONSTRAINT fk_employee_manager FOREIGN KEY (reports_to) REFERENCES employee (employee_id) ON DELETE CASCADE;
ALTER TABLE invoice ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer (customer_id) ON DELETE CASCADE;
ALTER TABLE invoice_line ADD CONSTRAINT fk_invoice_line_invoice FOREIGN KEY (invoice_id) REFERENCES invoice (invoice_id) ON DELETE CASCADE;
ALTER TABLE invoice_line ADD CONSTRAINT fk_invoice_line_track FOREIGN KEY (track_id) REFERENCES track (track_id) ON DELETE CASCADE;
ALTER TABLE playlist_track ADD CONSTRAINT fk_playlist_track_playlist FOREIGN KEY (playlist_id) REFERENCES playlist (playlist_id) ON DELETE CASCADE;
ALTER TABLE playlist_track ADD CONSTRAINT fk_playlist_track_track FOREIGN KEY (track_id) REFERENCES track (track_id) ON DELETE CASCADE;
ALTER TABLE track ADD CONSTRAINT fk_track_album FOREIGN KEY (album_id) REFERENCES album (album_id) ON DELETE CASCADE;
ALTER TABLE track ADD CONSTRAINT fk_track_genre FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE CASCADE;
ALTER TABLE track ADD CONSTRAINT fk_track_media_type FOREIGN KEY (media_type_id) REFERENCES media_type (media_type_id) ON DELETE CASCADE;

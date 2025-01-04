create table products(
    id varchar(10) not null,
    nama varchar(100) not null,
    keterangan text,
    harga int not null,
    jumlah int not null default 0,
    created_at timestamp not null default current_timestamp
);

ALTER TABLE products
ADD CONSTRAINT unique_id UNIQUE (id);

insert into products(id, nama, keterangan, harga, jumlah)
values('P0001', 'Ayam Geprek original','Ayam Geprek + sambal ijo', 25000,100);

insert into products(id, nama, harga, jumlah)
values ('P0002', 'Ayam Bakar Bumbu seafood', 35000,100),
        ('P0003', 'Ayam Goreng Upin-Ipin', 30000,100),
        ('P0004', 'Ayam Bakar Bumbu seadanya', 35000,100);


update products
set nama = 'Ayam pop'
where id = 'P0001';


alter table products
add column category VARCHAR(50);


update products
set category = 'Makanan'
where id = 'P0001';

update products
set category = 'Makanan'
where id = 'P0002';

update products
set category = 'Makanan'
where id = 'P0003';

update products
set category = 'Makanan'
where id = 'P0004';

update products
set category = 'Makanan'
where id = 'P0005';


update products
set harga = harga + 10000
where id = 'P0004';


-- insert data untuk contoh dihapus
insert into products(id, nama, harga, jumlah, category)
values ('P0010', 'Produk Gagal', 50000, 100,'Minuman');

select * from products;

-- Menghapus id P0010
delete from products
where id = 'P0010';


-------PERTEMUAN 4--------------

select * from products;

select * from products where harga > 15000;

select * from products where harga <= 30000;

select * from products where category != 'Minuman';

select * from products where harga > 40000 and category = 'Makanan';

insert into products(id, nama, harga, jumlah, category)
values ('P0006', 'Air Tawar', 2000, 100, 'Minuman'),
        ('P0007', 'Es Tawar', 5000, 100, 'Minuman'),
        ('P0008', 'Es Teller', 20000, 100, 'Minuman'),
        ('P0009', 'Es Janda muda', 25000, 100, 'Minuman');

select * from products;

select * from products where harga > 15000;

select * from products where harga > 15000 and category = 'Minuman';

select * from products where harga > 1500 or category = 'Makanan';

select * from products where jumlah > 100 or category = 'Makanan' and harga > 15000;

select * from products where (jumlah > 100) or (category = 'Makanan' and harga > 15000);

select * from products where category = 'Makanan' or (jumlah > 100) and harga > 15000;


create table barang(
    kode int not null,
    nama varchar(100) not null,
    harga int not null default 1000,
    jumlah int not null default 0,
    waktu_dibuat timestamp not null default current_timestamp);

select * from barang;



------------PERTEMUAN 5------------

select * from products where nama ilike '%Bakar%';
select * from products where nama ilike '%Es%';
select * from products where nama like '%seafood%';

select * from products where harga between 10000 and 30000;
select * from products where harga not between 10000 and 30000;

select * from products where category in ('Makanan');
select * from products where category in ('Makanan', 'Minuman');

select * from products order by harga asc;
select * from products order by harga asc, id desc;
select * from products order by harga desc;

select * from products where harga > 0 order by harga asc, id desc limit 2;

select * from products order by harga asc, id desc limit 2 offset 2;

select category from products;
select distinct category from products;

select 10 + 10 as hasil;
select id, harga / 1000 as harga_in_k from products;

select pi();
select power(10, 2);
select cos(10), sin(10), tan(10);
select id, nama, power(jumlah, 2) as jumlah_power_2 from products;

create table admin(
    id serial not null,
    nama_depan varchar(100) not null,
    nama_belakang varchar(100) not null,
    primary key(id)
);


insert into admin(nama_depan,nama_belakang)
values ('Arif','Rahmat'),
       ('Prabowo','Jonatan');
select * from admin;

select currval('admin_id_seq');

create sequence contoh_berurut;

select nextval('contoh_berurut');
select currval('contoh_berurut');

select id, nama, keterangan from products;
select id, lower(nama), length(nama), lower(keterangan) from products;




------------PERTEMUAN 6----------------

select * from products;
select id, extract(year from created_at), extract(month from created_at) from products;

select id,
case category
when 'Makanan' then 'enak'
when 'Minuman' then 'Sueger'
else 'Apa an tuh!!'
end as category
from products;

select id, category,
case category
when 'Makanan' then 'enak'
when 'Minuman' then 'Sueger'
else 'Apa an tuh!!'
end as category_case
from products;


select id,
nama,
case
when keterangan is null then 'kosong'
else keterangan
end as keterangan
from products;


-- Menghitung jumlah id
select count(id) from products;

-- Menghitung rata-rata harga
select avg(harga) from products;

-- Mencari harga paling mahal
select max(harga) from products;

-- Mencari harga paling murah
select min(harga) from products;


select category, count(id) from products group by category;

select category, count(id) as "Total Product" from products group by category;

select category,
avg(harga) as "Rata-rata harga",
min(harga) as "Harga termurah",
max(harga) as "Harga termahal"
from products
group by category;


select category,
count(id) as "Total Product"
from products
group by category
having count(id) > 1;


create table customer(
    id serial not null,
    email varchar(100) not null,
    nama_depan varchar(200) not null,
    nama_akhir varchar(200) not null,
    primary key (id),
    constraint unique_email unique (email)
);


alter table customer drop constraint unique_email;
alter table customer add constraint unique_email unique (email);



------------PERTEMUAN 7---------------

alter table products
add constraint price_check check (harga > 1000);

alter table products
add constraint jumlah_check check (jumlah >= 0);

insert into products(id, nama, harga, jumlah, category)
values ('XXX1', 'Gagal bro', 1001, 0, 'Minuman');

create table penjual (
    id serial not null,
    nama varchar(100) not null,
    email varchar(200) not null,
    primary key (id),
    constraint emaile_unique unique (email)
);


create index products_nama_search on products using gin(to_tsvector('indonesian', nama));
SELECT * FROM products WHERE to_tsvector('english', nama) @@ to_tsquery('ayam');

CREATE TABLE wishlist (
    id SERIAL NOT NULL,
    id_produk VARCHAR(10) NOT NULL,
    keterangan TEXT,
    PRIMARY KEY (id),
    CONSTRAINT fk_wishlist_produk FOREIGN KEY (id_produk) REFERENCES products (id)
);

alter table wishlist
drop constraint fk_wishlist_produk;

alter table wishlist
add constraint fk_wishlist_produk foreign key (id_produk) references products (id)
on delete cascade on update cascade;

insert into products(id, nama, harga, jumlah, category)
values ('abab', 'xXx', 10000, 100, 'Minuman');

delete from products where id = 'abab';




--------PERTEMUAN 8-----------

CREATE TABLE produk_laptop (
    id SERIAL PRIMARY KEY,
    nama TEXT NOT NULL,
    details JSONB
);

INSERT INTO produk_laptop (nama, details)
VALUES (
    'Laptop',
    '{
        "brand": "Asus",
        "model": "Vivo Book",
        "specs": {
            "cpu": "Core i7",
            "ram": "32GB",
            "storage": "1 Tera SSD NVME"
        }
    }'
);

SELECT * FROM produk_laptop;

SELECT nama, details->>'brand' AS brand
FROM produk_laptop;

SELECT nama, details->>'brand' AS brand
FROM produk_laptop;

SELECT nama, details->'specs'->>'cpu' AS cpu
FROM produk_laptop;

SELECT nama, details#>>'{specs, storage}' AS storage
FROM produk_laptop;

UPDATE produk_laptop
SET details = jsonb_set(details, '{specs, storage}', '"512GB SSD"')
WHERE nama = 'Laptop';

UPDATE produk_laptop
SET details = details - 'model'
WHERE nama = 'Laptop';

UPDATE produk_laptop
SET details = details #- '{specs, cpu}'
WHERE nama = 'Laptop';

INSERT INTO produk_laptop (nama, details)
VALUES (
    'Smartphone',
    '{
        "brand": "Apple",
        "model": "iPhone 12",
        "tags": ["electronics", "mobile", "new"]
    }'
);

SELECT nama, details
FROM produk_laptop
WHERE details @> '{"tags": ["mobile"]}';

SELECT nama, details
FROM produk_laptop
WHERE details->'tags' ? 'mobile';

UPDATE produk_laptop
SET details = details || '{"warranty": "2 years"}'
WHERE nama = 'Laptop';

CREATE INDEX idx_produk_details ON produk_laptop USING GIN (details);

CREATE INDEX idx_produk_details_model ON produk_laptop ((details->>'model'));

SELECT nama, details
FROM produk_laptop
WHERE details->'tags' ? 'electronics';

SELECT nama, details
FROM produk_laptop
WHERE details->>'model' = 'Vivo Book';




--------PERTEAMUAN 9-----------

SELECT 
    p.id AS product_id, 
    p.nama AS product_name, 
    w.keterangan AS wishlist_note
FROM wishlist AS w
JOIN products AS p ON w.id_produk = p.id;

ALTER TABLE wishlist
ADD COLUMN id_customer INT;

ALTER TABLE wishlist
ADD CONSTRAINT fk_wishlist_customer
FOREIGN KEY (id_customer) REFERENCES customer(id);

UPDATE wishlist
SET id_customer = 1
WHERE id IN (1, 2);

UPDATE wishlist
SET id_customer = 2
WHERE id = 3;

SELECT 
    c.email AS customer_email, 
    p.id AS product_id, 
    p.nama AS product_name, 
    w.keterangan AS wishlist_note
FROM wishlist AS w
JOIN products AS p ON w.id_produk = p.id
JOIN customer AS c ON w.id_customer = c.id;

CREATE TABLE dompet (
    id SERIAL PRIMARY KEY,
    id_customer INT NOT NULL,
    balance INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_wallet_customer FOREIGN KEY (id_customer) REFERENCES customer(id)
);


SELECT 
    c.id AS customer_id, 
    c.nama_depan AS first_name, 
    c.nama_akhir AS last_name, 
    d.balance AS wallet_balance
FROM customer AS c
JOIN dompet AS d ON d.id_customer = c.id;

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL
);

INSERT INTO categories (nama) 
VALUES ('Makanan'), ('Minuman');

ALTER TABLE products
ADD COLUMN id_category INT;
ALTER TABLE products
ADD CONSTRAINT fk_product_category FOREIGN KEY (id_category) REFERENCES categories(id);


SELECT 
    p.id AS product_id, 
    p.nama AS product_name, 
    c.nama AS category_name
FROM products AS p
JOIN categories AS c ON p.id_category = c.id;

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    total INT NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT current_timestamp
);

INSERT INTO orders (total) 
VALUES (10000), (20000), (15000);

CREATE TABLE orders_detail (
    id_product VARCHAR(10) NOT NULL,
    id_order INT NOT NULL,
    harga INT NOT NULL,
    jumlah INT NOT NULL,
    PRIMARY KEY (id_product, id_order),
    CONSTRAINT fk_orders_detail_product FOREIGN KEY (id_product) REFERENCES products(id),
    CONSTRAINT fk_orders_detail_order FOREIGN KEY (id_order) REFERENCES orders(id)
);

INSERT INTO orders_detail (id_product, id_order, harga, jumlah)
VALUES 
('P0001', 1, 5000, 3),
('P0002', 1, 3000, 2),
('P0003', 1, 2000, 2);


SELECT 
    o.id AS order_id,
    o.total AS total_order,
    o.order_date,
    od.id_product AS product_id,
    p.nama AS product_name,
    od.harga AS price,
    od.jumlah AS quantity,
    (od.harga * od.jumlah) AS subtotal
FROM orders AS o
JOIN orders_detail AS od ON od.id_order = o.id
JOIN products AS p ON od.id_product = p.id;



---------PERTEMUAN 10---------------

-- Hapus foreign key di tabel products
ALTER TABLE products
DROP CONSTRAINT fk_product_category;

-- Ubah tipe data kolom id di tabel categories menjadi varchar(10)
ALTER TABLE categories 
ALTER COLUMN id TYPE varchar(10);

-- Ubah tipe data kolom id_category di tabel products menjadi varchar(10)
ALTER TABLE products 
ALTER COLUMN id_category TYPE varchar(10);

-- Tambahkan kembali foreign key
ALTER TABLE products
ADD CONSTRAINT fk_product_category
FOREIGN KEY (id_category) REFERENCES categories(id);

insert into categories(id, nama)
values 
    ('C0003', 'Snack Basah'),
    ('C0004', 'Snack Kering');

-- Melihat isi tabel categories
select * from categories;

-- Melihat isi tabel products
select * from products;

select * from categories
inner join products 
on products.id_category = categories.id;

select * from categories
left join products 
on products.id_category = categories.id;

select * from categories
right join products 
on products.id_category = categories.id;

select * from categories
full join products 
on products.id_category = categories.id;

select avg(harga) from products;

select * from products
where harga > (select avg(harga) from products);

select max(harga) 
from (
    select products.harga as harga
    from categories
    join products 
    on products.id_category = categories.id
) as contoh;


create table bukutamu (
    id serial not null,
    email varchar(100) not null,
    title varchar(100) not null,
    content text,
    primary key (id)
);


insert into bukutamu(email, title, content)
values 
    ('banyu.q@gmail.com', 'Banyu Biru', 'Ini adalah banyu'),
    ('rab.q@gmail.com', 'Rabs Biru', 'Ini adalah rab'),
    ('rabs.q@gmail.com', 'Rab Saja', 'Ini saingan saya'),
    ('arief@gmail.com', 'Rabu', 'Ini adalah rabu'),
    ('prabowo@gmail.com', 'Kamis Biru', 'Ini adalah kamis');

select distinct email 
from customer
union
select distinct email 
from bukutamu;

select email, count(email) 
from (
    select email from customer
    union all
    select email from bukutamu
) as contoh
group by email;

select distinct email 
from customer
intersect
select distinct email 
from bukutamu;

select distinct email 
from customer
except
select distinct email 
from bukutamu;



--------PERTEMUAN 11---------------

-- TRANSAKSI DASAR
-- Memulai transaksi
START TRANSACTION;

-- Menambahkan data ke tabel bukutamu
INSERT INTO bukutamu(email, title, content)
VALUES ('transaction@gmail.com', 'Transaction', 'Transaksi 1');

INSERT INTO bukutamu(email, title, content)
VALUES ('transaction@gmail.com', 'Transaction', 'Transaksi 2');

-- Melihat hasilnya di klien lain
SELECT * FROM bukutamu;

-- Menyimpan perubahan
COMMIT;

-- Menggunakan Rollback
-- Memulai transaksi
START TRANSACTION;

-- Menambahkan data ke tabel bukutamu
INSERT INTO bukutamu(email, title, content)
VALUES ('transaction@gmail.com', 'Transaction', 'Rollback 1');

-- Membatalkan transaksi
ROLLBACK;

-- Memastikan data tidak tersimpan
SELECT * FROM bukutamu;

-- LOCKING DAN DEADLOCK
-- Mengunci record
START TRANSACTION;
SELECT * FROM products WHERE id = 'P0001' FOR UPDATE;

-- Membatalkan transaksi
ROLLBACK;

-- Deadlock - simulasi
START TRANSACTION;
SELECT * FROM products WHERE id = 'P0001' FOR UPDATE;
-- (Perhatikan bahwa deadlock akan terjadi jika dua transaksi mencoba mengunci dua record dalam urutan berbeda)
SELECT * FROM products WHERE id = 'P0002' FOR UPDATE;
ROLLBACK;

-- PENGELOLAAN SCHEMA
-- Membuat schema baru
CREATE SCHEMA contoh;

-- Pindah ke schema lain
SET search_path TO contoh;

-- Membuat tabel di schema contoh
CREATE TABLE contoh.products (
    id SERIAL NOT NULL,
    nama VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
);

-- Kembali ke schema public
SET search_path TO public;

-- MANAJEMEN PENGGUNA
-- Membuat pengguna
CREATE ROLE arief LOGIN PASSWORD 'rahasia';
CREATE ROLE banyu LOGIN PASSWORD 'rahasia';

-- Memberi hak akses
GRANT INSERT, UPDATE, SELECT ON ALL TABLES IN SCHEMA public TO arief;
GRANT INSERT, UPDATE, SELECT ON customer TO banyu;








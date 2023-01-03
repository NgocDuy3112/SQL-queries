use master;
go
if exists(select * from sys.databases where name='CsdlCongty')
drop database CsdlCongty;
go
create database CsdlCongty;
go
use CsdlCongty;
go

-- Tạo bảng PHONGBAN
create table PHONGBAN (
	MaPB		int,
	TenPB		varchar(15) not null,
	MaQL		char(9),
	NgayBoNhiem	date,
	constraint PHONGBAN_PK primary key (MaPB)
);

-- Tạo bảng NHANVIEN
create table NHANVIEN (
	MaNV		char(9),
	HoNV		varchar(15) not null,
	Dem		varchar(15),
	TenNV		varchar(15) not null,
	NgaySinh	date,
	DiaChi		varchar(50),
	GioiTinh	char not null,
	Luong		int not null,
	MaGS		char(9),
	MaPB		int,
	constraint NHANVIEN_PK primary key (MaNV),
	constraint NHANVIEN_NHANVIEN_FK foreign key (MaGS) references NHANVIEN (MaNV),
	constraint NHANVIEN_PHONGBAN_FK foreign key (MaPB) references PHONGBAN (MaPB),
	constraint NHANVIEN_GIOITINH_DM check (GioiTinh in ('F', 'f', 'M', 'm'))	
);

-- Thêm RBTV khóa ngoại cho bảng PHONGBAN
alter table PHONGBAN add constraint PHONGBAN_FK foreign key (MaQL) references NHANVIEN (MaNV);

-- Tạo bảng TRUSO_PHONG
create table TRUSO_PHONG (
	MaPB	int,
	TruSo	varchar(50) not null,
	constraint TRUSO_PHONG_PK primary key (MaPB, TruSo),
	constraint TRUSO_PHONG_PHONGBAN_FK foreign key (MaPB) references PHONGBAN (MaPB)
);

-- Tạo bảng DUAN
create table DUAN (
	MaDA	int,
	TenDA	varchar(30) not null,
	DiaDiem	varchar(50) not null,
	MaPB	int,
	constraint DUAN_PK primary key (MaDA),
	constraint DUAN_PHONGBAN_FK foreign key (MaPB) references PHONGBAN (MaPB)
);

-- Tạo bảng THAMGIA
create table THAMGIA (
	MaNV	char(9),
	MaDA	int,
	SoGio	decimal(6,1),
	constraint PHANCONG_PK primary key (MaNV, MaDA),
	constraint PHANCONG_NHANVIEN_FK foreign key (MaNV) references NHANVIEN (MaNV),
	constraint PHANCONG_DUAN_FK foreign key (MaDA) references DUAN (MaDA)
);

-- Tạo bảng THANNHAN
create table THANNHAN (
	MaNV		char(9),
	TenTN		varchar(45),
	GioiTinh	char,
	NgaySinh	date,
	QuanHe		varchar(10) not null,
	constraint THANNHAN_PK primary key (MaNV, TenTN),
	constraint THANNHAN_NHANVIEN_FK foreign key (MaNV) references NHANVIEN (MaNV),
	constraint THANNHAN_GIOITINH_DM check (GioiTinh in ('M', 'm', 'F', 'f'))
);

-- Thêm các dòng vào bảng PHONGBAN
insert into PHONGBAN values (5,'Nghien cuu',null,null);
insert into PHONGBAN values (4,'Dieu hanh',null,null);
insert into PHONGBAN values (1,'Quan ly',null,null);

-- Thêm các dòng vào bảng NHANVIEN
insert into NHANVIEN values ('888665555','Le','Van','Bo','1937-11-10','450 Trung Vuong, Ha Noi','M',55000,null,1);
insert into NHANVIEN values ('333445555','Phan','Van','Nghia','1955-12-08','638 Nguyen Van Cu, Q5, TpHCM','M',40000,'888665555',5);
insert into NHANVIEN values ('123456789','Nguyen','Bao','Hung','1965-01-09','731 Tran Hung Dao, Q1, TpHCM','M',30000,'333445555',5);
insert into NHANVIEN values ('666884444','Tran',null,'Nam','1962-09-15','975 Ba Ria Vung Tau','M',38000,'333445555',5);
insert into NHANVIEN values ('453453453','Hoang','Kim','Yen','1972-07-31','543 Mai Thi Luu, Q1, TpHCM','F',25000,'333445555',5);
insert into NHANVIEN values ('987654321','Du','Thi','Hau','1951-06-20','291 Ho Van Hue, QPN, TpHCM','F',43000,'888665555',4);
insert into NHANVIEN values ('999887777','Au',null,'Vuong','1968-07-19','332 Nguyen Thai Hoc, Q1, TpHCM','F',25000,'987654321',4);
insert into NHANVIEN values ('987987987','Nguyen','Van','Giap','1969-03-09','980 Le Hong Phong, Q10, TpHCM','M',25000,'987654321',4);

-- Thiết lập giá trị của trưởng phòng (MaQL, NgayBoNhiem) cho các dòng trong bảng PHONGBAN
update PHONGBAN set MaQL='888665555', NgayBoNhiem='1981-06-19' where MaPB=1;
update PHONGBAN set MaQL='987987987', NgayBoNhiem='1995-01-01' where MaPB=4;
update PHONGBAN set MaQL='333445555', NgayBoNhiem='1988-05-22' where MaPB=5;

-- Thêm các dòng vào bảng TRUSO_PHONG
insert into TRUSO_PHONG values (1,'Phu Nhuan');
insert into TRUSO_PHONG values (4,'Go Vap');
insert into TRUSO_PHONG values (5,'Tan Binh');
insert into TRUSO_PHONG values (5,'Phu Nhuan');
insert into TRUSO_PHONG values (5,'Thu Duc');

-- Thêm các dòng vào bảng DUAN
insert into DUAN values (1,'San pham X','Tan Binh',5);
insert into DUAN values (2,'San pham Y','Thu Duc',5);
insert into DUAN values (3,'San pham Z','Phu Nhuan',5);
insert into DUAN values (10,'Tin hoc hoa','Go Vap',4);
insert into DUAN values (20,'Tai to chuc','Phu Nhuan',1);
insert into DUAN values (30,'Phuc loi','Go Vap',4);

-- Thêm các dòng vào bảng THAMGIA
insert into THAMGIA values ('123456789',1,32.5);
insert into THAMGIA values ('123456789',2,7.5);
insert into THAMGIA values ('666884444',3,40);
insert into THAMGIA values ('453453453',1,20);
insert into THAMGIA values ('453453453',2,20);
insert into THAMGIA values ('333445555',2,10);
insert into THAMGIA values ('333445555',3,10);
insert into THAMGIA values ('333445555',10,10);
insert into THAMGIA values ('333445555',20,10);
insert into THAMGIA values ('999887777',30,30);
insert into THAMGIA values ('999887777',10,10);
insert into THAMGIA values ('987987987',10,35);
insert into THAMGIA values ('987987987',30,5);
insert into THAMGIA values ('987654321',30,20);
insert into THAMGIA values ('987654321',20,15);
insert into THAMGIA values ('888665555',20,null);

-- Thêm các dòng vào bảng THANNHAN
insert into THANNHAN values ('333445555','Anh','F','1986-04-05','Con gai');
insert into THANNHAN values ('333445555','The','M','1983-10-25','Con trai');
insert into THANNHAN values ('333445555','Loi','F','1958-05-03','Vo');
insert into THANNHAN values ('987654321','An','M','1942-02-28','Chong');
insert into THANNHAN values ('123456789','Minh','M','1988-01-01','Con trai');
insert into THANNHAN values ('123456789','Anh','F','1988-12-30','Con gai');
insert into THANNHAN values ('123456789','Yen','F','1967-05-05','Vo');
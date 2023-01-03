USE CsdlCongty;

--1. Cho biet ma so, ho ten, ngay sinh cua cac nhan vien phong so 4.
SELECT
    MaNV,
    CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTen,
    NgaySinh
FROM NHANVIEN;
GO

--2. Tim nhung nhan vien co muc luong tren 30.000
SELECT
    MaNV,
    CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTen,
    CASE
        WHEN GioiTinh = 'M' THEN 'NAM'
        WHEN GioiTinh = 'F' THEN 'NU'
    END AS GioiTinh,
    Luong
FROM NHANVIEN
WHERE Luong > 30000;
GO

--3. Tim nhung nhan vien co muc luong tren 25000 o phong so 4 hoac co muc luong tren 30000 o phong so 5.
SELECT
    MaNV,
    CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTen,
    CASE
        WHEN GioiTinh = 'M' THEN 'NAM'
        WHEN GioiTinh = 'F' THEN 'NU'
    END AS GioiTinh,
    Luong,
    MaPB
FROM NHANVIEN
WHERE
    (Luong > 25000 AND MaPB = 4)
    OR (Luong > 30000 AND MaPB = 5);
GO

--4. Cho biet ho ten, ngay sinh, dia chi cua cac nhan vien o TpHCM
SELECT
    CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTen,
    NgaySinh,
    DiaChi
FROM NHANVIEN
WHERE DiaChi LIKE '%TpHCM';
GO

--5. Cho biet ngay sinh, dia chi cua nhan vien co ten la 'Nguyen Bao Hung'.
SELECT
    NgaySinh,
    DiaChi
FROM NHANVIEN
WHERE
    HoNV = 'Nguyen'
    AND Dem = 'Bao'
    AND TenNV = 'Hung';


--6. Tim nhung nhan vien co dia chi thuoc quan 'Phu Nhuan'.
SELECT
    CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTen,
    NgaySinh,
    DiaChi
FROM NHANVIEN
WHERE DiaChi LIKE '%Phu Nhuan';
GO


--7. Tim nhung nhan vien sinh vao thap nien 1950.
SELECT
    CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTen,
    NgaySinh
FROM NHANVIEN
WHERE YEAR(NgaySinh) BETWEEN 1950 AND 1959;
GO


--8. Cho biet cac muc luong rieng biet cua cac nhan vien.
SELECT DISTINCT Luong AS MucLuong
FROM NHANVIEN;
GO


--9. Tim nhung nhan vien khong co nguoi giam sat.
SELECT
    CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTen,
    NgaySinh,
    DiaChi,
    MaGS
FROM NHANVIEN
WHERE MaGS IS NULL;
GO


--10. Voi moi phong ban, cho biet ten phong ban va tru so phong.
SELECT
    PB.TenPB,
    TSP.TruSo
FROM 
    PHONGBAN AS PB
    JOIN TRUSO_PHONG AS TSP
    ON PB.MaPB = TSP.MaPB;
GO


--11. Voi moi phong ban, cho biet ten phong ban va ten nguoi truong phong.
SELECT
    PB.TenPB,
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenTruongPhong
FROM
    PHONGBAN AS PB
    JOIN NHANVIEN AS NV
    ON NV.MaNV = PB.MaQL;
GO


--12. Voi moi nu nhan vien, cho biet ho ten va ten nguoi than cua nhan vien day.
SELECT
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNV,
    TN.TenTN,
    TN.QuanHe
FROM
    NHANVIEN AS NV
    JOIN THANNHAN AS TN
    ON NV.MaNV = TN.MaNV
WHERE NV.GioiTinh = 'F';
GO


--13. Tim ten va dia chi cua cac nhan vien lam viec trong phong 'Nghien cuu'.
SELECT
    NV.TenNV,
    NV.DiaChi
FROM
    NHANVIEN AS NV
    JOIN PHONGBAN AS PB
    ON PB.MaPB = NV.MaPB
WHERE PB.TenPB = 'Nghien cuu'
GO


--14. Cho biet ma du an, ten phong dieu phoi va ho ten, dia chi, ngay sinh cua nguoi truong phong dieu phoi
--cua cac du an co dia diem la 'Go Vap'.
SELECT
    DA.MaDA,
    PB.TenPB,
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenTruongPhong,
    NV.DiaChi,
    NV.NgaySinh
FROM
    DUAN AS DA
    JOIN PHONGBAN AS PB
    ON PB.MaPB = DA.MaPB
    JOIN NHANVIEN AS NV
    ON PB.MaQL = NV.MaNV
WHERE DA.DiaDiem = 'Go Vap';
GO


--15. Voi moi nhan vien, cho biet ho ten cua nhan vien va ho ten cua nguoi giam sat nhan vien day.
SELECT
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien,
    CONCAT(GS.HoNV, ' ', GS.Dem, ' ', GS.TenNV) AS HoTenGiamSat
FROM
    NHANVIEN AS NV
    JOIN NHANVIEN AS GS
    ON GS.MaNV = NV.MaGS;
GO


--16. Cho biet ket qua luong moi cua cac nhan vien tham gia du an 'San pham X' neu nhu ho duoc
--tang them 10% luong.
SELECT
    NV.Luong * 1.1 AS 'Luong Moi'
FROM
    NHANVIEN AS NV
    JOIN THAMGIA AS TG
    ON NV.MaNV = TG.MaNV
    JOIN DUAN AS DA
    ON DA.MaDA = TG.MaDA
WHERE DA.TenDA = 'San pham X';
GO


--17. Cho biet ho ten cua nhan vien co nguoi than cung ten va cung gioi tinh voi nhan vien day.
SELECT
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM
    NHANVIEN AS NV
    JOIN THANNHAN AS TN
    ON NV.MaNV = TN.MaNV
WHERE
    NV.TenNV = TN.TenTN
    AND NV.GioiTinh = TN.GioiTinh;
GO


--18. Cho biet ho ten, ma phong lam viec cua cac nhan vien va ma so cac du an ma ho tham gia
--sap xep tang dan theo ma phong, trong moi phong sap xep theo ho, ten voi thu tu tu dien.
SELECT
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien,
    NV.MaPB,
    TG.MaDA
FROM
    NHANVIEN AS NV
    JOIN THAMGIA AS TG
    ON NV.MaNV = TG.MaNV
ORDER BY
    NV.MaPB,
    NV.TenNV,
    NV.HoNV;
GO


--19. Cho biet tong so nhan vien, muc luong cao nhat, muc luong thap nhat va muc luong trung binh
--cua phong 'Nghien cuu'.
SELECT
    COUNT(NV.MaNV) AS TongSoNhanVien,
    MAX(NV.Luong) AS MucLuongCaoNhat,
    MIN(NV.Luong) AS MucLuongThapNhat,
    AVG(NV.Luong) AS MucLuongTrungBinh
FROM
    NHANVIEN AS NV
    JOIN PHONGBAN AS PB
    ON PB.MaPB = NV.MaPB
WHERE PB.TenPB = 'Nghien cuu'
GROUP BY
    PB.MaPB,
    PB.TenPB;
GO

--20. Voi moi phong, cho biet ma so phong va tong so nhan vien cua phong day.
SELECT
    PB.MaPB,
    COUNT(NV.MaNV) AS TongSoNhanVien
FROM
    NHANVIEN AS NV
    JOIN PHONGBAN AS PB
    ON PB.MaPB = NV.MaPB
GROUP BY
    PB.MaPB,
    PB.TenPB;
GO


--21. Voi moi phong, cho biet ma so phong va muc luong trung binh cua cac nhan vien thuoc phong day.
SELECT
    PB.MaPB,
    AVG(NV.Luong) AS MucLuongTrungBinh
FROM
    NHANVIEN AS NV
    JOIN PHONGBAN AS PB
    ON PB.MaPB = NV.MaPB
GROUP BY
    PB.MaPB,
    PB.TenPB;
GO


--22. Voi moi du an co nhan vien tham gia, cho biet ma so, ten va tong so nhan vien tham gia cua du an day.
SELECT
    DA.MaDA,
    DA.TenDA,
    COUNT(TG.MaNV) AS SoNhanVienThamGia
FROM
    THAMGIA AS TG
    JOIN DUAN AS DA
    ON DA.MaDA = TG.MaDA
GROUP BY
    DA.MaDA,
    DA.TenDA;
GO


--23. Cho biet ma so, ten va tong so nhan vien tham gia cua du an co nhieu hon 2 nhan vien tham gia.
SELECT
    DA.MaDA,
    DA.TenDA,
    COUNT(TG.MaNV) AS SoNhanVienThamGia
FROM
    THAMGIA AS TG
    JOIN DUAN AS DA
    ON DA.MaDA = TG.MaDA
GROUP BY
    DA.MaDA,
    DA.TenDA
HAVING COUNT(TG.MaNV) > 2;
GO


--24. Cho biet ma so, ten va tong so nhan vien cua cac phong co nhieu hon 5 nhan vien.
SELECT
    PB.MaPB,
    PB.TenPB,
    COUNT(NV.MaNV) AS TongSoNhanVien
FROM
    NHANVIEN AS NV
    JOIN PHONGBAN AS PB
    ON PB.MaPB = NV.MaPB
GROUP BY
    PB.MaPB,
    PB.TenPB
HAVING COUNT(NV.MaNV) > 5;
GO


--25. Voi moi du an, cho biet ma so, ten va tong so nhan vien tham gia cua du an day.
SELECT
    DA.MaDA,
    DA.TenDA,
    COUNT(TG.MaNV) AS SoNhanVienThamGia
FROM
    DUAN AS DA
    LEFT JOIN THAMGIA AS TG
    ON DA.MaDA = TG.MaDA
GROUP BY
    DA.MaDA,
    DA.TenDA;
GO


--26. Voi moi du an, cho biet ma so, ten va tong so nhan vien thuoc phong so 5 tham gia cua du an day.
SELECT
    DA.MaDA,
    DA.TenDA,
    COUNT(TG.MaNV) AS SoNhanVienThamGia
FROM
    DUAN AS DA
    LEFT JOIN THAMGIA AS TG
    ON DA.MaDA = TG.MaDA
    JOIN NHANVIEN AS NV
    ON NV.MaNV = TG.MaNV
WHERE NV.MaPB = 5
GROUP BY
    DA.MaDA,
    DA.TenDA;
GO


--27. Voi moi nhan vien, cho biet ho ten va tong so nguoi than cua nhan vien day.
SELECT
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien,
    COUNT(TN.MaNV) AS SoNguoiThan
FROM
    THANNHAN AS TN
    RIGHT JOIN NHANVIEN AS NV
    ON NV.MaNV = TN.MaNV
GROUP BY
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV)
GO


--28. Voi moi phong co muc luong trung binh lon hon 30000, cho biet ten phong 
--va tong so nhan vien cua phong day.
SELECT
    PB.TenPB,
    COUNT(NV.MaNV) AS SoNhanVien
FROM
    PHONGBAN AS PB
    JOIN NHANVIEN AS NV
    ON PB.MaPB = NV.MaPB
GROUP BY PB.TenPB
HAVING AVG(Nv.Luong) > 30000
GO


--29. Cho biet ten cac du an co nhan vien tham gia mang ho 'Nguyen'
--hoac nguoi truong phong dieu phoi mang ho 'Nguyen'.
--Cach 1: Truy van long
SELECT DA.TenDA
FROM DUAN AS DA
WHERE 
    DA.MaDA IN 
    (
        SELECT TG.MaDA
        FROM
            THAMGIA AS TG
            JOIN NHANVIEN AS NV
            ON NV.MaNV = TG.MaNV
        WHERE NV.HoNV = 'Nguyen'
    ) OR DA.MaDA IN (
        SELECT DA.MaDA
        FROM
            PHONGBAN AS PB
            JOIN NHANVIEN AS NV
            ON NV.MaNV = PB.MaQL
            JOIN DUAN AS DA
            ON PB.MaPB = DA.MaPB
        WHERE NV.HoNV = 'Nguyen'
    );
GO
--Cach 2: Bang tam
WITH
    THAMGIA_NGUYEN(MaDA) AS (
        SELECT TG.MaDA
        FROM
            THAMGIA AS TG
            JOIN NHANVIEN AS NV
            ON NV.MaNV = TG.MaNV
        WHERE NV.HoNV = 'Nguyen'
    ),
    TRUONGBAN_NGUYEN AS (
        SELECT DA.MaDA
        FROM
            PHONGBAN AS PB
            JOIN NHANVIEN AS NV
            ON NV.MaNV = PB.MaQL
            JOIN DUAN AS DA
            ON PB.MaPB = DA.MaPB
        WHERE NV.HoNV = 'Nguyen'
    )
SELECT DISTINCT DA.TenDA
FROM
    DUAN AS DA,
    THAMGIA_NGUYEN AS TGN,
    TRUONGBAN_NGUYEN AS TBN
WHERE
    DA.MaDA = TGN.MaDA
    OR DA.MaDA = TBN.MaDA;
GO
--Cach 3: UNION
SELECT DA.TenDA
FROM
    THAMGIA AS TG
    JOIN NHANVIEN AS NV
    ON NV.MaNV = TG.MaNV
    JOIN DUAN AS DA
    ON TG.MaDA = DA.MaDA
WHERE NV.HoNV = 'Nguyen'
UNION
SELECT DA.TenDA
FROM
    PHONGBAN AS PB
    JOIN NHANVIEN AS NV
    ON NV.MaNV = PB.MaQL
    JOIN DUAN AS DA
    ON PB.MaPB = DA.MaPB
WHERE NV.HoNV = 'Nguyen';
GO


--30. Voi moi phong co muc luong trung binh lon hon 30000, cho biet ten phong 
--va tong so nhan vien nu cua phong day.
--Cach 1: Truy van long
SELECT
    PB.TenPB,
    COUNT(NV.MaNV) AS SoNhanVienNu
FROM
    PHONGBAN AS PB
    JOIN NHANVIEN AS NV
    ON PB.MaPB = NV.MaPB
WHERE 
    PB.MaPB IN (
        SELECT PB.MaPB
        FROM
            PHONGBAN AS PB
            JOIN NHANVIEN AS NV
            ON PB.MaPB = NV.MaPB
        GROUP BY PB.MaPB
        HAVING AVG(NV.Luong) > 30000
    )
    AND NV.GioiTinh = 'F'
GROUP BY PB.TenPB;
GO
--Cach 2: Bang tam
WITH LUONG_LONHON_30000(MaPB, TenPB) AS
(
    SELECT 
        PB.MaPB,
        PB.TenPB
    FROM
        PHONGBAN AS PB
        JOIN NHANVIEN AS NV
        ON PB.MaPB = NV.MaPB
    GROUP BY 
        PB.MaPB,
        PB.TenPB
    HAVING AVG(NV.Luong) > 30000
)
SELECT
    LL3.TenPB,
    COUNT(NV.MaNV) AS SoNhanVienNu
FROM
    LUONG_LONHON_30000 AS LL3
    JOIN NHANVIEN AS NV
    ON LL3.MaPB = NV.MaPB
WHERE NV.GioiTinh = 'F'
GROUP BY LL3.TenPB;
GO


--31. Cho biet ho ten cac nhan vien co tren 2 nguoi than.
--Cach 1: Truy van long dung IN
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE NV.MaNV IN (
    SELECT NV.MaNV
    FROM
        NHANVIEN AS NV
        LEFT JOIN THANNHAN AS TN
        ON NV.MaNV = TN.MaNV
    GROUP BY NV.MaNV
    HAVING COUNT(TN.MaNV) > 2
);
GO
--Cach 2: Truy van long dung COUNT
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE 2 < (
    SELECT COUNT(TN.MaNV)
    FROM THANNHAN AS TN
    WHERE TN.MaNV = NV.MaNV
);
GO
--Cach 3: Bang tam
WITH THANNHAN_LONHON_2(MaNV) AS (
    SELECT NV.MaNV
    FROM
        NHANVIEN AS NV
        LEFT JOIN THANNHAN AS TN
        ON NV.MaNV = TN.MaNV
    GROUP BY NV.MaNV
    HAVING COUNT(TN.MaNV) > 2
)
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM
    NHANVIEN AS NV
    JOIN THANNHAN_LONHON_2 AS TN2
    ON NV.MaNV = TN2.MaNV;
GO


--32. Cho biet ho ten cac nhan vien khong co nguoi than nao.
--Cach 1: Truy van long dung NOT EXISTS
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE NOT EXISTS (
    SELECT TN.MaNV
    FROM THANNHAN AS TN
    WHERE NV.MaNV = TN.MaNV
)
GO
--Cach 2: Truy van long dung COUNT
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE NV.MaNV IN (
    SELECT NV.MaNV
    FROM
        NHANVIEN AS NV
        LEFT JOIN THANNHAN AS TN
        ON NV.MaNV = TN.MaNV
    GROUP BY NV.MaNV
    HAVING COUNT(TN.MaNV) = 0
);
GO
--Cach 3: Truy van long dung COUNT
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE 0 = (
    SELECT COUNT(TN.MaNV)
    FROM THANNHAN AS TN
    WHERE TN.MaNV = NV.MaNV
)
GO
--Cach 4: Dung bang tam
WITH THANNHAN_BANG_0(MaNV) AS (
    SELECT NV.MaNV
    FROM
        NHANVIEN AS NV
        LEFT JOIN THANNHAN AS TN
        ON NV.MaNV = TN.MaNV
    GROUP BY NV.MaNV
    HAVING COUNT(TN.MaNV) = 0
)
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM
    NHANVIEN AS NV
    JOIN THANNHAN_BANG_0 AS TN2
    ON NV.MaNV = TN2.MaNV;
GO


--33. Cho biet ho ten cac truong phong co it nhat mot nguoi than.
--Cach 1: Truy van dung EXISTS
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE EXISTS (
    SELECT TN.MaNV
    FROM THANNHAN AS TN
    WHERE NV.MaNV = TN.MaNV
)
GO
--Cach 2: Truy van long dung COUNT
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE NV.MaNV IN (
    SELECT NV.MaNV
    FROM
        NHANVIEN AS NV
        LEFT JOIN THANNHAN AS TN
        ON NV.MaNV = TN.MaNV
    GROUP BY NV.MaNV
    HAVING COUNT(TN.MaNV) >= 1
);
GO
--Cach 3: Truy van long dung COUNT
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM NHANVIEN AS NV
WHERE 1 <= (
    SELECT COUNT(TN.MaNV)
    FROM THANNHAN AS TN
    WHERE TN.MaNV = NV.MaNV
)
GO
--Cach 4: Dung bang tam
WITH THANNHAN_KHONG_NHOHON_1(MaNV) AS (
    SELECT NV.MaNV
    FROM
        NHANVIEN AS NV
        LEFT JOIN THANNHAN AS TN
        ON NV.MaNV = TN.MaNV
    GROUP BY NV.MaNV
    HAVING COUNT(TN.MaNV) >= 1
)
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM
    NHANVIEN AS NV
    JOIN THANNHAN_KHONG_NHOHON_1 AS TN1
    ON NV.MaNV = TN1.MaNV;
GO


--34. Cho biet ho ten cac nhan vien co muc luong tren muc luong trung binh cua phong 'Nghien cuu'.
--Cach 1: Truy van long
SELECT CONCAT(HoNV, ' ', Dem, ' ', TenNV) AS HoTenNhanVien
FROM NHANVIEN
WHERE Luong > (
    SELECT AVG(Luong)
    FROM
        NHANVIEN AS NV
        JOIN PHONGBAN AS PB
        ON NV.MaPB = PB.MaPB
    WHERE PB.TenPB = 'Nghien cuu'
);
GO
--Cach 2: Bang tam
WITH LUONG_PHONG_NGHIEN_CUU(Luong) AS (
    SELECT AVG(Luong)
    FROM
        NHANVIEN AS NV
        JOIN PHONGBAN AS PB
        ON NV.MaPB = PB.MaPB
    WHERE PB.TenPB = 'Nghien cuu'
)
SELECT CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien
FROM 
    NHANVIEN AS NV,
    LUONG_PHONG_NGHIEN_CUU AS LNC
WHERE NV.LUONG > LNC.Luong;
GO


--35. Cho biet ten phong va ho ten truong phong cua phong co dong nhan vien nhat.
--Cach 1: Truy van long
SELECT
    PB.TenPB,
    CONCAT(QL.HoNV, ' ', QL.Dem, ' ', QL.TenNV) AS HoTenTruongPhong
FROM
    PHONGBAN AS PB
    JOIN NHANVIEN AS QL
    ON PB.MaQL = QL.MaNV
WHERE PB.MaPB IN (
    SELECT MaPB
    FROM NHANVIEN
    GROUP BY MaPB
    HAVING COUNT(MaNV) >= ALL(
        SELECT COUNT(MaNV)
        FROM NHANVIEN
        GROUP BY MaPB
    )
);
GO
--Cach 2: Bang tam
WITH SO_NV_PHONG(MaPB, SoNhanVien) AS (
    SELECT
        MaPB,
        COUNT(MaNV)
    FROM NHANVIEN
    GROUP BY MaPB
)
SELECT
    PB.TenPB,
    CONCAT(QL.HoNV, ' ', QL.Dem, ' ', QL.TenNV) AS HoTenTruongPhong
FROM
    PHONGBAN AS PB
    JOIN NHANVIEN AS QL
    ON QL.MaNV = PB.MaQL
WHERE PB.MaPB IN (
    SELECT MaPB
    FROM SO_NV_PHONG
    WHERE SoNhanVien = (
        SELECT MAX(SoNhanVien)
        FROM SO_NV_PHONG
    )
);


--36. Cho biet ho ten va dia chi cac nhan vien lam viec cho mot du an o 'Phu Nhuan'
--nhung phong lam viec ma ho lam viec lai khong co tru so o 'Phu Nhuan'.
--Cach 1: Truy van long dung NOT EXISTS
SELECT
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien,
    NV.DiaChi
FROM
    NHANVIEN AS NV
    JOIN THAMGIA AS TG
    ON NV.MaNV = TG.MaNV
    JOIN DUAN AS DA
    ON TG.MaDA = DA.MaDA
WHERE
    DA.DiaDiem = 'Phu Nhuan'
    AND NOT EXISTS (
        SELECT TSP.TruSo
        FROM TRUSO_PHONG AS TSP
        WHERE 
            TSP.TruSo = 'Phu Nhuan'
            AND TSP.MaPB = NV.MaPB
    );
GO
--Cach 2: Truy van long dung NOT IN
SELECT
    CONCAT(NV.HoNV, ' ', NV.Dem, ' ', NV.TenNV) AS HoTenNhanVien,
    NV.DiaChi
FROM
    NHANVIEN AS NV
    JOIN THAMGIA AS TG
    ON NV.MaNV = TG.MaNV
    JOIN DUAN AS DA
    ON TG.MaDA = DA.MaDA
WHERE
    DA.DiaDiem = 'Phu Nhuan'
    AND NV.MaPB NOT IN (
        SELECT TSP.MaPB
        FROM TRUSO_PHONG AS TSP
        WHERE 
            TSP.TruSo = 'Phu Nhuan'
            AND TSP.MaPB = NV.MaPB
    );
GO
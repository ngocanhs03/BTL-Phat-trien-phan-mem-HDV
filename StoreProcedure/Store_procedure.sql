--Bảng sản phẩm
--lấy ra sản phẩm từ id
create proc sp_get_sanpham_byid
(
	@MaSanPham int
)
as
begin
	select * from SanPham
	where MaSanPham = @MaSanPham
end
go

--lấy toàn bộ sản phẩm
create proc sp_get_all_sanpham
as
begin
	select * from SanPham
end
go

--thêm sản phẩm
create proc sp_them_sanpham
(
	@TenSanPham int,
	@Size int,
	@GiaTien int,
	@GiamGia int,
	@LinkAnh varchar(500),
	@MoTa nvarchar(500),
	@SoLuong int,
	@DaBan int,
	@MaDanhMuc int,
	@MaThuongHieu int
)
as
begin
	insert into SanPham(TenSanPham, Size, GiaTien, GiamGia, LinkAnh, MoTa, SoLuong, DaBan, MaDanhMuc, MaThuongHieu)
	values(@TenSanPham, @Size, @GiaTien, @GiamGia, @LinkAnh, @MoTa, @SoLuong, @DaBan, @MaDanhMuc, @MaThuongHieu)
end
go

--sửa sản phẩm
create proc sp_sua_sanpham
(
	@MaSanPham int
	@TenSanPham int,
	@Size int,
	@GiaTien int,
	@GiamGia int,
	@LinkAnh varchar(500),
	@MoTa nvarchar(500),
	@SoLuong int,
	@DaBan int,
	@MaDanhMuc int,
	@MaThuongHieu int
)
as
begin
	UPDATE SanPham
	SET TenSanPham=@TenSanPham , Size = @Size,  GiaTien = @GiaTien, GiamGia=@GiamGia, LinkAnh=@LinkAnh, MoTa=@MoTa, SoLuong = @SoLuong, DaBan=@DaBan, MaDanhMuc=@MaDanhMuc, MaThuongHieu=@MaThuongHieu
	where MaSanPham = @MaSanPham
end
go

--xóa sản phẩm
create proc sp_xoa_sanpham
(
	@MaSanPham int
)
as 
begin
	delete from SanPham where MaSanPham = @MaSanPham
end
go

--tìm kiếm sản phẩm
create PROCEDURE [dbo].[sp_search_sanpham] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_sanpham nvarchar(250),
									   @gia_tien varchar(50))
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaSanPham ASC)) AS RowNumber, 
                              sp.MaSanPham,
							  sp.TenSanPham,
							  sp.GiaTien
                        INTO #Results1
                        FROM [SanPham] AS sp
					    WHERE (@ten_sanpham = '' or sp.TenSanPham like N'%' + @ten_sanpham +'%') and
						(@gia_tien is null or sp.GiaTien like N'%' + @gia_tien +'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaSanPham ASC)) AS RowNumber, 
                              sp.MaSanPham,
							  sp.TenSanPham,
							  sp.GiaTien
                        INTO #Results2
                        FROM [SanPham] AS sp
					    WHERE (@ten_sanpham = '' or sp.TenSanPham like N'%' + @ten_sanpham +'%') and
						(@gia_tien is null or sp.GiaTien like N'%' + @gia_tien +'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2
                        DROP TABLE #Results2; 
        END;
    END;
go

--bảng khách hàng
--lấy khách hàng theo id
create proc sp_get_khachhang_byid
(
	@MaKhachHang int
)
as
begin
	select * from KhachHang
	where MaKhachHang = @MaKhachHang
end
go

--lấy tất cả khách hàng
create proc sp_get_all_khachhang
as
begin
	select * from KhachHang
end
go

--thêm khách hàng
create proc sp_them_khachhang
(
	@TenKhachHang nvarchar(500),
	@Email varchar(100),
	@DiaChi nvarchar(250),
	@SDT varchar(20)
)
as
begin
	insert into KhachHang(TenKhachHang, Email, DiaChi, SDT)
	values(@TenKhachHang, @Email, @DiaChi, @SDT)
end
go

--sửa khách hàng
create proc sp_sua_khachhang
(
	@MaKhachHang int,
	@TenKhachHang nvarchar(500),
	@Email varchar(100),
	@DiaChi nvarchar(250),
	@SDT varchar(20)
)
as
begin
	update KhachHang
	set DiaChi = @DiaChi
end
go

--xóa khách hàng
create proc sp_xoa_khachhang
(
	@MaKhachHang int
)
as
begin
	delete KhachHang
	where MaKhachHang = @MaKhachHang
end
go

--tìm kiếm khách hàng
create PROCEDURE sp_search_khachhang (@page_index  INT, 
                                       @page_size   INT,
									   @tenKH nvarchar(500),
									   @diaChi nvarchar(250))
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaKhachHang ASC)) AS RowNumber, 
                              kh.MaKhachHang,
							  kh.TenKhachHang,
							  kh.Email,
							  kh.DiaChi
                        INTO #Results1
                        FROM [KhachHang] AS kh
					    WHERE (@tenKH = '' or kh.TenKhachHang like N'%' + @tenKH +'%') and
						(@diaChi = '' or kh.DiaChi like N'%' + @diaChi +'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaKhachHang ASC)) AS RowNumber, 
                              kh.MaKhachHang,
							  kh.TenKhachHang,
							  kh.Email,
							  kh.DiaChi
                        INTO #Results2
                        FROM [KhachHang] AS kh
					    WHERE (@tenKH = '' or kh.TenKhachHang like N'%' + @tenKH +'%') and
						(@diaChi = '' or kh.DiaChi like N'%' + @diaChi +'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2
                        DROP TABLE #Results2; 
        END;
    END;
go


--Bảng hóa đơn nhập
--thêm hóa đơn nhập
create PROCEDURE [dbo].[sp_hoadonnhap_create]
(@MaDanhMuc             int, 
 @TongTien          int, 
 @list_json_chitietHDN NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDonNhap INT;
        INSERT INTO HoaDonNhap
                (MaDanhMuc, 
                 TongTien               
                )
                VALUES
                (@MaDanhMuc, 
                 @TongTien);

				SET @MaHoaDonNhap = (SELECT SCOPE_IDENTITY());
				DECLARE @TongTienHoaDon DECIMAL(18, 2);
				SET @TongTienHoaDon = 0;
                IF(@list_json_chitietHDN IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHDN
						 (MaThuongHieu, 
						  MaHoaDonNhap,
                          MaSanPham, 
                          SoLuong,
						  GiaNhap,
						  TongTien
                        )
                    SELECT JSON_VALUE(p.value, '$.maThuongHieu'), 
                            @MaHoaDonNhap, 
                            JSON_VALUE(p.value, '$.maSanPham'), 
                            JSON_VALUE(p.value, '$.soLuong'),
                            JSON_VALUE(p.value, '$.giaNhap'),
							CAST(JSON_VALUE(p.value, '$.giaNhap') AS INT) * CAST(JSON_VALUE(p.value, '$.soLuong') AS INT)
                    FROM OPENJSON(@list_json_chitietHDN) AS p;

					SELECT @TongTienHoaDon = SUM(TongTien)
					FROM ChiTietHDN
					WHERE MaHoaDonNhap = @MaHoaDonNhap;

					-- Cập nhật tổng tiền vào hóa đơn nhập
					UPDATE HoaDonNhap
					SET TongTien = @TongTienHoaDon
					WHERE MaHoaDonNhap = @MaHoaDonNhap;
                END;
        SELECT '';
    END;
go

--Bảng danh mục
--lấy danh mục theo id
create proc sp_get_danhmuc_by_id
(
	@MaDanhMuc int
)
as
begin
	select * from DanhMuc
	where MaDanhMuc = @MaDanhMuc
end
go

--lấy toàn bộ danh mục
create proc sp_get_all_danhmuc
as
begin
	select * from DanhMuc
end
go

--thêm danh mục
create proc sp_create_danhmuc
(
	@TenDanhMuc nvarchar(350)
)
as
begin
	insert into DanhMuc(TenDanhMuc)
	values(@TenDanhMuc)
end
go

--sửa danh mục
create proc sp_update_danhmuc
(
	@MaDanhMuc int,
	@TenDanhMuc nvarchar(350)
)
as
begin
	if @TenDanhMuc is not null and @TenDanhMuc <> 'string'
	begin
		update DanhMuc
		set TenDanhMuc = @TenDanhMuc
		where MaDanhMuc = @MaDanhMuc
	end
end
go

--xóa danh mục
create proc sp_delete_danhmuc
(
	@MaDanhMuc int
)
as
begin
	delete DanhMuc
	where MaDanhMuc = @MaDanhMuc
end
go

--tìm kiếm danh mục
create PROCEDURE sp_search_danhmuc (@page_index  INT, 
                                    @page_size   INT,
									@ten_danhmuc nvarchar(350))
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaDanhMuc ASC)) AS RowNumber, 
                              dm.MaDanhMuc,
							  dm.TenDanhMuc
                        INTO #Results1
                        FROM [DanhMuc] AS dm
					    WHERE (@ten_danhmuc = '' or dm.TenDanhMuc like N'%' + @ten_danhmuc +'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                              ORDER BY MaDanhMuc ASC)) AS RowNumber, 
                              dm.MaDanhMuc,
							  dm.TenDanhMuc
                        INTO #Results2
                        FROM [DanhMuc] AS dm
					    WHERE (@ten_danhmuc = '' or dm.TenDanhMuc like N'%' + @ten_danhmuc +'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2
                        DROP TABLE #Results2; 
        END;
    END;
go

thuan yeu anh
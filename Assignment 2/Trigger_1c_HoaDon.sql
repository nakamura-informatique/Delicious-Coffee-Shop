CREATE TRIGGER trg_CapNhatDiemKhachHang
ON HOADON
FOR UPDATE AS
BEGIN
	DECLARE @MaHD char(16), @ThanhToan bit, @ChuaThanhToan bit, @ID char(12), @TongTien decimal(12, 2)
	SELECT	@MaHD=MAHOADON FROM	inserted
	SELECT	@ThanhToan=DATHANHTOAN
	FROM	inserted
	WHERE	MAHOADON=@MaHD
	SELECT	@ChuaThanhToan=DATHANHTOAN
	FROM	deleted
	where	MAHOADON=@MaHD

	IF @ThanhToan=1 AND @ChuaThanhToan=0
	BEGIN
		SELECT	@ID=MAKHACHHANG, @TongTien=TONGTIEN
		FROM	inserted
		WHERE	MAHOADON=@MaHD
		IF		@TongTien IS NULL
		SET		@TongTien=0

		UPDATE	KHACHHANG
		SET		DIEM=DIEM+FLOOR(@TongTien/10000)
		WHERE	CMND=@ID
	END
END
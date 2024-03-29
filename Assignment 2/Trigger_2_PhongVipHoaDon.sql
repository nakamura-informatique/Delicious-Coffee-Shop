CREATE TRIGGER trg_KiemTraPhongVip
ON PHONGVIPHOADON
FOR INSERT, UPDATE AS
BEGIN
	DECLARE @MaHD char(16), @MaPV nvarchar(255), @MaHD_DangNgoi char(16), @GioVao time(7), @Ngay date
	SELECT	@MaHD=MAHOADON FROM inserted
	SELECT	@MaPV=MAPHONGVIP
	FROM	inserted
	WHERE	MAHOADON=@MaHD
	
	SELECT	@GioVao=GIOVAO, @Ngay=NGAY
	FROM	HOADON
	WHERE	MAHOADON=@MaHD

	SELECT	@MaHD_DangNgoi=PV.MAHOADON
	FROM	PHONGVIPHOADON PV, HOADON HD
	WHERE	PV.MAHOADON=HD.MAHOADON AND HD.NGAY=@Ngay AND HD.GIOVAO<@GioVao AND (HD.GIORA IS NULL OR HD.GIORA>@GioVao) AND PV.MAPHONGVIP=@MaPV

	IF @MaHD_DangNgoi IS NOT NULL
	BEGIN
		RAISERROR('CO NGUOI DANG NGOI PHONG VIP NAY !!!', 16, 1)
		ROLLBACK
	END
END
﻿namespace Models
{
    public class HoaDonDatHangModel
    {
        public int MaHoaDon { get; set; }
        public DateTime NgayTao { get; set; }
        public int MaVanChuyen { get; set; }
        public int MaKhachHang { get; set; }
        public string CodeHoaDon { get; set; }
        public DateTime NgayDat { get; set; }
        public int TrangThai { get; set; }

    }
}
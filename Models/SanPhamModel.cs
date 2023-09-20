namespace Models
{
    public class SanPhamModel
    {
        public int SanPhamID { get; set; }
        public string TenSanPham { get; set; }
        public string Size { get; set; }
        public int SoLuong { get; set; }
        public int GiaTien { get; set; }
        public bool TrangThai { get; set; }

    }
}
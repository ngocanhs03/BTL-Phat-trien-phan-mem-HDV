using BusinessLogicLayer;
using Models;
using Microsoft.AspNetCore.Mvc;


namespace Api.BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KhachHangController : ControllerBase
    {
        private IKhachHangBusiness khachHangBusiness1;
        public KhachHangController(IKhachHangBusiness khachHangBusiness)
        {
            khachHangBusiness1 = khachHangBusiness;
        }

        [Route("get-by-id/{id}")]
        [HttpGet]
        public KhachHangModel GetSanPhamByID(string id)
        {
            return khachHangBusiness1.GetKhachHangByID(id);
        }


        [Route("create-khachhang")]
        [HttpPost]
        public KhachHangModel CreateKhachHang([FromBody] KhachHangModel model)
        {
            khachHangBusiness1.Create(model);
            return model;
        }

        [Route("update-khachhang")]
        [HttpPost]
        public KhachHangModel UpdateKhachHang([FromBody] KhachHangModel model)
        {
            khachHangBusiness1.Update(model);
            return model;
        }

        [Route("delete-khachhang")]
        [HttpPost]
        public IActionResult DeleteKhachHang([FromBody] Dictionary<string, object> formData)
        {
            string MaKhachHang = "";
            if (formData.Keys.Contains("MaKhachHang") && !string.IsNullOrEmpty(Convert.ToString(formData["MaKhachHang"]))) { MaKhachHang = Convert.ToString(formData["MaKhachHang"]); }
            khachHangBusiness1.Delete(MaKhachHang);
            return Ok();
        }
        [Route("search")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            var response = new ResponseModel();
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string ten_khachhang = "";
                if (formData.Keys.Contains("ten_khachhang") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_khachhang"]))) { ten_khachhang = Convert.ToString(formData["ten_khachhang"]); }
                string SDT = 0;
                if (formData.Keys.Contains("SDT") && !string.IsNullOrEmpty(Convert.ToString(formData["SDT"]))) { SDT = Convert.ToString(formData["SDT"]); }
                long total = 0;
                var data = khachHangBusiness1.Search(page, pageSize, out total, ten_khachhang, SDT);
                return Ok(
                    new
                    {
                        TotalItems = total,
                        Data = data,
                        Page = page,
                        PageSize = pageSize
                    });
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


    }
}

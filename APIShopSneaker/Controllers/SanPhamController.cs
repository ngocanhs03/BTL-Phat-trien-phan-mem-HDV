using BusinessLogicLayer;
using Models;
using Microsoft.AspNetCore.Mvc;


namespace Api.BTL.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusiness _sanPhamBusiness;
        public SanPhamController(ISanPhamBusiness sanPhamBusiness)
        {
            _sanPhamBusiness = sanPhamBusiness;
        }
       

        [Route("create-sanpham")]
        [HttpPost]
        public SanPhamModel CreateSanPham([FromBody] SanPhamModel model)
        {
            _sanPhamBusiness.Create(model);
            return model;
        }

        [Route("update-sanpham")]
        [HttpPost]
        public SanPhamModel UpdateItem([FromBody] SanPhamModel model)
        {
            _sanPhamBusiness.Update(model);
            return model;
        }

        [Route("delete-sanpham")]
        [HttpPost]
        public IActionResult DeleteSanPham([FromBody] Dictionary<string, object> formData)
        {
            string SanPhamID = "";
            if (formData.Keys.Contains("SanPhamID") && !string.IsNullOrEmpty(Convert.ToString(formData["SanPhamID"]))) { SanPhamID = Convert.ToString(formData["SanPhamID"]); }
            _sanPhamBusiness.Delete(SanPhamID);
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
                string ten_sanpham = "";
                if (formData.Keys.Contains("ten_sanpham") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_sanpham"]))) { ten_sanpham = Convert.ToString(formData["ten_sanpham"]); }
                string so_luong = "";
                if (formData.Keys.Contains("so_luong") && !string.IsNullOrEmpty(Convert.ToString(formData["so_luong"]))) { so_luong = Convert.ToString(formData["so_luong"]); }
                long total = 0;
                var data = _sanPhamBusiness.Search(page, pageSize, out total, ten_sanpham, so_luong);
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

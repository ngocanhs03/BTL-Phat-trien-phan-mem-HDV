﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Models;

namespace DataAccessLayer.Interfaces
{
    public partial interface IDanhMucRepository
    {
        DanhMucModel GetDanhMucByID(string id);

        List<DanhMucModel> GetAllDanhMuc();
        bool Create(DanhMucModel model);
        bool Update(DanhMucModel model);
        bool Delete(string id);

        List<DanhMucModel> Search(int pageIndex, int pageSize, out long total, string ten_danhmuc);
    }
}

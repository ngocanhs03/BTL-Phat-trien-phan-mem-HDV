﻿using Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer.Interfaces
{
    public partial interface IHoaDonNhapRepository
    {
        bool Create(HoaDonNhapModel model);

        //bool Update(HoaDonNhapModel model);
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WEBAPI.Entities;

namespace WEBAPI.Controllers
{
    public class CategoriaController : ApiController
    {

        [HttpPost]
        [Route("RegistrarCategoria")]
        public string RegistrarCategoria(CategoriaEnt entidad)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {

                    context.InsertarCategoria(entidad.Descripcion, entidad.Estado);
                    return "OK";
                }
            }
            catch (Exception)
            {
                return string.Empty;
            }
        }

    }
}

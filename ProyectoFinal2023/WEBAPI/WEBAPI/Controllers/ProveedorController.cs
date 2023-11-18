using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WEBAPI.Entities;

namespace WEBAPI.Controllers
{
    public class ProveedorController : ApiController
    {
        [HttpPost]
        [Route("ProveedorController")]
        public string RegistrarProveedor(ProveedoresEnt entidad)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {

                    context.InsertarProveedor(entidad.NombreEmpresa, entidad.NombreContacto, entidad.Direccion, entidad.Ciudad, entidad.Canton, entidad.CodigoPostal, entidad.Telefono, entidad.Estado);
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

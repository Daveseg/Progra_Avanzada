using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WEBAPI.Entities;

namespace WEBAPI.Controllers
{
    public class ProductoController : ApiController
    {

        [HttpGet]
        [Route("ConsultaProductosA")]
        public List<TProductos> ConsultaProductosA()
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {
                    context.Configuration.LazyLoadingEnabled = false;
                    return (from x in context.TProductos
                            where x.Estado == true
                            select x).ToList();
                }
            }
            catch (Exception)
            {
                return new List<TProductos>();
            }
        }

        [HttpGet]
        [Route("ConsultaProductos")]
        public List<TProductos> ConsultaProductos()
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {
                    context.Configuration.LazyLoadingEnabled = false;
                    return (from x in context.TProductos
                            select x).ToList();
                }
            }
            catch (Exception)
            {
                return new List<TProductos>();
            }
        }

        [HttpGet]
        [Route("ConsultaProducto")]
        public TProductos ConsultaProducto(long q)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {
                    context.Configuration.LazyLoadingEnabled = false;
                    return (from x in context.TProductos
                            where x.ConProductos == q 
                            select x).FirstOrDefault();
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        [HttpPost]
        [Route("RegistrarProducto")]
        public string RegistrarProducto(ProductosEnt entidad)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {

                    context.InsertarProductos(entidad.NombreProducto, entidad.ConProveedores, entidad.ConCategoria, entidad.Precio, entidad.TotalUnidades, entidad.Estado);
                    return "OK";
                }
            }
            catch (Exception)
            {
                return string.Empty;
            }
        }

        [HttpPut]
        [Route("ModificarProducto")]
        public string ModificarProducto(ProductosEnt entidad)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {

                    context.ActualizarProductos(entidad.ConProductos, entidad.NombreProducto, entidad.ConProveedores, entidad.ConCategoria, entidad.Precio, entidad.TotalUnidades, entidad.Estado);
                    return "OK";
                }
            }
            catch (Exception ex)
            {
                //return ex.Message;
                return string.Empty;
            }
        }


    }
}

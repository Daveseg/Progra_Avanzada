using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WEBAPI.Controllers;
using WEBAPI.Entities;


namespace WEBAPI.Controllers
{
    public class LoginController : ApiController
    {
        [HttpPost]
        [Route("IniciarSesion")]
        public IniciarSesionSP_Result IniciarSesion(UsuarioEnt entidad)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {
                    //return (from x in context.TUsuario 
                    //             where x.Correo == entidad.Correo
                    //             && x.Contrasenna == entidad.Contrasenna
                    //             && x.Estado == true
                    //             select x).FirstOrDefault();

                    return context.IniciarSesionSP(entidad.Correo, entidad.Contrasenna).FirstOrDefault();
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        [HttpPost]
        [Route("RegistrarCuenta")]
        public string RegistrarCuenta(UsuarioEnt entidad)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {
                    //TUsuario user = new TUsuario();
                    //user.Identificacion = entidad.Identificacion;
                    //user.Nombre = entidad.Nombre;
                    //user.Correo = entidad.Correo;
                    //user.Contrasenna = entidad.Contrasenna;
                    //user.Estado = entidad.Estado;
                    //user.Direccion = entidad.Direccion;

                    //context.TUsuario.Add(user);
                    //context.SaveChanges();

                    context.RegistrarCuentaSP(entidad.Cedula, entidad.Nombre, entidad.Correo, entidad.Contrasenna);
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

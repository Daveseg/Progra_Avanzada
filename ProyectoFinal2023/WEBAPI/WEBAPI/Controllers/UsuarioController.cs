using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WEBAPI.Entities;

namespace WEBAPI.Controllers
{
    public class UsuarioController : ApiController
    {

        [HttpGet]
        [Route("ConsultaUsuarios")]
        public List<TUsuario> ConsultaUsuarios()
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {
                    context.Configuration.LazyLoadingEnabled = false;
                    return (from x in context.TUsuario
                            select x).ToList();
                }
            }
            catch (Exception)
            {
                return new List<TUsuario>();
            }
        }

        [HttpGet]
        [Route("ConsultaUsuario")]
        public TUsuario ConsultaUsuario(long q)
        {
            try
            {
                using (var context = new GYM_PROYECTOEntities())
                {
                    context.Configuration.LazyLoadingEnabled = false;
                    return (from x in context.TUsuario
                            where x.ConUsuario == q
                            select x).FirstOrDefault();
                }
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}

using ProyectoVersion._1._0.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProyectoVersion._1._0.Models;

namespace ProyectoVersion._1._0.Controllers
{
    public class UsuarioController : Controller
    {


        UsuarioModel modelUsuario = new UsuarioModel();


        // GET: Usuario
        public ActionResult Index()
        {
            return View();
        }



    }
}
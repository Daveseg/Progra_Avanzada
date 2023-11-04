using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using ProyectoVersion._1._0.Entities;
using ProyectoVersion._1._0.Models;
 

namespace ProyectoVersion._1._0.Controllers
{
    public class LoginController : Controller
    {

        UsuarioModel modelUsuario = new UsuarioModel();
        // GET: Login


        public ActionResult Index()
        {
            return View();
        }


        //INICIAR SESSION

        [HttpGet]
        public ActionResult IniciarSesion()
        { 
            return View();
        }

        [HttpPost]
        public ActionResult IniciarSesion(UsuarioEnt entidad)
        {
            var respuesta = modelUsuario.IniciarSesion(entidad);

            if (respuesta != null)
            {
                Session["NombreUsuario"] = respuesta.Nombre;
                return RedirectToAction("Index", "Login");
            }
            else
            {
                ViewBag.MensajeUsuario = "No se ha podido validar su información";
                return View();
            }
        }

        //REGISTAR UNA CUENTA 

        [HttpGet]
        public ActionResult RegistrarCuenta()
        {
            return View();
        }

        [HttpPost]
        public ActionResult RegistrarCuenta(UsuarioEnt entidad)
        {
            string respuesta = modelUsuario.RegistrarCuenta(entidad);

            if (respuesta == "OK")
            {
                return RedirectToAction("IniciarSesion", "Login");
            }
            else
            {
                ViewBag.MensajeUsuario = "No se ha podido registrar su información";
                return View();
            }
        }


        //CERRAR SECCION 

        [HttpGet]
        public ActionResult CerrarSesion()
        {
            Session.Clear();
            return RedirectToAction("IniciarSesion", "Login");
        }



        //RECUPERAR CUENTA 

        [HttpGet]
        public ActionResult RecuperarCuenta()
        {
            return View();
        }

        [HttpPost]
        public ActionResult RecuperarCuenta(UsuarioEnt entidad)
        {
            string respuesta = modelUsuario.RecuperarCuenta(entidad);

            if (respuesta == "OK")
            {
                return RedirectToAction("IniciarSesion", "Login");
            }
            else
            {
                ViewBag.MensajeUsuario = "No se ha podido recuperar su información";
                return View();
            }
        }






    }
}
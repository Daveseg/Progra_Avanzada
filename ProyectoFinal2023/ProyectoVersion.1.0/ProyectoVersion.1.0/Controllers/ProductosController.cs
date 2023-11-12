using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoVersion._1._0.Controllers
{
    public class ProductosController : Controller
    {
        // GET: Productos
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Shakers()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Accesorios()
        {
            return View();
        }
        [HttpGet]
        public ActionResult ProteinasPolvo()
        {
            return View();
        }
        [HttpGet]
        public ActionResult ProteinasSuero()
        {
            return View();
        }
        [HttpGet]
        public ActionResult ProteinasVegetal()
        {
            return View();
        }
        [HttpGet]
        public ActionResult SuplementosAdultos()
        {
            return View();
        }
        [HttpGet]
        public ActionResult SuplementosDeportivos()
        {
            return View();
        }
    }
}
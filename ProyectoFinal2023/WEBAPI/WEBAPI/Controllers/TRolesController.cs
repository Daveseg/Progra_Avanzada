using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using WEBAPI;

namespace WEBAPI.Controllers
{
    public class TRolesController : Controller
    {
        private GYM_PROYECTOEntities db = new GYM_PROYECTOEntities();

        // GET: TRoles
        public ActionResult Index()
        {
            return View(db.TRoles.ToList());
        }

        // GET: TRoles/Details/5
        public ActionResult Details(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TRoles tRoles = db.TRoles.Find(id);
            if (tRoles == null)
            {
                return HttpNotFound();
            }
            return View(tRoles);
        }

        // GET: TRoles/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: TRoles/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ConRol,Descripcion")] TRoles tRoles)
        {
            if (ModelState.IsValid)
            {
                db.TRoles.Add(tRoles);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(tRoles);
        }

        // GET: TRoles/Edit/5
        public ActionResult Edit(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TRoles tRoles = db.TRoles.Find(id);
            if (tRoles == null)
            {
                return HttpNotFound();
            }
            return View(tRoles);
        }

        // POST: TRoles/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ConRol,Descripcion")] TRoles tRoles)
        {
            if (ModelState.IsValid)
            {
                db.Entry(tRoles).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(tRoles);
        }

        // GET: TRoles/Delete/5
        public ActionResult Delete(long? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            TRoles tRoles = db.TRoles.Find(id);
            if (tRoles == null)
            {
                return HttpNotFound();
            }
            return View(tRoles);
        }

        // POST: TRoles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(long id)
        {
            TRoles tRoles = db.TRoles.Find(id);
            db.TRoles.Remove(tRoles);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}

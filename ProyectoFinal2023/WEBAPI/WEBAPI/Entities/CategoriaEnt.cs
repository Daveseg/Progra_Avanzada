using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEBAPI.Entities
{
    public class CategoriaEnt
    {
        public long ConCategoria {  get; set; }
        public string Descripcion { get; set;}
        public bool Estado { get; set; }
    }
}
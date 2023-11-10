using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEBAPI.Entities
{
    public class ProductosEnt
    {
        public long ConProductos { get; set; }
        public string NombreProducto { get; set; }
        public long ConProveedores { get; set; }
        public long ConCategoria { get; set; }
        public double Precio { get; set; }
        public int TotalUnidades { get; set; }
        public int Estado {  get; set; }
    }
}

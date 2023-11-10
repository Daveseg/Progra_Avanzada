using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEBAPI.Entities
{
    public class Ordenes
    {
        public long ConOrdenes { get; set; }
        public long ConUsuario { get; set; }
        public long ConProductos { get; set; }
        public DateTime DiaOrden {  get; set; }
        public DateTime FechaEntrega { get; set; }
        public string Direccion { get; set; }
        public string Ciudad {  get; set; }
        public string Canton {  get; set; }
        public string CodigoPostal { get; set; }
        public long ConEstadoOrden { get; set; }
    }
}
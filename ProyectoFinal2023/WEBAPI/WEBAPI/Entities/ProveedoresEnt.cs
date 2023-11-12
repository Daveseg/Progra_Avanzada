using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;

namespace WEBAPI.Entities
{
    public class ProveedoresEnt
    {
        public long ConProveedores { get; set; }
        public string NombreEmpresa { get; set; }
        public string NombreContacto { get; set; }
        public string Direccion {  get; set; }
        public string Ciudad { get; set; }
        public string Canton {  get; set; }
        public string CodigoPostal { get; set; }
        public string Telefono { get; set; }
        public bool Estado { get; set; }
    }
}
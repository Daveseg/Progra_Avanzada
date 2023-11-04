﻿//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WEBAPI
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class GYM_PROYECTOEntities : DbContext
    {
        public GYM_PROYECTOEntities()
            : base("name=GYM_PROYECTOEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<TCategoria> TCategoria { get; set; }
        public virtual DbSet<TEstadoOrden> TEstadoOrden { get; set; }
        public virtual DbSet<TOrdenes> TOrdenes { get; set; }
        public virtual DbSet<TProductos> TProductos { get; set; }
        public virtual DbSet<TProovedores> TProovedores { get; set; }
        public virtual DbSet<TProvincia> TProvincia { get; set; }
        public virtual DbSet<TRoles> TRoles { get; set; }
        public virtual DbSet<TUsuario> TUsuario { get; set; }
    
        public virtual ObjectResult<IniciarSesionSP_Result> IniciarSesionSP(string correo, string contrasenna)
        {
            var correoParameter = correo != null ?
                new ObjectParameter("Correo", correo) :
                new ObjectParameter("Correo", typeof(string));
    
            var contrasennaParameter = contrasenna != null ?
                new ObjectParameter("Contrasenna", contrasenna) :
                new ObjectParameter("Contrasenna", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<IniciarSesionSP_Result>("IniciarSesionSP", correoParameter, contrasennaParameter);
        }
    
        public virtual ObjectResult<RecuperarCuentaSP_Result> RecuperarCuentaSP(string cedula)
        {
            var cedulaParameter = cedula != null ?
                new ObjectParameter("Cedula", cedula) :
                new ObjectParameter("Cedula", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<RecuperarCuentaSP_Result>("RecuperarCuentaSP", cedulaParameter);
        }
    
        public virtual int RegistrarCuentaSP(string cedula, string nombre, string correo, string contrasenna)
        {
            var cedulaParameter = cedula != null ?
                new ObjectParameter("Cedula", cedula) :
                new ObjectParameter("Cedula", typeof(string));
    
            var nombreParameter = nombre != null ?
                new ObjectParameter("Nombre", nombre) :
                new ObjectParameter("Nombre", typeof(string));
    
            var correoParameter = correo != null ?
                new ObjectParameter("Correo", correo) :
                new ObjectParameter("Correo", typeof(string));
    
            var contrasennaParameter = contrasenna != null ?
                new ObjectParameter("Contrasenna", contrasenna) :
                new ObjectParameter("Contrasenna", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("RegistrarCuentaSP", cedulaParameter, nombreParameter, correoParameter, contrasennaParameter);
        }
    }
}

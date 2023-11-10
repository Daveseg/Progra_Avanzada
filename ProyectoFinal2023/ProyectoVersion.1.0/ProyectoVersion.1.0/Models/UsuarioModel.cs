using Newtonsoft.Json;
using ProyectoVersion._1._0.Entities;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Json;
using System.Web;

namespace ProyectoVersion._1._0.Models
{
    public class UsuarioModel
    {

        /*
           GET     = Consultas = Parámetros viajan por el URL al API
           DELETE  = Deletes   = Parámetros viajan por el URL al API
           POST    = Inserts   = Parámetros viajan en un Body al API
           PUT     = Updates   = Parámetros viajan en un Body al API 
       */

        public string rutaServidor = ConfigurationManager.AppSettings["RutaApi"];


        //iniciar session
        public UsuarioEnt IniciarSesion(UsuarioEnt entidad)
        {
            using (var client = new HttpClient())
            {
                var urlApi = rutaServidor + "IniciarSesion";
                var jsonData = JsonContent.Create(entidad);
                var res = client.PostAsync(urlApi, jsonData).Result;
                return res.Content.ReadFromJsonAsync<UsuarioEnt>().Result;
            }
        }

        //RegistrarCuenta
        public string RegistrarCuenta(UsuarioEnt entidad)
        {
            using (var client = new HttpClient())
            {
                var urlApi = rutaServidor + "RegistrarCuenta";
                var jsonData = JsonContent.Create(entidad);
                var res = client.PostAsync(urlApi, jsonData).Result;
                return res.Content.ReadFromJsonAsync<string>().Result;
            }
        }

        //RecuperarCuenta

        public string RecuperarCuenta(UsuarioEnt entidad)
        {
            using (var client = new HttpClient())
            {
                var urlApi = rutaServidor + "RecuperarCuenta?Cedula=" + entidad.Cedula;
                var res = client.GetAsync(urlApi).Result;
                return res.Content.ReadFromJsonAsync<string>().Result;
            }
        }


        //ConsultarUsuario
        public List<UsuarioEnt> ConsultaUsuarios()
        {
            using (var client = new HttpClient())
            {
                var urlApi = rutaServidor + "ConsultaUsuarios";
                var res = client.GetAsync(urlApi).Result;
                return res.Content.ReadFromJsonAsync<List<UsuarioEnt>>().Result;
            }
        }



    }
}
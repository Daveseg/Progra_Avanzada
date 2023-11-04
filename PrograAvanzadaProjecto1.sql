
--CREATE DATA BASE 

--TENGAN CUIDADO CON LOS set identity_insert  OFF OR ON 

CREATE DATABASE GYM_PROYECTO
USE GYM_PROYECTO

DROP DATABASE GYM_PROYECTO
--Tabla TUsuario 


-----Tabla ROL------------ 
CREATE TABLE TRoles(
	ConRol bigint IDENTITY(1,1) NOT NULL,
	Descripcion varchar (30) NOT NULL,
 CONSTRAINT [PK_TRoles] PRIMARY KEY CLUSTERED 
(
	[ConRol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


--// TABLA DE PROVINCIAS

CREATE TABLE TProvincia(
	[ConProvincia] [bigint] NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
 CONSTRAINT [PK_TProvincia] PRIMARY KEY CLUSTERED 
(
	[ConProvincia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--// TABLA DE TUsuario
CREATE TABLE "TUsuario" (
	"ConUsuario" bigint IDENTITY(1,1) NOT NULL,
	"Cedula" varchar (25) NOT NULL ,
	"Nombre" varchar (30) NOT NULL ,
    "Correo" varchar (30) NOT NULL ,
	"Contrasenna" varchar(25) NOT NULL,
	"Direccion" varchar (60) NULL ,
	"Ciudad" varchar (15) NULL ,
	"Canton" varchar (15) NULL ,
	"CodigoPostal" varchar (10) NULL ,
	"Telefono" varchar (24) NULL ,
	"Estado" bit NOT NULL,
	ConRol bigint NOT NULL,
	ConProvincia bigint NOT NULL,
	CONSTRAINT "PKUsuario" PRIMARY KEY  CLUSTERED 
	(
	"ConUsuario"
	),
	CONSTRAINT "FK_TRoles_TUsuario" FOREIGN KEY 
	(
		"ConRol"
	) REFERENCES "dbo"."TRoles" (
		"ConRol"
	),
		CONSTRAINT "FK_TProvincia_TUsuario" FOREIGN KEY 
	(
		"ConProvincia"
	) REFERENCES "dbo"."TProvincia" (
		"ConProvincia"
	)

)

--CREATE TABLE TCategoria 

CREATE TABLE "TCategoria" (
	"ConCategoria" bigint NOT NULL,
	"Descripcion" varchar (50) NOT NULL ,
	CONSTRAINT "PK_Categorias" PRIMARY KEY  CLUSTERED 
	(
		"ConCategoria"
	)
)

-----Tabla TProovedores------------ 
CREATE TABLE "TProovedores" (
    "ConProovedores" bigint IDENTITY(1,1) NOT NULL,
	"NombreEmpresa" varchar (40) NOT NULL ,
	"NombreContacto" varchar (30) NULL ,
	"Direccion" varchar (60) NULL ,
	"Ciudad" varchar (15) NULL ,
	"Canton" varchar (15) NULL ,
	"CodigoPostal" varchar (10) NULL ,
	"Telefono" varchar (24) NULL ,
	CONSTRAINT "PK_Proveedores" PRIMARY KEY  CLUSTERED 
	(
		"ConProovedores" 
	)
) 

--CREATE TABLE PRODUCTOS 
CREATE TABLE "TProductos" (
	"ConProductos" bigint IDENTITY(1,1) NOT NULL,
	"NombreProducto" varchar (40) NOT NULL ,
    "ConProovedores" bigint NOT NULL,
	"ConCategoria" bigint NOT NULL,
	"Precio" "money" NOT NULL,
	"TotalUnidades" int NOT NULL,
	CONSTRAINT "PK_Productos" PRIMARY KEY  CLUSTERED 
	(
		"ConProductos"
	),
	CONSTRAINT "FK_Productos_Categorias" FOREIGN KEY 
	(
		"ConCategoria"
	) REFERENCES "dbo"."TCategoria" (
		"ConCategoria"
	),
	CONSTRAINT "FK_Productos_Proveedores" FOREIGN KEY 
	(
		"ConProovedores"
	) REFERENCES "dbo"."TProovedores" (
		"ConProovedores"
	)
)

--CREATE TABLE ORDENES 

CREATE TABLE "TOrdenes" (
    "ConOrdenes" bigint IDENTITY(1,1) NOT NULL ,
	"ConUsuario" bigint  NOT NULL ,
	"ConProductos" bigint NOT NULL,
	"DiaOrden" datetime NULL ,
	"FechaEntrega" datetime NULL ,
	"Direccion" varchar (60) NULL ,
	"Ciudad" varchar (15) NULL ,
	"Canton" varchar (15) NULL ,
	"CodigoPostal" varchar (10) NULL, 
  	ConEstadoOrden bigint NOT NULL,

	CONSTRAINT "PK_Ordenes" PRIMARY KEY  CLUSTERED 
	(
		"ConOrdenes"
	),
	CONSTRAINT "FK_Ordenes_Usuario" FOREIGN KEY 
	(
		"ConUsuario"
	) REFERENCES "dbo"."TUsuario" (
		"ConUsuario"
	),
	CONSTRAINT "FK_conProducto_Ordenes" FOREIGN KEY 
	(
		"ConProductos"
	) REFERENCES "dbo"."TProductos" (
		"ConProductos"
	),
	CONSTRAINT "FK_conEstado_Ordenes" FOREIGN KEY 
	(
		"ConEstadoOrden"
	) REFERENCES "dbo"."TEstadoOrden" (
		"ConEstadoOrden"
	)
)



-----Tabla ROL------------ 
CREATE TABLE TEstadoOrden(
	ConEstadoOrden bigint IDENTITY(1,1) NOT NULL,
	Descripcion varchar (30) NOT NULL,
 CONSTRAINT [PK_TEstadoOrden] PRIMARY KEY CLUSTERED 
(
	[ConEstadoOrden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--Procedimientos Almacenados ---- 


CREATE PROCEDURE [dbo].[IniciarSesionSP]
	@Correo         varchar(100),
    @Contrasenna    varchar(25)
AS
BEGIN
	SELECT ConUsuario,
		   Cedula,
		   Nombre,
		   Correo,
		   Contrasenna,
		   Estado,
		   P.Descripcion 'DescripcionProvincia',
		   R.Descripcion 'DescripcionRol'
	  FROM dbo.TUsuario	  U
	  INNER JOIN dbo.TRoles		R ON U.ConRol = R.ConRol
	  INNER JOIN dbo.TProvincia P ON U.ConProvincia = P.ConProvincia
	  WHERE Correo = @Correo
	  AND   Contrasenna = @Contrasenna
	  AND	Estado = 1

END


CREATE PROCEDURE [dbo].[RecuperarCuentaSP]
	@Cedula varchar(25)
AS
BEGIN
	
	SELECT Nombre,
		   Correo,
		   Contrasenna
	  FROM dbo.TUsuario
	  WHERE Cedula = @Cedula

END

CREATE PROCEDURE [dbo].[RegistrarCuentaSP]
	@Cedula         varchar(25),
    @Nombre         varchar(250),
    @Correo         varchar(100),
    @Contrasenna    varchar(25)
AS
BEGIN
	INSERT INTO dbo.TUsuario (Cedula,Nombre,Correo,Contrasenna,Estado,ConProvincia,ConRol)
    VALUES (@Cedula,@Nombre,@Correo,@Contrasenna,1,8,2)
END




--INSERTS 
--INSERTS 
--INSERTS 
--INSERTS 
--INSERTS 

INSERT "TCategoria"("ConCategoria","Descripcion") VALUES(1, 'Proteinas')


INSERT "TUsuario" VALUES('CVASQUEZ','Claudio Vasquez','200 Norte de Pequeño Mundo','Heredia','Flores','12209','88545268','1');
INSERT "TUsuario" VALUES('CARIAS','Carlos Arias','50 este de Estadio Fello Mesa,','Cartado','El guarco','35465','88545268','2');


--//TABLA PRODUCTOS 

INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (1, N'San Jose')
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (2, N'Alajuela')
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (3, N'Cartago')
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (4, N'Heredia')
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (5, N'Puntarenas')
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (6, N'Guanacaste')
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (7, N'Limón')
GO
INSERT [dbo].[TProvincia] ([ConProvincia], [Descripcion]) VALUES (8, N'Seleccione')
GO

go
set identity_insert "TCategoria" on
set identity_insert "TCategoria" off

drop table TCategoria


INSERT INTO "ORDENES"
("IDOrden","IDUsuario","DiaOrden","FechaEntrega","DireccionEnvio","CiudadEnvio","CantonEnvio","EnvioCodPostal")
VALUES (10248,'CVASQUEZ',18/7/2023,20/7/2023,'Mall oxigeno Local #5','Heredia','Central','40545');


INSERT "TProductos"("ConProductos","NombreProducto","IDProveedor","IDCategoria","CantidadPorUnidad","Precio","UnidadesEnStock","UnidadesEnOrden","Estado") VALUES(1,'Proteina',100,1,'21000','100','80','5','ACTIVO')


set identity_insert "PRODUCTOS" on
set identity_insert "PRODUCTOS" off



INSERT "TProovedores"("ConProovedores","NombreEmpresa","NombreContacto","Direccion","Ciudad","Canton","CodigoPostal","Telefono") VALUES(1,'GNC','Carlos Castro','400 Oeste Iglesia Corazon','San Jose','Aserri','20548','55886654');

go
set identity_insert "PROVEEDORES" on
set identity_insert "PROVEEDORES" off


INSERT "DETALLEORDEN" VALUES(10248,1,'UPS',12500,5)













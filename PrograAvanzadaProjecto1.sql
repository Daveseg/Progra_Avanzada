
--CREATE DATA BASE 

--TENGAN CUIDADO CON LOS set identity_insert  OFF OR ON 

CREATE DATABASE GYM_PROYECTO
GO

USE GYM_PROYECTO
go

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
GO

--CREATE TABLE TCategoria 

CREATE TABLE "TCategoria" (
	"ConCategoria" bigint IDENTITY(1,1) NOT NULL,
	"Descripcion" varchar (50) NOT NULL ,
	"Estado" bit not null, 
	CONSTRAINT "PK_Categorias" PRIMARY KEY  CLUSTERED 
	(
		"ConCategoria"
	)
)
GO

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
	"Estado" bit not null,
	CONSTRAINT "PK_Proveedores" PRIMARY KEY  CLUSTERED 
	(
		"ConProovedores" 
	)
) 
GO

--CREATE TABLE PRODUCTOS 
CREATE TABLE "TProductos" (
	"ConProductos" bigint IDENTITY(1,1) NOT NULL,
	"NombreProducto" varchar (40) NOT NULL ,
    "ConProovedores" bigint NOT NULL,
	"ConCategoria" bigint NOT NULL,
	"Precio" "money" NOT NULL,
	"TotalUnidades" int NOT NULL,
	"Estado" bit not null,
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
GO

-----Tabla ESTADOS ORDENES------------ 
CREATE TABLE TEstadoOrden(
	ConEstadoOrden bigint IDENTITY(1,1) NOT NULL,
	Descripcion varchar (30) NOT NULL,
 CONSTRAINT [PK_TEstadoOrden] PRIMARY KEY CLUSTERED 
(
	[ConEstadoOrden] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

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

GO
--CREATE TABLE DETALLE ORDEN
CREATE TABLE "TDetalleOrden" (
    "ConOrdenes" bigint NOT NULL,
	"ConProductos" bigint NOT NULL
	CONSTRAINT "FK_Detalle_Orden" FOREIGN KEY 
	(
		"ConOrdenes"
	) REFERENCES "dbo"."TOrdenes" (
		"ConOrdenes"
	),
	CONSTRAINT "FK_Detalle_Producto" FOREIGN KEY 
	(
		"ConProductos"
	) REFERENCES "dbo"."TProductos" (
		"ConProductos"
	)
)
GO

--Procedimientos Almacenados ---- 


CREATE OR ALTER PROCEDURE [dbo].[IniciarSesionSP]
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
GO


CREATE OR ALTER PROCEDURE [dbo].[RecuperarCuentaSP]
	@Cedula varchar(25)
AS
BEGIN
	
	SELECT Nombre,
		   Correo,
		   Contrasenna
	  FROM dbo.TUsuario
	  WHERE Cedula = @Cedula

END
GO

CREATE OR ALTER PROCEDURE [dbo].[RegistrarCuentaSP]
	@Cedula         varchar(25),
    @Nombre         varchar(250),
    @Correo         varchar(100),
    @Contrasenna    varchar(25)
AS
BEGIN
	INSERT INTO dbo.TUsuario (Cedula,Nombre,Correo,Contrasenna,Estado,ConProvincia,ConRol)
    VALUES (@Cedula,@Nombre,@Correo,@Contrasenna,1,8,2)
END
GO

--Procedures Suplementos

CREATE OR ALTER PROCEDURE [dbo].[InsertarProductos]
	@Nombre         varchar(40),
    @Proveedor       bigint,
    @Categoria         bigint,
    @Precio    money,
	@TotalUnidades int
AS
BEGIN
	INSERT INTO dbo.TProductos (NombreProducto,ConProovedores,ConCategoria,Precio,TotalUnidades)
    VALUES (@Nombre,@Proveedor,@Categoria,@Precio,@TotalUnidades)
END
GO

CREATE OR ALTER PROCEDURE [dbo].[ActualizarProductos]
	@IdProducto         bigint,
	@Nombre         varchar(40),
    @Proveedor       bigint,
    @Categoria         bigint,
    @Precio    money,
	@TotalUnidades int,
	@Estado bit
AS
BEGIN
	UPDATE dbo.TProductos 
	SET NombreProducto = @Nombre, ConProovedores = @Proveedor, ConCategoria = @Categoria, Precio = @Precio, TotalUnidades = @TotalUnidades, Estado = @Estado
	WHERE ConProductos = @IdProducto
END
GO

CREATE OR ALTER PROCEDURE [dbo].[DesactivarProductos]
	@IdProducto         bigint,
	@Estado bit
AS
BEGIN
	UPDATE dbo.TProductos 
	SET Estado = @Estado
	WHERE ConProductos = @IdProducto
END
GO


CREATE OR ALTER PROCEDURE [dbo].[ListarProovedores]

AS
BEGIN
	SELECT * FROM dbo.TProovedores WHERE Estado = 1
END
go

CREATE  OR ALTER PROCEDURE [dbo].[ListarCategorias]
AS
BEGIN
	SELECT * FROM dbo.TCategoria WHERE Estado = 1
END
go

CREATE OR ALTER PROCEDURE [dbo].[ListarProductos]
AS
BEGIN
	SELECT * FROM dbo.TProductos WHERE Estado = 1
END
go

CREATE OR ALTER PROCEDURE [dbo].[InsertarProveedor]
	@Nombre         varchar(40),
    @Contacto      varchar(30),
    @Direccion        varchar(60),
    @Ciudad    varchar(15),
	@Canton varchar(15),
	@CodigoPostal varchar(10),
	@Telefono varchar(24),
	@Estado bit
AS
BEGIN
	INSERT INTO dbo.TProovedores (NombreEmpresa,NombreContacto,Direccion,Ciudad,Canton,CodigoPostal,Telefono,Estado)
    VALUES (@Nombre,@Contacto,@Direccion,@Ciudad,@Canton,@CodigoPostal,@Telefono,@Estado)
END
go

CREATE OR ALTER PROCEDURE [dbo].[ActualizarProveedor]
	@IdProveedor bigint,
	@Nombre         varchar(40),
    @Contacto      varchar(30),
    @Direccion        varchar(60),
    @Ciudad    varchar(15),
	@Canton varchar(15),
	@CodigoPostal varchar(10),
	@Telefono varchar(24),
	@Estado bit
AS
BEGIN
	UPDATE dbo.TProovedores 
    SET NombreEmpresa = @Nombre, NombreContacto = @Contacto, Direccion = @Direccion, Ciudad = @Ciudad, Canton = @Canton, CodigoPostal = @CodigoPostal, Telefono = @Telefono, Estado = @Estado
	WHERE ConProovedores = @IdProveedor 
END
go

CREATE OR ALTER PROCEDURE [dbo].[DesactivarProveedor]
	@IdProveedor bigint,
	@Estado bit
AS
BEGIN
	UPDATE dbo.TProovedores 
    SET Estado = @Estado
	WHERE ConProovedores = @IdProveedor 
END
go

CREATE OR ALTER PROCEDURE [dbo].[InsertarCategoria]
    @Descripcion      varchar(50),
	@Estado bit
AS
BEGIN
	INSERT INTO dbo.TCategoria(Descripcion,Estado)
    VALUES (@Descripcion,@Estado)
END
go

CREATE OR ALTER PROCEDURE [dbo].[ActualizarCategoria]
	@IdCategoria bigint,
	@Descripcion      varchar(50),
	@Estado bit
AS
BEGIN
	UPDATE dbo.TCategoria 
    SET Descripcion = @Descripcion, Estado = @Estado
	WHERE ConCategoria = @IdCategoria 
END
go

CREATE OR ALTER PROCEDURE [dbo].[DesactivarCategoria]
	@IdCategoria bigint,
	@Estado bit
AS
BEGIN
	UPDATE dbo.TCategoria 
    SET Estado = @Estado
	WHERE ConCategoria = @IdCategoria 
END
go

--INSERTS 
--INSERTS 
--INSERTS 
--INSERTS 
--INSERTS 

INSERT "TCategoria"("Descripcion","Estado") VALUES('Proteinas',1)

INSERT INTO [dbo].[TRoles]
           ([Descripcion])
     VALUES
           ('admin')
go

INSERT INTO [dbo].[TRoles]
           ([Descripcion])
     VALUES
           ('usuario')
go

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











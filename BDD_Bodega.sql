/*
Crear una BDD para una bodega donde se controlara los empleados y los 
proveedores, controlar las entradas y salidas de los productos que 
llegam a la bodega.
*/

create database controlBodega
use controlBodega

create table departamento
(
idDep int constraint pk_Dep primary key,
nombreDep nvarchar(50)not null
);

go

create table municipio
(
idMun int constraint pk_Mun primary key,
nombreMun nvarchar(50) not null,
idDep int constraint fk_Dep foreign key references departamento(idDep) not null
);

go

create table barrio
(
idBarrio int constraint pk_Barrio primary key,
nombreBarrio nvarchar(50)not null,
idMun int constraint fk_Mun foreign key references municipio(idMUn) not null
);

create table cliente
(
idCliente int constraint pk_Cliente primary key,
Pnombre nvarchar(100) not null,
Snombre nvarchar(80),
Papellido nvarchar(100) not null,
Sapellido nvarchar (80),
cedula char(16) check (cedula like '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]')
);

create table empresa(
idEmpresa int constraint pk_Empresa primary key,
nombreEmpr nvarchar(100) not null,
ruc char(15) not null,
);

create table empleado(
idEmpleado int constraint pk_Empleado primary key,
codigoEmpleado int unique not null,
PNE nvarchar(100) not null,
SNE nvarchar(100),
PAE nvarchar(100) not null,
SAE nvarchar(100),
idEmpresa int not null,
constraint fk_idEmpresa foreign key (idEmpresa) references empresa(idEmpresa)
)

-->Se supone que cada empleado tiene asignado un rol.
create table EmpleadoRole(
idER int constraint pk_EmpleadoRole primary key,
nombreRole nvarchar(80) not null,
descripRole nvarchar(500),
idEmpleadoRole int constraint fk_empleadoRole foreign key references empleado(idEmpleado)
)


create table proveedor(
idProveedor int constraint pk_idProveedor primary key,
nombrePro nvarchar(100) not null,
ruc char(15),
idEmpresa int constraint fk_empresaProveedor foreign key references empresa(idEmpresa) not null
);

create table emailEmpresa(
idEmail int constraint pk_Email primary key,
Email nvarchar(100),
idEmpresa int constraint fk_empresaEmail foreign key references empresa(idEmpresa)
)

create table emailEmpleado(
idEmail int constraint pk_EmailEmple primary key,
Email nvarchar(100),
idEmpleado int constraint fk_empleadoEmail foreign key references empleado(idEmpleado)
)

create table emailProveedor(
idEmail int constraint pk_EmailProveedor primary key,
Email nvarchar(100),
idProveedor int constraint fk_proveedorEmail foreign key references proveedor(idProveedor)
)

create table direccionCliente
(
idDir int constraint pk_Dir primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_Barrio foreign key references barrio(idBarrio) not null,
idCliente int constraint fk_ClienteDir foreign key references cliente(idCliente) not null
);

create table direccionEmpresa
(
idDir int constraint pk_DirEmpre primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_BarrioEmpre foreign key references barrio(idBarrio) not null,
idEmpresa int constraint fk_EmpresaDir foreign key references empresa(idEmpresa) not null
);

create table direccionEmpleado
(
idDir int constraint pk_DirEmple primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_BarrioEmple foreign key references barrio(idBarrio) not null,
idEmpleado int constraint fk_empleadoDireccion foreign key references empleado(idEmpleado) not null
);

create table direccionProveedor
(
idDir int constraint pk_DirProveedor primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_BarrioProveedor foreign key references barrio(idBarrio) not null,
idProveedor int,
constraint fk_proveedor foreign key(idProveedor) references proveedor(idProveedor) 
);

create table companiaTelefonica(
idCom int constraint pk_Com primary key,
nombre nvarchar(100) not null
)

create table telefonoCliente(
idTel int constraint pk_Tel primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idCliente int not null,
constraint fk_Company foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_ClienteTel foreign key (idCliente) references cliente (idCliente),
)

create table telefonoEmpresa(
idTel int constraint pk_TelEmpre primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idEmpresa int not null,
constraint fk_CompanyTel foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_EmpresaTel foreign key (idEmpresa) references empresa(idEmpresa),
)

create table telefonoEmpleado(
idTel int constraint pk_TelEmple primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idEmpleado int not null,
constraint fk_CompanyEmple foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_EmpleadoTel foreign key (idEmpleado) references empleado (idEmpleado),
)

create table telefonoProveedor(
idTel int constraint pk_TelProveedor primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idProveedor int not null,
constraint fk_CompanyProveedor foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_ProveedorTel foreign key (idProveedor) references proveedor (idProveedor)
)

create table categoria(
idCategoria int identity(1,1),
categoria nvarchar(150) not null,
descripcionCat nvarchar(350)
)

create table producto(
idProducto int identity(1,1) constraint pk_Producto primary key,
codigoProducto char(12) unique not null,
nombreP nvarchar(80) not null,
descripcion nvarchar(500) not null,
stock int not null, --Crear un trigger el cual me calcule el total de ese producto que hay en existencia sin que el usuario pueda manejar el  inventario-->New table  name Inventario.
idProveedor int constraint fk_productoProveedor foreign key references proveedor(idProveedor) not null,
idCategoria int,
constraint pk_productoCategoria foreign key(idCategoria) references categoria(idCategoria)
)

-- Tabla compra
create table compra(
    idCompra int identity(1,1) constraint pk_compra primary key,
    fechaCompra datetime not null,
    totalCompra decimal(18,2) not null,
	idCliente int not null,
	constraint fk_compraCliente foreign key(idCliente) references cliente(idCliente)
);

-- Tabla detalleCompra (para detalles de los productos comprados en una compra)
create table detalleCompra(
    idDetalleCompra int identity(1,1) primary key,
    idCompra int,
    idProducto int,
    cantidad int not null,
    precioUnitario decimal(18,2) not null,
    constraint fk_detalleCompra_Compra foreign key(idCompra) references compra(idCompra),
    constraint fk_detalleCompraProducto foreign key(idProducto) references producto(idProducto)
);

-- Tabla recibo (para registrar los recibos de las compras)
create table recibo(
    idRecibo int identity(1,1) primary key,
    idCompra int,
    fechaRecibo datetime not null,
    total decimal(18,2) not null,
    constraint fk_reciboCompra foreign key(idCompra) references compra(idCompra)
);

/*
¿Imprimir el recibo?
Crear un Join que enlace la tabla producto, compra, 
detalleCompra y el recibo para que de la información mas
relevante para el cliente.
*/


--Continuar con la logica de la Bodega acá.
 create table bodega(
 idBodega int constraint pk_Bodega primary key,
 nombreBodega nvarchar(100) not null,
 descripcion nvarchar(50) not null,
 codigoB char(12) unique not null,
 idEmpresa int not null,
 constraint fk_bodegaEmpresa foreign key(idEmpresa) references empresa(idEmpresa) 
 );

/*Crear otras tablas que maneje los siguientes puntos
-------------------------------
-->Condiciones de la Compra:<--
-------------------------------

->Política de devolución: [Indicar condiciones, si aplica]
->Garantía: [Información de la garantía del producto, si aplica]
->Entrega: [Método y plazo de entrega, si aplica]
*/



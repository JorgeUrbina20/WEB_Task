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
nombreDep nvarchar(50)not null,
EstadoDep char(12) default 'Activo' not null
);

--Realizar las inserciones solo de los departamentos.
create table municipio
(
idMun int constraint pk_Mun primary key,
nombreMun nvarchar(50) not null,
idDep int constraint fk_Dep foreign key references departamento(idDep) not null,
EstadoMun char(12) default 'Activo' not null
);

go

create table barrio
(
idBarrio int constraint pk_Barrio primary key,
nombreBarrio nvarchar(50)not null,
idMun int constraint fk_Mun foreign key references municipio(idMUn) not null,
EstadoBarrio char(12) default 'Activo' not null
);

create table cliente
(
idCliente int constraint pk_Cliente primary key,
Pnombre nvarchar(100) not null,
Snombre nvarchar(80),
Papellido nvarchar(100) not null,
Sapellido nvarchar (80),
cedula char(16) check (cedula like '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][A-Z]'),
EstadoCliente char(12) default 'Activo' not null
);

create table empresa(
idEmpresa int constraint pk_Empresa primary key,
nombreEmpr nvarchar(100) not null,
ruc char(15) not null,
EstadoEmpresa char(12) default 'Activo' not null
);

create table empleado(
idEmpleado int constraint pk_Empleado primary key,
codigoEmpleado int unique not null,
PNE nvarchar(100) not null,
SNE nvarchar(100),
PAE nvarchar(100) not null,
SAE nvarchar(100),
idEmpresa int not null,
constraint fk_idEmpresa foreign key (idEmpresa) references empresa(idEmpresa),
EstadoEmpleado char(12) default 'Activo' not null
)

-->Se supone que cada empleado tiene asignado un rol.
create table EmpleadoRole(
idER int constraint pk_EmpleadoRole primary key,
nombreRole nvarchar(80) not null,
descripRole nvarchar(500),
idEmpleadoRole int constraint fk_empleadoRole foreign key references empleado(idEmpleado),
EstadoEmpleadoRole char(12) default 'Activo' not null
)

create table proveedor(
idProveedor int constraint pk_idProveedor primary key,
nombrePro nvarchar(100) not null,
ruc char(15),
idEmpresa int constraint fk_empresaProveedor foreign key references empresa(idEmpresa) not null,
EstadoProveedor char(12) default 'Activo' not null
);

create table emailEmpresa(
idEmail int constraint pk_Email primary key,
Email nvarchar(100),
idEmpresa int constraint fk_empresaEmail foreign key references empresa(idEmpresa),
EstadoEmailEmpresa char(12) default 'Activo' not null
)

create table emailEmpleado(
idEmail int constraint pk_EmailEmple primary key,
Email nvarchar(100),
idEmpleado int constraint fk_empleadoEmail foreign key references empleado(idEmpleado),
EstadoEmailEmpleado char(12) default 'Activo' not null
)

create table emailProveedor(
idEmail int constraint pk_EmailProveedor primary key,
Email nvarchar(100),
idProveedor int constraint fk_proveedorEmail foreign key references proveedor(idProveedor),
EstadoEmailProveedor char(12) default 'Activo' not null
)

create table direccionCliente
(
idDir int constraint pk_Dir primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_Barrio foreign key references barrio(idBarrio) not null,
idCliente int constraint fk_ClienteDir foreign key references cliente(idCliente) not null,
EstadoDireccionCliente char(12) default 'Activo' not null
);

create table direccionEmpresa
(
idDir int constraint pk_DirEmpre primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_BarrioEmpre foreign key references barrio(idBarrio) not null,
idEmpresa int constraint fk_EmpresaDir foreign key references empresa(idEmpresa) not null,
EstadoDireccionEmpresa char(12) default 'Activo' not null
);

create table direccionEmpleado
(
idDir int constraint pk_DirEmple primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_BarrioEmple foreign key references barrio(idBarrio) not null,
idEmpleado int constraint fk_empleadoDireccion foreign key references empleado(idEmpleado) not null,
EstadoDireccionEmpleado char(12) default 'Activo' not null
);

create table direccionProveedor
(
idDir int constraint pk_DirProveedor primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_BarrioProveedor foreign key references barrio(idBarrio) not null,
idProveedor int,
constraint fk_proveedor foreign key(idProveedor) references proveedor(idProveedor) ,
EstadoDireccionProveedor char(12) default 'Activo' not null
);

create table companiaTelefonica(
idCom int constraint pk_Com primary key,
nombre nvarchar(100) not null,
EstadoCT char(12) default 'Activo' not null
)

create table telefonoCliente(
idTel int constraint pk_Tel primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idCliente int not null,
constraint fk_Company foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_ClienteTel foreign key (idCliente) references cliente (idCliente),
EstadoTelCliente char(12) default 'Activo' not null
)

create table telefonoEmpresa(
idTel int constraint pk_TelEmpre primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idEmpresa int not null,
constraint fk_CompanyTel foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_EmpresaTel foreign key (idEmpresa) references empresa(idEmpresa),
EstadoTelEmpresa char(12) default 'Activo' not null
)

create table telefonoEmpleado(
idTel int constraint pk_TelEmple primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idEmpleado int not null,
constraint fk_CompanyEmple foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_EmpleadoTel foreign key (idEmpleado) references empleado (idEmpleado),
EstadoTelEmpleado char(12) default 'Activo' not null
)

create table telefonoProveedor(
idTel int constraint pk_TelProveedor primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idProveedor int not null,
constraint fk_CompanyProveedor foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_ProveedorTel foreign key (idProveedor) references proveedor (idProveedor),
EstadoTelProveedor char(12) default 'Activo' not null
)

create table categoria(
idCategoria int identity(1,1),
categoria nvarchar(150) not null,
descripcionCat nvarchar(350),
EstadoCat char(12) not null default 'Activo',
constraint pk_Categoria primary key(idCategoria)
)

create table producto(
idProducto int identity(1,1) constraint pk_Producto primary key,
codigoProducto char(12) unique not null,
nombreP nvarchar(80) not null,
descripcion nvarchar(500) not null,
stock int not null, --Crear un trigger el cual me calcule el total de ese producto que hay en existencia sin que el usuario pueda manejar el  inventario-->New table  name Inventario.
idProveedor int constraint fk_productoProveedor foreign key references proveedor(idProveedor) not null,
idCategoria int,
constraint pk_productoCategoria foreign key(idCategoria) references categoria(idCategoria),
EstadoProducto char(12) not null default 'Activo'
)

-- Tabla compra
create table compra(
    idCompra int identity(1,1) constraint pk_compra primary key,
    fechaCompra datetime not null,
    totalCompra decimal(18,2) not null,
	idCliente int not null,
	constraint fk_compraCliente foreign key(idCliente) references cliente(idCliente),
	EstadoCompra char(20) not null default 'Completada'
	/*
	->Posibles estado de una compra<-

	Pendiente: La compra ha sido iniciada, pero aún no ha sido procesada.
	Procesando: La compra está siendo procesada o verificada.
	Completada: La compra ha sido finalizada correctamente.
	Cancelada: La compra ha sido cancelada por el usuario o por algún error.
	Enviado: Si es una compra que involucra envío de productos.
	Entregado: Si la compra ya ha sido entregada al cliente.
	*/
);

-- Tabla detalleCompra (para detalles de los productos comprados en una compra)
create table detalleCompra(
    idDetalleCompra int identity(1,1) primary key,
    idCompra int,
    idProducto int,
    cantidad int not null,
    precioUnitario decimal(18,2) not null,
    constraint fk_detalleCompra_Compra foreign key(idCompra) references compra(idCompra),
    constraint fk_detalleCompraProducto foreign key(idProducto) references producto(idProducto),
	EstadoDC char(20) not null default 'Entregado'
	/*
	->Posibles estado para el detalle de la compra<-

	Pendiente: El artículo aún no ha sido procesado o no se ha confirmado.
	Confirmado: El artículo ha sido confirmado y procesado, listo para ser enviado o entregado.
	Enviado: El artículo ya ha sido enviado al cliente, si corresponde.
	Entregado: El artículo ha sido entregado al cliente.
	Cancelado: El artículo ha sido cancelado (por ejemplo, si hubo un error o el cliente lo cambió de opinión).
	Devuelto: El artículo ha sido devuelto por el cliente.
	Pendiente de stock: El artículo está fuera de inventario, esperando reposición.
	Reembolsado: El artículo ha sido reembolsado, generalmente si el cliente ha devuelto el producto o hay una disputa.
	*/
);

-- Tabla recibo (para registrar los recibos de las compras)
create table recibo(
    idRecibo int identity(1,1) primary key,
    idCompra int,
    fechaRecibo datetime not null,
    total decimal(18,2) not null,
    constraint fk_reciboCompra foreign key(idCompra) references compra(idCompra),
	EstadoRecibo char(20) not null default 'Completada'
	/*
	->Posibles estados para el recibo<-

	Pendiente: La compra ha sido iniciada pero aún no se ha procesado ni confirmado.
	Procesando: La compra está siendo procesada; por ejemplo, se está verificando el pago, el stock, etc.
	Completada: La compra ha sido completada con éxito (se ha recibido el pago y se han enviado los productos).
	Cancelada: La compra ha sido cancelada, ya sea por el cliente o por algún error en el proceso.
	Reembolsada: La compra ha sido reembolsada total o parcialmente.
	Pago pendiente: Se ha registrado la compra, pero el pago aún no se ha confirmado.
	Pago rechazado: El pago ha sido rechazado (tarjeta inválida, fondos insuficientes, etc.).
	En proceso de devolución: El recibo está en proceso de devolución, es decir, el cliente ha solicitado devolver los productos o la compra completa.
	Fallida: La compra falló, por ejemplo, debido a problemas con la tarjeta de crédito, fraude detectado, etc.
	*/
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
 constraint fk_bodegaEmpresa foreign key(idEmpresa) references empresa(idEmpresa),
 EstadoBodega char(20) default 'Almacenado' not null
 /*
 ->Posibles estados para la bodega<-
	Pendiente: El producto está en espera de ser recibido en la bodega (por ejemplo, aún no ha llegado a la bodega).
	Recibido: El producto ha llegado a la bodega, pero no ha sido almacenado o registrado completamente.
	Almacenado: El producto ha sido recibido y registrado correctamente en el inventario de la bodega, ya está disponible para su venta o distribución.
	En espera de calidad: El producto ha sido recibido, pero está siendo revisado para asegurar que cumple con los estándares de calidad.
	Devolución pendiente: El producto ha sido recibido, pero está siendo devuelto por alguna razón, ya sea por defectos o por otro error.
	Asignado a venta: El producto ha sido tomado del inventario para ser vendido o enviado a un cliente.
	Enviado: El producto ha sido enviado al cliente, se ha actualizado el inventario para reflejar que ya no está disponible.
	Descartado: El producto ha sido eliminado del inventario por alguna razón, como daño o caducidad.
	En tránsito: El producto está en proceso de ser trasladado dentro de la bodega o entre bodegas.
 */
 );

/*Crear otras tablas que maneje los siguientes puntos
-------------------------------
-->Condiciones de la Compra:<--
-------------------------------

->Política de devolución: [Indicar condiciones, si aplica]
->Garantía: [Información de la garantía del producto, si aplica]
->Entrega: [Método y plazo de entrega, si aplica]
*/



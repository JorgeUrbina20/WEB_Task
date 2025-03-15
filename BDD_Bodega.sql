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

create table municipio
(
idMun int constraint pk_Mun primary key,
nombreMun nvarchar(50) not null,
idDep int constraint fk_Dep foreign key references departamento(idDep) not null
);

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

create table proveedor(
idProveedor int constraint pk_idProveedor primary key,
nombrePro nvarchar(100) not null,
ruc char(15)
);

create table direccionCliente
(
idDir int constraint pk_Dir primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_Barrio foreign key references barrio(idBarrio) not null,
idCliente int constraint fk_ClienteDir foreign key references cliente(idCliente) not null,
idProveedor int,
constraint fk_proveedor foreign key(idProveedor) references proveedor(idProveedor) 
);

create table direccionCliente
(
idDir int constraint pk_Dir primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_Barrio foreign key references barrio(idBarrio) not null,
idEmpresa int constraint fk_EmpresaDir foreign key references empresa(idEmpresa) not null
);


create table companiaTelefonica(
idCom int constraint pk_Com primary key,
nombre nvarchar(100) not null
)

create table telefono(
idTel int constraint pk_Tel primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idCliente int not null,
constraint fk_Company foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_ClienteTel foreign key (idCliente) references cliente (idCliente),
)





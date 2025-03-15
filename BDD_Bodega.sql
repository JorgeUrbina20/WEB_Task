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

create table proveedor(
idProveedor int constraint pk_idProveedor primary key,
nombrePro nvarchar(100) not null,
ruc char(15)
);

create table emailEmpresa(
idEmail int constraint pk_Email primary key,
Email nvarchar(100),
idEmpresa int constraint fk_empresaEmail foreign key references empresa(idEmpresa)
)

create table emailEmpleado(
idEmail int constraint pk_Email primary key,
Email nvarchar(100),
idEmpleado int constraint fk_empleadoEmail foreign key references empleado(idEmpleado)
)

create table emailProveedor(
idEmail int constraint pk_Email primary key,
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
idDir int constraint pk_Dir primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_Barrio foreign key references barrio(idBarrio) not null,
idEmpresa int constraint fk_EmpresaDir foreign key references empresa(idEmpresa) not null
);

create table direccionEmpleado
(
idDir int constraint pk_Dir primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_Barrio foreign key references barrio(idBarrio) not null,
idEmpleado int constraint fk_empleadoDireccion foreign key references empleado(idEmpleado) not null
);

create table direccionProveedor
(
idDir int constraint pk_Dir primary key,
Direccion nvarchar(50) not null,
idBarrio int constraint fk_Barrio foreign key references barrio(idBarrio) not null,
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
idTel int constraint pk_Tel primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idEmpresa int not null,
constraint fk_Company foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_EmpresaTel foreign key (idEmpresa) references empresa(idEmpresa),
)

create table telefonoEmpleado(
idTel int constraint pk_Tel primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idEmpleado int not null,
constraint fk_Company foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_EmpleadoTel foreign key (idEmpleado) references empleado (idEmpleado),
)

create table telefonoProveedor(
idTel int constraint pk_Tel primary key,
Ntel char(8) check (Ntel like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') not null,
idCompany int not null,
idProveedor int not null,
constraint fk_Company foreign key (idCompany) references companiaTelefonica (idCom),
constraint fk_ClienteTel foreign key (idProveedor) references proveedor (idProveedor)
)


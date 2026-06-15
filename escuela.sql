CREATE DATABASE IF NOT EXISTS escuela;
USE escuela;

-- ==========================
-- TABLA ESTADOS
-- ==========================
CREATE TABLE Estados (
    idEstado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL
);

-- ==========================
-- TABLA MUNICIPIOS
-- ==========================
CREATE TABLE Municipios (
    idMunicipio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    idEstado INT NOT NULL,
    CONSTRAINT fk_municipio_estado
        FOREIGN KEY (idEstado)
        REFERENCES Estados(idEstado)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ==========================
-- TABLA LOCALIDADES
-- ==========================
CREATE TABLE Localidades (
    idLocalidad INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    idMunicipio INT NOT NULL,
    CONSTRAINT fk_localidad_municipio
        FOREIGN KEY (idMunicipio)
        REFERENCES Municipios(idMunicipio)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- ==========================
-- TABLA GENEROS
-- ==========================
CREATE TABLE Generos (
    idGenero INT AUTO_INCREMENT PRIMARY KEY,
    Genero VARCHAR(100) NOT NULL
);

-- ==========================
-- TABLA DATOS PERSONALES
-- ==========================
CREATE TABLE DatosPersonales (
    idDatosP INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    FechaNacimiento DATE,
    Curp VARCHAR(20) UNIQUE,
    Email VARCHAR(100),
    Telefono VARCHAR(10),
    Calle VARCHAR(80),
    NumE INT,
    NumI INT,
    CP INT,
    idLocalidad INT,
    idMunicipio INT,
    idEstado INT,
    idGenero INT,

    CONSTRAINT fk_dp_localidad
        FOREIGN KEY (idLocalidad)
        REFERENCES Localidades(idLocalidad),

    CONSTRAINT fk_dp_municipio
        FOREIGN KEY (idMunicipio)
        REFERENCES Municipios(idMunicipio),

    CONSTRAINT fk_dp_estado
        FOREIGN KEY (idEstado)
        REFERENCES Estados(idEstado),

    CONSTRAINT fk_dp_genero
        FOREIGN KEY (idGenero)
        REFERENCES Generos(idGenero)
);

-- ==========================
-- TABLA TIPO PERSONAL
-- ==========================
CREATE TABLE TipoPersonal (
    idTipo INT AUTO_INCREMENT PRIMARY KEY,
    Personal VARCHAR(100) NOT NULL
);

-- ==========================
-- TABLA PERSONAL
-- ==========================
CREATE TABLE Personal (
    idPersonal INT AUTO_INCREMENT PRIMARY KEY,
    idDatosP INT NOT NULL,
    idTipo INT NOT NULL,
    ClaveEmp VARCHAR(10) NOT NULL,
    Status BOOLEAN DEFAULT TRUE,

    CONSTRAINT fk_personal_datos
        FOREIGN KEY (idDatosP)
        REFERENCES DatosPersonales(idDatosP),

    CONSTRAINT fk_personal_tipo
        FOREIGN KEY (idTipo)
        REFERENCES TipoPersonal(idTipo)
);

-- ==========================
-- TABLA CARRERAS
-- ==========================
CREATE TABLE Carreras (
    idCarrera INT AUTO_INCREMENT PRIMARY KEY,
    NombreCarreras VARCHAR(50) NOT NULL,
    Estatus BOOLEAN DEFAULT TRUE
);

-- ==========================
-- TABLA ALUMNOS
-- ==========================
CREATE TABLE Alumnos (
    Matricula VARCHAR(20) PRIMARY KEY,
    idCarrera INT NOT NULL,
    idDatosP INT NOT NULL,
    Status CHAR(1) DEFAULT 'A',

    CONSTRAINT fk_alumno_carrera
        FOREIGN KEY (idCarrera)
        REFERENCES Carreras(idCarrera),

    CONSTRAINT fk_alumno_datos
        FOREIGN KEY (idDatosP)
        REFERENCES DatosPersonales(idDatosP)
);

-- ==========================
-- TABLA ASIGNATURAS
-- ==========================
CREATE TABLE Asignaturas (
    idAsignatura INT AUTO_INCREMENT PRIMARY KEY,
    NombresMaterias VARCHAR(100) NOT NULL,
    HorasTotales INT NOT NULL
);

-- ==========================
-- TABLA INTENDENCIA
-- ==========================
CREATE TABLE Intendencia (
    idEmpleado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Telefono VARCHAR(10),
    Area VARCHAR(20),
    Turno VARCHAR(20)
);

-- ==========================
-- TABLA DATOS ESCUELA
-- ==========================
CREATE TABLE DatosEscuela (
    CCT VARCHAR(10) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Telefono VARCHAR(10),
    Email VARCHAR(100),
    Calle VARCHAR(80),
    NumE INT,
    NumI INT,
    idLocalidad INT,
    idMunicipio INT,
    idEstado INT,
    CP INT,

    CONSTRAINT fk_escuela_localidad
        FOREIGN KEY (idLocalidad)
        REFERENCES Localidades(idLocalidad),

    CONSTRAINT fk_escuela_municipio
        FOREIGN KEY (idMunicipio)
        REFERENCES Municipios(idMunicipio),

    CONSTRAINT fk_escuela_estado
        FOREIGN KEY (idEstado)
        REFERENCES Estados(idEstado)
);
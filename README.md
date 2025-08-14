# Proyecto de Automatización QA Severest

Pruebas automatizadas de la API **Serverest** utilizando **Karate DSL**, **JUnit 5** y **Maven**.

---

## Tabla de Contenidos

1. [Descripción del Proyecto](#descripción-del-proyecto)  
2. [Requisitos](#requisitos)  
3. [Instalación](#instalación)  
4. [Estructura del Proyecto](#estructura-del-proyecto)  
5. [Configuración](#configuración)  
6. [Ejecucion de Pruebas](#ejecucion-de-pruebas)  
7. [Datos de Prueba y Utilidades](#datos-de-prueba-y-utilidades)  
8. [Reportes](#reportes)  
9. [Buenas Prácticas](#buenas-prácticas)  
10. [Contribución](#contribución)  

---

## Descripción del Proyecto

Este proyecto contiene pruebas automatizadas para la API **Serverest**.  
Se implementa con **Karate DSL**, siguiendo principios **BDD** a través de archivos `.feature`.  

Características principales:  
- Pruebas de CRUD para usuarios y carritos.  
- Validación de esquemas JSON.  
- Clases de utilidad para generación de datos de prueba.  
- Configuración de entornos `dev` y `e2e`.  
- Selección aleatoria de usuarios y datos para robustez en las pruebas.

---

## Requisitos

- Java 17 o superior  
- Maven 3.8+  
- IDE (IntelliJ, VS Code, Eclipse)  

---

## Instalación

#### 1. Clonar el repositorio:

``` bash
git clone https://github.com/tuusuario/severest-automation.git
cd severest-automation
``` 
#### 2.Instalar dependencias:

``` bash
mvn clean install
```

## Estructura del Proyecto

    severest-automation/
    │
    ├── pom.xml
    ├── README.md
    ├── src/
    │   └── test/
    │       ├── java/
    │       │   └── com/
    │       │       └── severestApp/
    │       │           ├── runners/
    │       │           └── utils/
    │       └── resources/
    │           ├── data/
    │           ├── features/
    │           │   ├── carts/
    │           │   ├── login/
    │           │   ├── products/
    │           │   └── users/
    │           ├── schemas/
    │           ├── karate-config.js
    │           └── logback-test.xml
    └── target/

## Configuración
El archivo karate-config.js maneja las variables según el entorno:


    function fn() {
        var env = karate.env; // get system property 'karate.env'
        karate.log('karate.env system property was:', env);
    if (!env) {
        env = 'dev';
    }
    var config = {
        env: env,
        ApiUrl: 'https://serverest.dev/'
    }
    if (env == 'dev') {
        config.isAdministrator = "true";
        config.existingEmail = "fulanoteste@qa.co"
    } else if (env == 'e2e') {
        config.isAdministrator = "true";
        config.existingEmail = "fulanoteste@qa.co";
    }
    return config;
    }
Actualmente, las variables principales configuradas son:

- ApiUrl: URL base de la API.

- isAdministrator: indicador de usuario administrador (true/false).

- existingEmail: correo de prueba existente (solo en dev).

#### Para cambiar de entorno:

```bash
mvn test -Dkarate.env=e2e
```

## Ejecucion de pruebas

#### Ejecutar todas las pruebas:
```bash
mvn test
```
#### Ejecutar un feature específico:
```bash
mvn test -Dkarate.options="classpath:features/users/listUser.feature"
```
#### Ejecutar pruebas con etiquetas:
```bash
mvn test -Dkarate.options="--tags @smoke"
```
## Datos de Prueba y Utilidades

- DataGenerate.java: genera nombres, correos, contraseñas e IDs aleatorias.

* UserSelector.java: selecciona usuarios al azar con o sin carrito.

- Schemas JSON: ubicados en ```src/test/resources/schemas``` para validar respuestas de la API.

## Reportes
Karate genera reportes HTML por defecto en ```target/karate-reports```.
Abrir target/karate-reports/karate-summary.html para ver resultados de todos los features ejecutados.

## Buenas Prácticas
Organizar los feature files por módulo (users, products, carts, login).

Reutilizar métodos de utilidades para generar datos de prueba.

Validar respuestas de la API contra los esquemas JSON.

Usar nombres de escenarios y tags claros y descriptivos.

Mantener actualizado karate-config.js con variables de entorno.

## Contribución
Este proyecto sigue la metodología Git Flow. Para contribuir:

Hacer fork del repositorio público a tu cuenta.

Clonar tu fork localmente:

git clone https://github.com/tuusuario/severest-automation.git
cd severest-automation

Asegúrate de estar en la rama develop:

```
git checkout develop
```

Crear una rama de feature desde develop:

```
git checkout -b feature/nueva-feature
```

Realiza tus cambios y haz commit:
```
git add .
git commit -m "Agrega nueva feature"
```
Enviar tu rama al fork remoto:
```
git push origin feature/nueva-feature
```
Abrir un pull request desde tu fork hacia la rama develop del repositorio original.

Nota: Las ramas release y hotfix se manejan siguiendo el flujo de Git Flow y solo se crean cuando se prepara una versión para producción o se corrigen errores críticos.
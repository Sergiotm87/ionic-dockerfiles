## What?

Imagen base para construir aplicacion ionic en multiples plataformas (web, android, ios)

## TL;DR

```shell
docker-compose up -d
```
http://localhost

## Dudas a realizarse antes de usar la imagen

* Version de ionic? 3/4/5?

    Se ha probado para version 4, habra que ajustar el resto de componentes (jdk, node)

* El proyecto a construir usa cordova o capacitor(nuevos proyectos)??

    La imagen base esta preparada para cordoba.

    Investigar si podemos construir para capacitor con el sdk de android tal cual está o requiere un android studio completo.

* Requiere construir para IOS?

    Solo se ha tenido en cuenta android, investigar en caso de ser necesario.

* Uso de entrypoint para construir:

    Se observa que no hay una sola instrucción para construir los proyectos y poder hacer un entrypoint genérico. La forma de usar el contenedor base es mediante 'docker run' imagen docker con las instrucciones específicas del proyecto (Dockerfile.app) ó en pipelines de jenkins, gitlabci, etc.

## Pasos con aplicación de ejemplo

- Construir imagen base:

    ```shell
    docker-compose build ionic
    ```

- Generar nuevo proyecto / obtener repositorio:

    ```shell
    docker run --rm -ti -v $PWD/src:/app emergya/ionic-builder:latest ionic start helloworld blank --type=angular --cordova --no-link --no-git --no-interactive --confirm
    ```

- Construir aplicacion web y android:

    - Ajustar contexto del codebase y dockerfile

    ```shell
    docker-compose build ionic
    ```
    - El apk está alojada en el directorio /artifacts

- Levantar aplicacion web:

    ```shell
    docker-compose up -d ionic
    ```
    - Acceder a http://localhost

## TODO

* Probar la imagen con aplicaciones más complejas

* Subir imagen base (ionic-builder) a registry

* Generar ejemplos de pipelines CI/CD

* Documentar la firma y gestión de apk con jarsigner

* Usar imagen docker con emulador android para levantar apk y realizarle pruebas de frontend. Ej: https://github.com/budtmo/docker-android

* Generar nuevas imágenes para los diferentes escenarios que vayan surgiendo y actualizar la documentación.

## Referencias

https://github.com/CircleCI-Public/circleci-dockerfiles/blob/master/android/images/api-29-ndk/Dockerfile

https://ionicframework.com/resources/articles/capacitor-vs-cordova-modern-hybrid-app-development


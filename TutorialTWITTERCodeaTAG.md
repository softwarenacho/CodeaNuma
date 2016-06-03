##¿Sabes lo que es un API (Application Programming Interface)?

Un **API** es una "librería" creada para poder comunicarse con un software en particular, de manera sencilla. Normalmente esta librería contiene funciones, especificaciones y procedimientos que te permiten comunicarte con ese software para recibir servicios del mismo. 

Un ejemplo muy sencillo es lo que lograremos con este reto combinando la aplicación de propuestas que realizamos en el [tutorial anterior](http://www.codea.mx/posts/26), la integración de la API de **[Twitter](https://dev.twitter.com/overview/api)** y la aplicación de propuestas para Tag CDMX desarrollada por Codea: **[CodeaTag](http://codeatag.herokuapp.com/)**.

Esta aplicación podrá buscar a través de "twitter" información pública de sus usuarios para utilizarlos como propuestas. Para ello nos comunicaremos con **Twitter** utilizando su API y después mandaremos las propuestas creadas a **CodeaTag** para que Tag CDMX las tome en cuenta para el evento del siguiente año.

## Objetivos Académicos 

- Familiarizarse con el concepto de API
- Utilizar la API de Twitter
- Comunicar nuestra aplicación con servicios externos

## Requisitos

- Haber terminado el [tutorial anterior](http://www.codea.mx/posts/26)
- Tener una cuenta de Twitter con un número movil registrado

Sino tienes cuenta de Twitter o no tienes registrado tu número en la misma puedes seguir estos links:

[Crear cuenta de Twitter](https://twitter.com/signup)
[Registrar número movil en tu cuenta de Twitter](https://twitter.com/settings/devices)

Esto es un requisito de la sección de desarrolladores de Twitter para poder crear tu aplicación.

## Actividades 

### Creación de un Twitter Client para Twitter

En el tutorial anterior agregamos por ti la gema de Twitter al `Gemfile` de tu aplicación y esta fue instalada junto a las demás gemas de la misma, ahora debemos configurarla para poder comunicarnos con ella.

El primer paso para desarrollar esta aplicación será obtener los códigos de autorización que nos da Twitter para acceder a sus servicios. Entra a la siguiente ruta para hacerlo:

- [https://dev.twitter.com/apps/new](https://dev.twitter.com/apps/new). 

En esta página deberás asignarle un nombre a tu aplicación, nosotros te recomendamos usar el formato `codeatag_` seguido de tu nombre o identificador favorito, en 'description' puedes explicar brevemente lo que hará tu aplicación o usar nuestra descripción por default: 'This app receives proposals for TagCDMX using the Twitter API and sends them to CodeaTag.', en 'website' copia el link con el que abres tu aplicación (el que te señaló la consola de Cloud9 cuando levantaste tu servidor que debe ser algo parecido a: `https://codeatag-username.c9users.io/`), en 'Callback URL' debes poner esta misma dirección. 

Para terminar este pasodeberás aceptar los terminos y condiciones de Twitter seleccionando el 'checkbox' y ahora puedes darle click a `Create your Twitter application`.

Una vez que tu aplicación sea creada de manera correcta, la página te llevará a un panel de configuración. Dentro de este panel accede a la pestaña de `Keys and Access Tokens` donde encontrarás tu `Consumer Key (API Key)` y tu `Consumer Secret (API Secret)`.

Ahora debemos generar los `Access Token` para lo cual deberás ir a la parte inferior de tu página de keys y dar click en el botón que dice `Create my access token`, esto puede tardar unos momentos y deberá darte un mensaje en la misma página, si vuelves a bajar en la misma encontrarás una sección titulada 'Your Access Token' en donde están ahora el `Access Token` y el `Access Token Secret`.

No cierres esta página pues la usaremos más adelante, en este punto deberás tener generados y ubicados los siguientes datos:

- Consumer Key
- Consumer Secret
- Access Token
- Access Token Secret

Ahora sí tienes todo lo necesario para crear un "Twitter Client".

### Configurar la API de Twitter

La información que generamos en el paso anterior es privada y te pertenece, para protegerla utilizaremos un archivo de Rails en dónde guardaremos tus `tokens` y nadie podrá acceder a ellos más que tú
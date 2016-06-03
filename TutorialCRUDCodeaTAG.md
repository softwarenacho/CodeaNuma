# Tutorial Cloud9

### Crear cuenta
Entra a la página de **[Cloud9](https://c9.io)** y crea una cuenta, seguramente tendrás que activarla en tu mail con el que te registraste.

### Crear un nuevo workspace
1. Da click en 'Create a new workspace'
2. Asígnale un nombre a tu workspace
3. En la opción **Hosted Workspace** seleccionar **'Public'**
4. En **Choose a template** seleccionamos BLANK.
5. Selecciona **Create workspace** para pasar al siguiente paso.

## Objetivos Académicos

- Comprender que es una aplicación web
- Entender la Arquitectura MVC
- Aprender a crear un CRUD
- Crear tu primera aplicación web

## Introducción

Vamos a crear una aplicación que te permitirá proponer invitados a Tag CDMX para los siguientes eventos.

Para ello crearemos un modelo Propuesta que estará compuesto de 2 atributos:

- name `string` (contendrá el nombre del invitado propuesto)
- avatar `string` (un link a la imagen del invitado)

## Te recomendamos tener nociones de:

- Tipos de datos
- Variables
- Ciclos
- Métodos
- HTML y CSS

## Actividades

Las siguientes instrucciones serán ejecutadas todas en Cloud9, si necesitas ayuda entendiendo el funcionamiento del sistema pregunta a uno de los asesores.

### Crear una aplicación de Rails

1) Crear una nueva aplicación de rails

Instalar la gema de rails poniendo el siguiente comando en el bash de Cloud9.

**El signo de pesos '$' representa la línea de comandos y no debes copiarlo, después de cada comando debes dar Enter**


``` bash
$ gem install rails --no-ri --no-rdoc
```

**Crear nuestra aplicación**

Primero tenemos que asegurarnos que estamos en el folder que Cloud9 nos da que se llama `$ cd /path/to/workspace` . Estando dentro de ese folder creamos nuestra app.

``` bash
$ rails new codeatag_app --skip-test-unit
```

Como siguiente paso debemos movernos al directorio donde creamos la aplicación con el siguiente comando: 

```bash
$ cd codeatag_app
```

La estructura de archivos de tu aplicación la puedes encontrar en el lado izquierdo de la interfaz de Cloud9, dentro de la carpeta 'codeatag_app' están todos los archivos que consituyen tu aplicación.

El primer cambio que realizaremos será señalar en el archivo 'Gemfile' las gemas que utilizaremos en nuestra aplicación, este archivo lo puedes encontrar en la carpeta raiz, para ello sustituiremos todo el contenido del mismo por el siguiente:

``` ruby
source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
# Use sqlite as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

gem 'twitter'

gem 'simple_form'
# Correr este comando para que sirva simple form con boostrap
# rails generate simple_form:install --bootstrap
```

**Recuerda grabar tus archivos después de cada modificación.**

Una vez que hemos hecho estos cambios es necesario instalar estas gemas, esto lo realizas utilizando el siguiente comando:

```bash
$ bundle update
```

2) Ahora vamos a correr el servidor para verificar que todo esté funcionando correctamente.

Te recomendamos abrir una nueva ventana de terminal y ejecutar tu servidor en ella, esto lo hacer dando click al simbolo de más que está junto a las pestañas de tu terminal y seleccionando en el menú que se abre 'new terminal'.

Dentro de esta deberás volver a colocarte en la carpeta de tu proyecto con el comando:

```bash
$ cd codeatag_app
```

Ahora levantaremos una aplicación de Rails con el siguiente comando en Cloud9:

``` bash
$ rails s -p $PORT -b $IP
```

En este punto Cloud9 nos da acceso a una url como la siguiente http://codeatag-username.c9users.io, en donde verás la página default de bienvenida de rails.

El link a tu aplicación te saldrá del lado derecho de tu bash en una alerta verde, puedes darle click y acceder a tu aplicación.

En los siguientes pasos cambiaremos esto para dar paso a tu aplicación.


### Crear el modelo y la base de datos

Rails tienen algunos comandos (generadores) que te ayudan a crear los archivos que vamos a necesitar para este paso insertando el código necesario para empezar a desarrollar.

Regresa a la pestaña de tu terminal anterior y corre el siguiente generador que creará tu modelo con sus 2 atributos, name y avatar: 

Corre el siguiente generador:
``` bash
$ rails generate model proposal name:string avatar:string
```

Para ir modificando una base de datos Rails tiene un concepto llamado migraciones, con el que administra éstos cambios para facilitar el desarrollo. Cada migración contiene un cambio.

El comando `rails generate model ...` creó un archivo de migración, el cual contiene el código que especifica el cambio. Para aplicar este cambio a la base de datos usamos el comando:

``` bash
$ rake db:migrate
```

### Crear las rutas

Dentro del archivo `codeatag_app/config/routes.rb` deberás agregar la siguiente línea de código:

``` ruby
resources :proposals
```

### Crear el controlador

Vamos a crear un controlador para el modelo Proposals con el siguiente comando:

``` bash
$ rails g controller proposals
```

Como tip `rails g` es un shortcut para `rails generate`.

Este comando nos crea el archivo `codeatag_app/app/controllers/proposals_controller.rb`. Dentro de este archivo vamos a crear la funcionalidad necesaria para las acciones del CRUD de *proposal*.


### CRUD de `proposal`

CRUD son las siglas de **Create, Read, Update** y **Destroy** y para nuestras aplicaciones está formado de 7 acciones:

<table  class="table table-responsive table-bordered table-condensed">
	<tr>
		<th>Acción</th>
		<th>CRUD</th>
		<th>Vista</th>
		<th>Método HTTP</th>
		<th>Concepto</th>
	</tr>
	<tr>
		<td>New</td>
		<td rowspan="2">CREATE</td>
		<td>new.html.erb</td>
		<td>Petición POST desde un formulario</td>
		<td>Muestra el formulario para un nuevo objeto</td>
	</tr>
	<tr>
		<td>Create</td>
		<td></td>
		<td>Recibe una petición POST desde un formulario</td>
		<td>Procesa o guarda el nuevo objeto</td>
	</tr>	
	<tr>
		<td>Index</td>
		<td rowspan="2">READ</td>
		<td>index.html.erb</td>
		<td>Petición GET</td>
		<td>Muestra todos los objetos</td>
	</tr>
	<tr>
		<td>Show</td>
		<td>show.html.erb</td>
		<td>Petición GET con un parametro ID</td>
		<td>Muestra un objeto especifico</td>
	</tr>
	<tr>
		<td>Edit</td>
		<td rowspan="2">UPDATE</td>
		<td>edit.html.erb</td>
		<td>Petición PUT o PATCH desde un formulario</td>
		<td>Muestra el formulario para editar un objeto</td>
	</tr>
	<tr>
		<td>Update</td>
		<td></td>
		<td>Recibe una petición PUT o PATCH desde un formulario</td>
		<td>Guarda los datos editados del objeto</td>
	</tr><tr>
		<td>Destroy</td>
		<td>DELETE</td>
		<td></td>
		<td>Petición DELETE con un parametro ID</td>
		<td>Borra un objeto especificado</td>
	</tr>
</table>

Para crear una nueva `proposal` necesitamos usar dos acciones:
- `new` - Nos sirve para desplegar un formulario al usuario, donde introducirá el nombre y el link a la foto de la nueva `proposal`.
- `create` - Nos servirá para crear y guardar la nueva `proposal` en la base de datos.


**Es importante recordar que todas las acciones del controlador las añadirás al archivo: `codeatag_app/app/controllers/proposals_controller.rb`.**

#### Acción `new`

Dentro del controlador pega el siguiente código:

``` ruby
  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end
```

La acción anterior crea una `proposal` vacía y como especifica el comentario, se mostrará el archivo 'codeatag_app/app/views/proposals/new.html.erb'. Este archivo no existe todavía.

Crea el archivo 'new.html.erb' dando click derecho sobre la carpeta 'codeatag_app/app/views/proposals/' y seleccionando 'New file' y copia el siguiente código HTML en este nuevo archivo.

``` erb
<div id="first_section">
  <div class="container">
    <h1 class="text-center">Agrega tu propuesta</h1>
    <div class="row">            
      <%= form_for @proposal do |f| %>

      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :name,   placeholder: "Nombre", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :avatar, placeholder: "Avatar", class: "form-control" %>
      </div>    
      <div class="proposal-input col-md-offset-3 col-md-6">
        <%= f.submit "Crear", class: "btn btn-md btn-primary btn-block" %>
      </div>      
      <% end %>
    </div><!-- first_section -->
  </div><!-- container -->
</div>
```

Una vez que hemos hecho esto, podemos ver nuestra forma en la url de tu aplicación agregandole '/proposals/new' al final de la dirección en tu navegador. Si agregas una propuesta y le das click al botón `crear` verás un error, esto es porque no hemos creado el método `create`.

#### Acción `create`

La forma anterior se enviará a la acción de `create` de nuestro controlador. Por lo tanto necesitamos crear la acción en el controlador con el siguiente código, que contendrá la lógica para crear y guardar el `proposal` en la base de datos, pegalo debajo de tu acción `new`:

``` ruby
  def create
    @proposal = Proposal.new(proposal_params)

    @proposal.save
    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :avatar)
  end
```

En este código definimos dos métodos `create` que guarda nuestra propuesta y utiliza el otro método, `proposal_params` el cual es privado y se encarga de recibir los parámetros que envió la forma y omitir información no permitida.

**Recuerda grabar tu controlador después de añadir nuevo código, todas las acciones nuevas deberás pegarlas antes de la palabra clave `private` y después del último método definido**

El método 'create' crea una nueva `proposal` con los parámetros que le pasó la forma. Después la guarda y redirige al usuario a `proposals_path` que es la vista `index` la cual crearemos en el siguiente paso.

#### Acción `index`

En este paso necesitamos crear una acción `index` en nuestro controlador. Esta acción enlistará todas las `proposals` que existen.

Pega el siguiente código en tu controlador antes del inicio de los métodos privados y después del último método que creaste:

``` ruby
  def index
    @proposals = Proposal.all
    # render 'proposals/index.html.erb'
  end
```
La acción anterior trae de la base de datos todas las `proposals` y como especifica el comentario, se mostrará el archivo 'codeatag_app/app/views/proposals/index.html.erb'. Este archivo no existe todavía.

Crea el archivo 'index.html.erb' en la carpeta 'codeatag_app/app/views/proposals/' y copia el siguiente código que combina HTML y Ruby para enlistar los `proposals` que trajimos de la base de datos.

``` erb
<div id="first_section">
  <div class="container">
    <div class="jumbotron well">
      <h1 class="text-center">Propuestas para TagCDMX</h1>
    </div>
  </div><!-- container -->
</div>
<div  class="row col-md-10 col-md-offset-1">
  <div id="search_results" class="row">
    <% if @proposals.any? %>
      <% @proposals.each do |proposal| %>
        <div class="search_thumbnails col-sm-6 col-md-3">
          <div class="search_img proposal_box">
            <%= link_to image_tag(proposal.avatar, class:"img_box"), proposal%>   
          </div>
          <div class="search_caption">
            <h5><%= link_to proposal.name, proposal%></h5>
          </div>
          <div class="search_btn">            
            <%= link_to "E", edit_proposal_path(proposal), class: "btn btn-default btn-xs" %>
            <%= link_to "X", proposal_path(proposal), method: :delete,
            data: { confirm: "¿Seguro que quieres eliminar la propuesta?" }, class: "btn btn-default btn-xs" %>
          </div>
        </div>
      <% end %>
    <% else %>
      <p>No has agregado propuestas aún</p>
    <% end  %>
</div>
```

Con esta página agregada ya podemos crear propuestas nuevas, accediendo a la dirección 'https://project-name/proposals/new', recuerda que esto lo debes hacer en la barra de dirección agregando '/proposals/new' al final de tu URL.

Agrega por lo menos 3 propuestas más, recuerda que en avatar deberás poner el link a una imagen de la propuesta que añades y debes poner la dirección de 'proposals/new' cada vez que quieras agregar una nueva.

También configuramos la ruta default de nuestra aplicación, entramos al archivo `codeatag_app/config/routes.rb` y agregamos la siguiente linea antes del 'end'.
``` ruby
root 'proposals#index'
```

Con este cambio si entramos directamente a la url del proyecto podremos ver las propuestas que creamos en el paso anterior.

Como podrás notar en este punto el diseño deja mucho que desear, esto es porque aún no hemos agregado CSS para darle estilo a nuestro proyecto, al crear los archivos HTML ya hemos puesto las etiquetas de clase, ahora sólo nos falta ir a la siguiente ruta 'codeatag-app/app/assets/stylesheets/' en donde deberás cambiar el nombre de 'application.css' a 'application.scss' y en este archivo agregaremos el siguiente código debajo del que ya viene incluido:

``` css
/*
 *= require_tree .
 *= require_self
 */
@import "bootstrap-sprockets";
@import "bootstrap";

.inline-img {
  display: inline-block;
}

.clear {
    clear:both;
}

.pull-right {
    margin-left:5px;
}

// Jumbotron

.jumbotron {
    color: #3F3F3F;
  background-color: rgba(255, 255, 255, 0.21);
  margin-top: 75px;
  border: none;
}

// Centra la ul para poner una nav a la mitad

.navbar {
  text-align:center;
}

.navbar-nav {
    display:inline-block;
    float:none;
}

.logo {
  margin-top: -3px;
  margin-right: 10px;
  padding-top: 9px;
}

#logo_tag {
    float: left;
}

#logo_codea {
    float: right;
}

#content {
    margin-top:50px;
  height:auto;
}

#first_section {
    background:#89E2CA;
    min-height: 250px;
}

h1 {
    font-family: sans-serif;
}

.title {
    margin-top:40px;
    height:130px;
}

.input-group-addon {
    font-size:30px;
    color:#337ab7;

}

.panel-footer {
  margin-bottom: 0;
}


// Twitter Seach Results

#search_results {
    margin-top: 30px;
}

.img_box {
    max-width: 48px;
    max-height: 48px;
    position: relative;
    top: 50%;
    -webkit-transform: translateY(-50%);
    -ms-transform: translateY(-50%);
    transform: translateY(-50%);
}

.proposal_box{
    width: 48px;
    height: 48px;
    vertical-align: middle;
}

.search_thumbnails {
    border: 1px solid #ddd;
    margin-top: 10px;
    padding-left: 0px;
    padding-right: 5px;
}

.search_thumbnails div{
    display:inline-block;
}

.search_btn {
    float:right;
    margin-top: 6px;
}

.search_btn a {
    display: block;
    border: none;

}

.search_btn form {
    margin-top: 7px;
}

.search_caption {
    // margin-left: -8px;
}

.alert {
    margin-top: 15px;
}

.alert-success {
        background-color: rgba(51, 122, 183, 0.85);
    border: none;
    color: #FFF;
}

.proposal-input {
    margin-top: 10px;
    margin-bottom: 10px;
}
```

En este código hemos añadido los estilos para las siguientes partes de la aplicación, y para los siguientes tutoriales que realizarás.

Recarga tu página y podrás notar la diferencia entre una página estilizada y una con sólo HTML.

Cómo podrás ver tus propuestas tiene al lado las letras **E** y **X** las cuales son unos links que nos llevarán a las acciones Editar y Borrar respectivamente, estas las crearemos más adelante en este tutorial.

También agregaremos en este punto un *header* a la aplicación, esto nos permitirá acceder de manera más sencilla a los 2 links principales de nuestra aplicación **Propuestas** y **Nuevas propuestas*, para esto deberás navegar en el directorio de tu aplicación a la ruta 'codeatag_app/app/views/layouts' y cambiar el contenido del archivo 'application.html.erb' por el siguiente:

```erb
<!DOCTYPE html>
<html>
<head>
  <title>CodeaTAG</title>
  <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track' => true %>
  <%= javascript_include_tag 'application', 'data-turbolinks-track' => true %>
  <%= csrf_meta_tags %>
</head>
<body>
  <%= render "layouts/header"  %>
  <div id="content">
  <div id="flash_div">
	  <% flash.each do |key, value| %>
	    <div class="col-md-12 col-sm-12 col-xs-12 form-group flash_message">
	        <%= content_tag(:div, value, class: "alert alert-#{key}") %>
	    </div>  
	  <% end %>
	</div>  
    <%= yield %>
  <div class="clear"></div>
  </div>
</body>
</html>
```

Una vez que hemos hecho esto dentro del mismo folder vamos a crear el archivo '_header.html.erb' y le añadiremos el siguiente código:

```erb
<header class="navbar navbar-fixed-top navbar-inverse">
  <div class="container">
    <%= link_to image_tag("http://codeatag.herokuapp.com/assets/tag_logo-394f282e31e3ec624989e06880ff128e31b78213d137e2eb078c26b4d560c4f1.png", alt: "tag", :height => 40) , root_path, class: "logo", id: "logo_tag" %>
    	<ul class="nav navbar-nav" style="text-align:center">
    		<li><%= link_to "Propuestas", root_path %></li>
    		<li><%= link_to "Nueva propuesta", new_proposal_path %></li>
    	</ul>
    <%= link_to image_tag("http://codeatag.herokuapp.com/assets/codeacamp_logo-33e6d9abba6ded2b8cc0144f86cdf60c3c5c00e5302194e6d7e3a10f0edfd3fb.png", alt: "Codea", :height => 40) , root_path, class: "logo", id: "logo_codea" %>
    <nav>
      
    </nav>
  </div>
</header>

```

Recarga tu página y aprovecha las nuevas funcionalidades de tu aplicación para crear las propuestas nuevas que quieras.

#### Acción `show`

En este momento si le das click al nombre de tus propuestas encontrarás un error pues aún no hemos creado la acción que muestra cada una de ellas de manera individual.

La acción `show` mostrará el detalle de una `proposal` en particular. Pega el siguiente código en tu controlador antes de la palabra clave `private` y después del último método que tienes:

``` ruby
  def show
    @proposal = Proposal.find(params[:id])
    # render 'proposals/show.html.erb'
  end
```

**Recuerda guardar tus archivos después de cada cambio**

La acción anterior trae de la base de datos una `proposal` pasándole un `id`. Para acceder al id de la url, utilizamos el hash `params`.
Esta acción mostrará el archivo 'show.html.erb'.

Crea el archivo en la ruta 'codeatag_app/app/views/proposals' y copia en él el siguiente código que mostrará el detalle del `proposal` que trajimos de la base de datos.

``` erb
<div class="col-md-4 col-md-offset-4">
  <div class="panel panel-default">
    <div class="panel-body">
      <%= image_tag(@proposal.avatar, class:"img-responsive")%>
    </div>
    <div class="panel-footer text-center h1">
      <%= @proposal.name %>
      <div class="search_btn">            
        <%= link_to "E", edit_proposal_path(@proposal), class: "btn btn-default btn-xs" %>
        <%= link_to "X", proposal_path(@proposal), method: :delete,
        data: { confirm: "¿Seguro que quieres eliminar la propuesta?" }, class: "btn btn-default btn-xs" %>
      </div>
    </div>
  </div>
</div>
```

Ahora navega a tu página principal de propuestas y da click al nombre de alguna de ellas para que veas la página que acabas de crear.


#### Acción `edit`

La acción `edit`, nos permitirá corregir una `proposal` en caso de que nos hayamos equivocado al introducirla, cambiar el nombre o el link al avatar de la misma.

Como en todas las acciones anteriores vamos a comenzar incluyendo el código necesario en el controlador. Agrega las siguientes líneas al mismo:

``` ruby
  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end
```

Para este método tenemos que crear el archivo 'edit.html.erb' en la ruta 'codeatag_app/app/views/proposals/. Agrega el siguiente código en él:

``` erb
<div id="first_section">
  <div class="container">
    <h1 class="text-center">Editar Propuesta</h1>
    <div class="row">            
      <%= form_for @proposal do |f| %>

      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :name,   placeholder: "Nombre", class: "form-control" %>
      </div>
      <div class="proposal-input col-md-offset-3 col-md-6 ">         
        <%= f.text_field :avatar, placeholder: "Avatar", class: "form-control" %>
      </div>    
      <div class="proposal-input col-md-offset-3 col-md-6">
        <%= f.submit "Guardar", class: "btn btn-md btn-primary btn-block" %>
      </div>      
      <% end %>
    </div><!-- first_section -->
  </div><!-- container -->
</div>
```

Con esto ya funcionan los links para editar `E` en las propuestas de tu página Index. Al dar click en cualquiera de estos links, podemos ver nuestra forma, la cual al guardarla genera en este punto un error al no encontrar el método 'update' el cual crearemos a continuación.


#### Acción `update`

La forma anterior se enviará a la acción de `update` de nuestro controlador.  Necesitamos crear la acción con el código que contendrá la lógica para obtener de la base de datos el `proposal` y guardarlo en la base de datos con los nuevos valores. Ve a tu controlador y agrega el siguiente código de la misma manera que haz hecho con los métodos anteriores.

``` ruby
  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)

    redirect_to proposal_path
  end
```

Accede a tus propuestas y edita algunas de ellas, cambiales el nombre y la foto a tu gusto para probar la nueva funcionalidad de tu aplicación. En la última línea indicamos la página que nos mostrará después de actualizar la propuesta (`proposal_path` == acción show).

#### Acción `delete`

La última funcionalidad que nos falta es poder borrar una `proposal`. Para esto vamos a crear la acción `destroy`. Copia el siguiente código en el controlador.

``` ruby
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy

    redirect_to proposals_path
  end
```

Este código hace que funcionen los links que dicen 'X' en las páginas de propuestas de nuestra aplicación para borrar una de ellas. Pruebalo borrando cualquiera de las propuestas que has añadido.

Tu archivo de controlador debe contener el siguiente código al final de estos pasos:

```ruby
class ProposalsController < ApplicationController
    
  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end
  
  def create
    @proposal = Proposal.new(proposal_params)

    @proposal.save
    redirect_to proposals_path
  end
  
  def index
    @proposals = Proposal.all
    # render 'proposals/index.html.erb'
  end
  
  def show
    @proposal = Proposal.find(params[:id])
    # render 'proposals/show.html.erb'
  end
  
  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end
  
  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)

    redirect_to proposal_path
  end
  
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy

    redirect_to proposals_path
  end

  private

  def proposal_params
    params.require(:proposal).permit(:name, :avatar)
  end
end
```

**Con todos estos pasos ya tenemos listo el recurso que hace funcionar todas las acciones CRUD que explicamos al inicio.**

## <center>¡¡Felicidades acabas de crear tu primera app de Rails !!</center>
## PREREQUISITOS

* Ruby on Rails 4
* PostgresSQL

## RUBY ON RAILS IN A NUTSHELL
URLs tienen el formato: `:controller(/:action(/:id))`
Por ejemplo, el URL "registration/user_info" corresponde a la acción `user_info` perteneciente al controller `registration` (el cual se encuentra en `app/controllers/registration_controller`)
```ruby
class RegistrationController < ApplicationController
  def user_info
    ...
  end
```
O sea, `user_info` es un metodo dentro del controller `registration`. Todos los views correspondientes aun controller se encuentran dentro de `app/views/:controller` y son template de HTML con codigo de Ruby insertado. Por ej., el view correspondiente a `user_info` es `app/views/registration/user_info.html.erb`

### CONTROLADORES
* main
* registration : contiene lo referente a la captura de usuario
* dashboard : contiene lo referente al portal del usuario. Sería bueno hacer un refactor para separar los componentes pertenecientes al monitoreo, pay-it-forward, tienda vm.

### RAILS COMMAND LINE
* `rails s` : servidor local en localhost:3000
* `rake db:migrate` migraciones
* `rake db:migrate:reset`

## LIBRERÍAS
* PDFMake : Genera PDF utilizando Javascript. Es utilizada para el contrato. http://pdfmake.org/#/gettingstarted
* Highcharts : Genera las gráficas utilizando Javascript. http://www.highcharts.com/docs
* Stripe : Procesar pagos por tarjeta de crédito. https://stripe.com/docs
* Twitter Bootstrap 2.3.2
* Heroku

## MODELOS
###USER
Representa un usuario, y contiene los siguientes campos:
* nombre
* apellido
* telefono
* celular
* estado
* municipio
* calle
* numero_direccion
* colonia
* codigo_postal

###PROJECT
Representa un proyecto del programa Pay-It-Forward.

###ITEM
Represanta un item en la tienda verdemonarca.

###ENERGY_HISTORY
Mapeo de RPU a información de consumo energético (esta base de datos será comprada en un futuro cercano)

##MISC
###Autenticación de Usuarios
###Emails
###Cron Jobs

##DEPLOYMENT
Heroku permite deploy aplicaciones de Ruby on Rails de manera super sencilla.

##TODOS
* Mucho "polish"
* Generación de clave referencia (que no se dupliquen)
* Computo de puntos en base a historial
* Layouts
* ...


Deploying:
Assets are not being served when using Heroku and Rails 4. Tried installing the rails_12factor gem but that didn't work. Ended up doing this:
heroku config:set RAILS_ENV=development
heroku config:set RACK_ENV=development
Not the ideal solution, but whatever

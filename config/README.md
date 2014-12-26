Deploying:
Assets are not being served when using Heroku and Rails 4. Tried installing the rails_12factor gem but that didn't work. Ended up doing this:
heroku config:set RAILS_ENV=production
heroku config:set RACK_ENV=production
Not the ideal solution, but whatever

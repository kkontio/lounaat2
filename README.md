Lounaat²
========
http://lounaat2.fi

##### Rails app for displaying lunch serving restaurants around Leppävaara/Sello area.

### Notes

Copy the .example config files over and edit them to your liking.

These include:
`/config/database.yml.example`
`/config/initializers/secret_tokeb.rb.example`
`/config/deploy.rb.example`

### Adding scraper plugins

Scrapers use very simple plugin architecture. Create a ruby class in `/lib/scraper/plugins/` that registers itself at RestaurantProcessor (`/lib/scraper/restaurant_processor`) with a regexp for the url pattern it handles and a lambda that takes an url and returns a hash. The hash keys should be dates and values should be arrays of strings that describe the lunches on that day. Check existing plugins for reference.

### Prod.env.notes

Production environment setup in example deployment files is apache/passenger, systemwide rvm, using bundler to install all needed gems to shared/bundle and capistrano for deployment.

Any other server configuration you might wish to use goes as well. These notes serve to support my memory.

## Setting up

Copy your `database.yml` and `secret_token.rb` files to the appropriate capistrano shared config folder - check `deploy.rb`.

Basic steps for production installation. Only going to go through here what is actually relevant for getting this Rails app running and not how to secure your ssh, db or your server in general.

1. Install apache, sshd and RDBMS of your choice (I usually prefer PostgreSQL)
2. Create db for your Rails app
3. Install RVM (system wide/multi-user) and Ruby
4. Install Passenger
5. Add deploy user and add the user to the rvm group

And some additional info for steps 4 and 5.

## Install Passengerer (step 4)

```sh
gem install passenger
rvmsudo passenger-install-apache2-module
```
A few words about passenger/apache config.

Passenger module needs to be pointed to the ruby installation (the installer will also instruct on this). For example:
```sh
#/etc/apache2/mods-available/passenger.load
LoadModule passenger_module /usr/local/rvm/gems/ruby-2.0.0-p247@lounas/gems/passenger-4.0.16/buildout/apache2/mod_passenger.so

#/etc/apache2/mods-available/passenger.conf
PassengerRoot /usr/local/rvm/gems/ruby-2.0.0-p247@lounas/gems/passenger-4.0.16
PassengerDefaultRuby /usr/local/rvm/wrappers/ruby-2.0.0-p247@lounas/ruby
```

Apache vhost site config example.
Root/Dir paths need to be pointed to capistrano deployment directory current/public.
```
<VirtualHost *:80>
  ServerName www.yourdomain.com
  DocumentRoot /railsapp/current/public
  # point to rails app public directory
  <Directory /railsapp/current/public>
    AllowOverride all
    Options -MultiViews
  </Directory>
</VirtualHost>
```

## Add deploy user and add the user to the rvm group (step 5)

Remember to give your deploy user appropriate rights.
```sh
sudo adduser deploy
sudo adduser deploy rvm
sudo chown -R deploy:deploy /path/to/your/app
sudo chmod g+w /path/to/your/app
```

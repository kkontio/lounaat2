Rails app for displaying lunch serving restaurants around Leppävaara/Sello area.

### Notes

Copy the .example config files over and edit them to your liking.

These include:
`/config/database.yml.example`
`/config/initializers/secret_tokeb.rb.example`
`/config/deploy.rb.example`


### Prod.env.notes.

Production environment setup in example deployment files is apache/passenger and systemwide rvm.

Any other configuration as well, of course. This is here mainly so I remember what I used. :)

Copy your database.yml and secret_token.rb files to the appropriate capistrano shared config folder - check deploy.rb.

Remember to give your deploy user appropriate rights.
```sh
sudo adduser deploy
sudo adduser deploy rvm
sudo chown -R deploy:deploy /path/to/your/app
sudo chmod g+w /path/to/your/app
```

A few words about passenger/apache config.

Passenger module needs to be pointed to the ruby installation. For example:
```sh
#/etc/apache2/mods-available/passenger.load
LoadModule passenger_module /usr/local/rvm/gems/ruby-1.9.3-p194/gems/passenger-3.0.15/ext/apache2/mod_passenger.so

#/etc/apache2/mods-available/passenger.conf
PassengerRoot /usr/local/rvm/gems/ruby-1.9.3-p194/gems/passenger-3.0.15
PassengerRuby /usr/local/rvm/wrappers/ruby-1.9.3-p194/ruby
```

Apache vhost site config example.
Root/Dir paths need to be pointed to capistrano deployment directory current/public.
```
<VirtualHost *:80>
  ServerName www.yourdomain.com
  DocumentRoot /railsapp/current/public
  # point to rails app public directory
  <Directory /railsapp/current/public>
    Allow from all
    Options -MultiViews
  </Directory>
</VirtualHost>

```
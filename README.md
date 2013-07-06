# Puppet Solo (AKA: supply_drop)

Similar to [knife-solo](http://matschaffer.github.io/knife-solo/) for use with [chef](http://www.opscode.com/chef/), [supply_drop](https://github.com/pitluga/supply_drop) allows you to provision servers without the need for a [puppet](https://puppetlabs.com/) master server. It uses [capistrano](https://github.com/capistrano/capistrano) for executing commands on the remote server.

## Hello World - Puppet Solo

This sample code will do some provisioning of puppet scripts onto a server. It contains both a [Vagrant](http://docs.vagrantup.com/v2/getting-started/index.html) file for local testing and steps to deploy to a remote server. The sample installs a postgres database server.

### Setup 

* Install some gems (optionally create a gemset first)
  * supply_drop (also installs capistrano)
  * librarian-puppet
  * puppet

```
# install needed gems from Gemfile
bundle install

```

* Install the puppet modules using librarian-puppet
  * Installs all specified modules as well as their dependencies 
  * NOTE: this will put the modules under the modules directory, currently ignored in .gitigore file

```
# install needed puppet modules from Puppetfile
librarian-puppet install
# sometimes you might want to use verbose or clean options
librarian-puppet install --verbose --clean
```

### Test locally using Vagrant

* See the vagrant [getting started](http://docs.vagrantup.com/v2/getting-started/index.html) if you are not familiar with vagrant
* Modify the Vagrantfile as needed
  * currently uses precise64 box (Ubuntu 12.04 64-bit)

```
# create new virtual machine and provision it
vagrant up
# verify postgres was installed
vagrant ssh
# swithc to postgres and list all databases on server
sudo su - postgres
psql --version
psql -c "\l"
# use 'vagrant destroy' and/or 'vagrant provision' if needed for debugging
```

## Notes

```
# create puppetfile
librarian-puppet init
# install modules after updating Puppetfile
librarian-puppet install --verbose --clean
# create Vagrant file
vagrant init

```

### supply_drop

```
# verify can connect to server and run command
cap invoke COMMAND="pwd"
# bootstrap puppet on target box, also runs apt-get update
cap puppet:bootstrap:ubuntu
# run a noop to see what puppet plans to do
cap puppet:noop
# provision
cap puppet:apply
```

## Links

* [https://rubygems.org/gems/librarian-puppet](https://rubygems.org/gems/librarian-puppet)
* [https://rubygems.org/gems/puppet](https://rubygems.org/gems/puppet)
* [https://github.com/pitluga/supply_drop](https://github.com/pitluga/supply_drop)
* [http://www.confreaks.com/videos/2479-railsconf2013-devops-for-the-rubyist-soul](http://www.confreaks.com/videos/2479-railsconf2013-devops-for-the-rubyist-soul)
* [https://speakerdeck.com/jtdowney/devops-for-the-rubyist-soul-at-rubynation-2013](https://speakerdeck.com/jtdowney/devops-for-the-rubyist-soul-at-rubynation-2013)
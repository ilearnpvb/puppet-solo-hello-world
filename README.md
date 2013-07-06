# Puppet Solo (AKA: supply_drop)

Similar to [knife-solo](http://matschaffer.github.io/knife-solo/) for use with [chef](http://www.opscode.com/chef/), [supply_drop](https://github.com/pitluga/supply_drop) allows you to provision servers using [puppet](https://puppetlabs.com/) without the need for a puppet master server. It uses [capistrano](https://github.com/capistrano/capistrano) for executing commands on the remote server.

## Hello World - Puppet Solo

This sample code will provision a server using puppet scripts. It contains both a [Vagrant](http://docs.vagrantup.com/v2/getting-started/index.html) file for local testing and steps to deploy to a remote server. The sample installs a postgres database server.

### Setup 

* clone the repo

```
git clone https://github.com/house9/puppet-solo-hello-world.git
```

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
# switch to postgres user and list all databases on server
sudo su - postgres
psql --version
psql -c "\l"
# use 'vagrant destroy' and/or 'vagrant provision' if needed for debugging
```

### Provision a server

* Get a box (DigitalOcean, Linode, Local Network box, etc…) to provision - you will need root privileges; this example uses a Digital Ocean Droplet
  * create a new droplet and select Ubuntu 12.04
  * if you previously uploaded your public ssh key to DigitalOcean then select it when creating the droplet (no password needed)
  * for the example assume our IP is 000.111.0.1, change this as needed
* Review the Capfile and the manifests/default.pp file
  * update with your real IP or host name as needed (in both files)
  * NOTE: grouping all servers into roles is not required, but is convienent when dealing with multiple servers. Using roles requires specifying the role when running `cap` commands (as is done below)

```
# ssh to the server to add it to 'known hosts'
ssh root@000.111.0.1
exit
# verify capistrano is working
cap qa invoke COMMAND="echo 'hello supply-drop'"
# bootstrap the server using capistrano and supply_drop
cap qa puppet:bootstrap:ubuntu
# provision
cap qa puppet:apply
# optionally you can do a noop to see what it wants to provision before running apply
cap qa puppet:noop

# verify postgres was installed
ssh root@000.111.0.1
# switch to postgres user and list all databases on server
sudo su - postgres
psql --version
psql -c "\l"
```

## Resources

* [http://www.confreaks.com/videos/2479-railsconf2013-devops-for-the-rubyist-soul](http://www.confreaks.com/videos/2479-railsconf2013-devops-for-the-rubyist-soul)
* [https://speakerdeck.com/jtdowney/devops-for-the-rubyist-soul-at-rubynation-2013](https://speakerdeck.com/jtdowney/devops-for-the-rubyist-soul-at-rubynation-2013)



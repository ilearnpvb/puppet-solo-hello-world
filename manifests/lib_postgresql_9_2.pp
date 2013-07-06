class lib_postgresql_9_2 {

  # manage_package_repo => true will satisfy apt_postgresql_org
  # include postgresql::package_source::apt_postgresql_org
  # ubuntu 12.04 has older versions of postgres in the apt universe

  class { 'postgresql':
    version => '9.2',
    manage_package_repo => true,
    charset => 'UTF8',
    locale  => 'en_US.UTF-8',
  }

  # need libpq-dev for pg gem on the 'app' server if using ruby
  class { 'postgresql::devel': }

  class { 'postgresql::server': }


  # # for dev boxes only
  # class { 'postgresql::server':
  #   config_hash => {
  #     listen_addresses => '*', # for dev boxes only
  #   }
  # }

  # postgresql::pg_hba_rule { 'allow application network to access app database':
  #   description => "Open up postgresql for access for dev",
  #   type => 'host',
  #   database => 'all',
  #   user => 'all',
  #   address => '0.0.0.0/0',
  #   auth_method => 'md5'
  # }
}

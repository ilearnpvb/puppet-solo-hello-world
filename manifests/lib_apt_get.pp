class lib_apt_get {
  exec { 'apt-get update':
    command => 'apt-get update',
    path    => '/usr/bin/',
    timeout => 60,
    tries   => 3
  }
}

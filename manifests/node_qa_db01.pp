import 'lib_apt_get'
import 'lib_postgresql_9_2'

class node_qa_db01 {
  notice("Provision node [$::hostname | $::ipaddress] with 'node_qa_db01'")

  include lib_apt_get
  include lib_postgresql_9_2

  # create a database on this node
  postgresql::db { 'hello-world-db':
    user     => 'hello-puppet-solo',
    password => 'supply-drop',
  }
}
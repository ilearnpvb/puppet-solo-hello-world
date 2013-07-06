notice("==============================================")
notice("FQDN: $fqdn")
notice($::ipaddress)
notice($::hostname)
notice("==============================================")

import 'node_qa_db01' # see manifests/node_qa_db01

node default {

  # vagrant box, see Vagrantfile for local testing
  if $::hostname == "db1" {
    include 'node_qa_db01'
  }

  # remote provision based on IP
  if $::ipaddress == "192.241.201.166" {
    include 'node_qa_db01'
  }
}
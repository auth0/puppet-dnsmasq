class dnsmasq::config {
  File {
    owner => 'root',
    group => 'root',
  }

  file {
    $dnsmasq::params::config_file:
      mode   => '0644',
      content => template('dnsmasq/dnsmasq.conf.erb')

#    $dnsmasq::params::config_dir:
#      ensure  => 'directory',
#      recurse => true,
#      purge   => true,
#      force   => true;
  }
}

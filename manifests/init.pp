class dnsmasq (
$resolv_file = false,
$resolv_nameserver = false,
) {
  include dnsmasq::params

  anchor { 'dnsmasq::start': }

  class { 'dnsmasq::install': require => Anchor['dnsmasq::start'], }

  class { 'dnsmasq::config': require => Class['dnsmasq::install'], notify  => Class['dnsmasq::reload'] }

  class { 'dnsmasq::service':
    subscribe => Class['dnsmasq::install', 'dnsmasq::config'],
  }

  class { 'dnsmasq::reload':
    require => Class['dnsmasq::service'],
  }

  anchor { 'dnsmasq::end': require => Class['dnsmasq::service'], }
  if $::settings::storeconfigs {
    File_line <<| tag == 'dnsmasq-host' |>>
  }

  if $resolv_file and $resolv_nameserver {
    file { "${resolv_file}":
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => "nameserver ${resolv_nameserver}"
    }
  }
}

# == Class: powerdns

class powerdns (
  $settings        = {},
  $master          = undef,
  $slave           = undef,
  $daemon          = undef,
  $guardian        = undef,
  $setuid          = undef,
  $setgid          = undef,
  $package_name    = undef,
  $package_ensure  = undef,
  $service_name    = undef,
  $service_ensure  = undef,
  $service_enable  = undef,
  $config_owner    = undef,
  $config_group    = undef,
  $config_mode     = undef,
  $config_path     = undef,
  $config_purge    = undef,
  $enable_api      = undef,
  $api_key         = undef,
  $webserver       = undef,
  $local_port      = undef,
) {
  # Fail fast if we're not using a new Puppet version.
  if versioncmp($::puppetversion, '3.7.0') < 0 {
    fail('This module requires the use of Puppet v3.7.0 or newer.')
  }

  validate_hash($settings)

  if $master and $slave {
    validate_bool($master)
    validate_bool($slave)
  }

  if $setuid and $setgid {
    validate_string($setuid)
    validate_string($setgid)
  }

  contain '::powerdns::install'
  contain '::powerdns::config'
  contain '::powerdns::service'

  Class['::powerdns::install'] ->
  Class['::powerdns::config'] ~>
  Class['::powerdns::service']

}

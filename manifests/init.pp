# Class: unifiedlogs
# ===========================
#
# Full description of class unifiedlogs here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class unifiedlogs (
  $package_name = $::unifiedlogs::params::package_name,
  $hookdir = $::unifiedlogs::params::hookdir,
) inherits ::unifiedlogs::params {


  # validate parameters here

  class { '::unifiedlogs::install': } ->
  class { '::unifiedlogs::service': } ->
  Class['::unifiedlogs']
}

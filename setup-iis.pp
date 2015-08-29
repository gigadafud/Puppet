

node 'nodename' {
  include install-telnet
  include setup-base-iis
  include remove-default-site
  include create-sites-folders
  include testsite
}


exec { 'puppet-fstab':
    path => 'C:\\Program Files\\Puppet Labs\\Puppet\\bin',
    command => 'puppet module install puppetlabs-windows',
}


# Class: setup-base-iis
#
#
class setup-base-iis {
  # resources
  windowsfeature { 'IIS':
  ensure => present,
  feature_name => [
    'Web-Server',
    'Web-WebServer',
    'Web-Http-Errors',
    'Web-Http-Redirect',
    'Web-Health',
    'Web-Http-Logging',
    'Web-Custom-Logging',
    'Web-Log-Libraries',
    'Web-ODBC-Logging',
    'Web-Request-Monitor',
    'Web-Http-Tracing',
    'Web-Performance',
    'Web-Stat-Compression',
    'Web-Dyn-Compression',
    'Web-Filtering',
    'Web-Basic-Auth',
    'Web-Windows-Auth',
    'Web-Asp-Net45',
    'Web-AppInit',
    'Web-ISAPI-Ext',
    'Web-ISAPI-Filter',
    'NET-Framework-45-ASPNET',
    'WAS-NET-Environment',
    'Web-Includes'
  ]
  }
}


# Class: remove-default-site
#
#
class remove-default-site {
  # resources
  iis::manage_site { 'Default Web Site':
  ensure => 'purged',
  app_pool => 'DefaultAppPool'
  }
}



# Class: install-telnet
# 
#
class install-telnet {
  # resources
  windowsfeature { 'TELNET':
  ensure => present,
  feature_name => 'telnet-client'
  }

}



class testsite {
  iis::manage_app_pool {'testsiteapppool':
    manage_runtime_version => 'v4.0',
  }

  iis::manage_site {'testsite':
    site_path => 'c:\sites\testsite',
    port => '8080',
    ip_address => '*',
    host_header => 'testsite',
    app_pool => 'testsiteapppool'
  } 
}




# Class: create-sites-folders
#
#
class create-sites-folders {
  # resources
  # or you can assign them to a variable and use them in the resource
  $whisper_dirs = [ "c:/sites/", "c:/sites/big",
                  "c:/sites/missioncontrol",
                ]

  file { $whisper_dirs:
    ensure => "directory",
    }
}

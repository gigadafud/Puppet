windowsfeature { 'IIS':
  ensure => present,
  feature_name => [
    'Web-Server',
    'Web-WebServer',
    'Web-Asp-Net45',
    'Web-ISAPI-Ext',
    'Web-ISAPI-Filter',
    'NET-Framework-45-ASPNET',
    'WAS-NET-Environment',
    'Web-Http-Redirect',
    'Web-Filtering'
    'Web-Windows-Auth',
    'Web-Basic-Auth',
    'Web-Custom-Logging',
    'Web-Http-Tracing',
    'Web-Includes'
  ]
}

iis::manage_site { 'Default Web Site':
  ensure => 'purged',
  app_pool => 'DefaultAppPool'
}


node 'nodename' {
  include 'testsite'
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

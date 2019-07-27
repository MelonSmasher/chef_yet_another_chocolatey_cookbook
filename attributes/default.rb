default['yacc']['ignore_failure'] = false
default['yacc']['install_options'] = {}
default['yacc']['config'] = {}
default['yacc']['default_sources'] = {:chocolatey => {:source => 'https://chocolatey.org/api/v2/', :action => 'present', :priority => 0}}
default['yacc']['packages'] = {}

# Business features
default['yacc']['business']['synchronize'] = false
default['yacc']['business']['uninstall_from_programs'] = []
default['yacc']['business']['optimize'] = false
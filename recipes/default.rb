#
# Cookbook Name:: yacc
# Recipe:: default
#

# This function calls the upstream chocolatey resource built into chefs
def run_upstream(action, options, source, ignore_failure)
  chocolatey_package package do
    options options
    source source
    ignore_failure ignore_failure
    action action
  end
end

# Grab the global package source
source = node['yacc']['source']
# Global value for ignoring failures
ignore_failure = node['yacc']['ignore_failure']
# Grab install options that will be applied to each package
install_options =''
if not node['yacc']['install_options'].empty?
  # Are the install options an array?
  if node['yacc']['install_options'].is_a?
    # Strip each array element then join array to a single string
    install_options = node['yacc']['install_options'].each { |a| a.strip! if a.respond_to? :strip! }.join(' ')
  elsif node['yacc']['install_options'].is_s?
    install_options = node['yacc']['install_options'].strip
  else
    log 'YACC Global' do
      message "Global install options contain a malformed install option, ignoring...."
      level :warn
    end
  end
end

# Loop over packages
node['yacc']['packages'].each do |package, package_options|
  # Grab the desired action/version
  action_option = package_options['action']
  # Is the source overridden for this package?
  source = package_options['source'] if not package_options['action'].empty?
  # If there are any package specific install options append them to the global install options
  if not package_options['install_options'].empty?
    # Check to see if it's an array or string
    if package_options['install_options'].is_a?
      # Strip each array element then join array to a single string
      install_options = package_options['install_options'].each { |a| a.strip! if a.respond_to? :strip! }.join(' ') + ' ' + install_options
    elsif package_options['install_options'].is_s?
      install_options = package_options['install_options'].strip + ' ' + install_options
    else
      log 'YACC Package' do
        message "The package: '#{package}' contains a malformed install option, ignoring..."
        level :warn
      end
    end

  end
  # Switch over the various actions and pass in the correct action symbol
  case action_option
    when 'install'
      run_upstream(:install, install_options, source, ignore_failure)
    when 'purge'
      run_upstream(:purge, install_options, source, ignore_failure)
    when 'reconfig'
      run_upstream(:reconfig, install_options, source, ignore_failure)
    when 'remove'
      run_upstream(:remove, install_options, source, ignore_failure)
    when 'uninstall'
      run_upstream(:uninstall, install_options, source, ignore_failure)
    when 'upgrade'
      run_upstream(:upgrade, install_options, source, ignore_failure)
    else # If we make it here, try the action as a version number.
      chocolatey_package package do
        version action_option
        options install_options
        source source
        ignore_failure ignore_failure
        action :install
      end
  end
end

#
# Cookbook Name:: yacc
# Recipe:: default
#

# This function calls the upstream chocolatey resource built into chefs
def run_upstream(package, action, options, source, ignore_failure)
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
install_options = []
unless node['yacc']['install_options'].nil?
  unless node['yacc']['install_options'].empty?
    # Are the install options an array?
    if node['yacc']['install_options'].is_a? Array
      # Join into a single array
      install_options = node['yacc']['install_options'].concat(install_options)
    else
      log 'YACC Global' do
        message "Global install options are malformed ignoring..."
        level :warn
      end
    end
  end
end

# Loop over packages
node['yacc']['packages'].each do |package, package_options|
  # Grab the desired action/version
  action_option = package_options['action']
  # Is the source overridden for this package?
  source = package_options['source'] unless package_options['action'].empty?
  # If there are any package specific install options append them to the global install options
  if package_options.key?('install_options')
    unless package_options['install_options'].nil?
      unless package_options['install_options'].empty?
        # Check to see if it's an array or string
        if package_options['install_options'].is_a? Array
          # Join the arrays into a single array
          install_options = package_options['install_options'].concat(install_options)
        else
          log 'YACC Package' do
            message "The package: '#{package}' contains a malformed install option, ignoring..."
            level :warn
          end
        end
      end
    end
  end
  # If the install options are empty make into a blank string otherwise strip each element of the array and join into a string separated by spaces
  install_options = install_options.empty? ? '' : install_options.is_a? Array ? install_options.each { |a| a.strip! if a.respond_to? :strip! }.join(' ') : install_options.strip
  # Switch over the various actions and pass in the correct action symbol
  case action_option
    when 'install'
      run_upstream(package, :install, install_options, source, ignore_failure)
    when 'purge'
      run_upstream(package, :purge, install_options, source, ignore_failure)
    when 'reconfig'
      run_upstream(package, :reconfig, install_options, source, ignore_failure)
    when 'remove'
      run_upstream(package, :remove, install_options, source, ignore_failure)
    when 'uninstall'
      run_upstream(package, :uninstall, install_options, source, ignore_failure)
    when 'upgrade'
      run_upstream(package, :upgrade, install_options, source, ignore_failure)
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

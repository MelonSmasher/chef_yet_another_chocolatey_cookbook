name 'yacc'
maintainer 'Alex Markessinis'
maintainer_email 'markea125@gmail.com'
license 'MIT'
description 'YACC (Yet Another Chocolatey Cookbook), Manages many chocolatey packages through attributes.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.8.2'
supports 'windows'
issues_url 'https://github.com/MelonSmasher/chef_yet_another_chocolatey_cookbook/issues'
source_url 'https://github.com/MelonSmasher/chef_yet_another_chocolatey_cookbook'
chef_version ">= 12"
depends 'chocolatey', '~> 1.2.0'
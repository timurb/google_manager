# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','google','version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'google'
  s.version = Google::VERSION
  s.author = 'Timur Batyrshin'
  s.email = 'erthad@gmail.com'
  s.homepage = 'http://erthad.name'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A commandline tool to manage google mailboxes and groups'
# Add your other files here if you make them
  s.files = %w(
bin/google
lib/google/version.rb
lib/google.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','google.rdoc']
  s.rdoc_options << '--title' << 'google' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'google'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.5.0')
  s.add_runtime_dependency('google_apps')
  s.add_runtime_dependency('active_support')
  s.add_runtime_dependency('i18n')
end

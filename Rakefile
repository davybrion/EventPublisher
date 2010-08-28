require 'rake'
require 'rake/gempackagetask'
require 'rubygems'
require 'spec/rake/spectask'

gem_spec = Gem::Specification.new do |s|
  s.name = 'EventPublisher'
  s.version = '0.1'
  s.has_rdoc = false
  s.summary = 'A module which enables objects to publish multiple events, which other objects can subscribe to'
  s.description = s.summary + ' See http://github.com/davybrion/EventPublisher for more information.'
	s.homepage = "http://github.com/davybrion/EventPublisher"
  s.author = 'Davy Brion'
  s.email = 'ralinx@davybrion.com'
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
	s.require_path = "lib"
	s.required_ruby_version = '>= 1.9.1'
  s.bindir = "bin"
end

build_gem = Rake::GemPackageTask.new(gem_spec) do |p|
  p.gem_spec = gem_spec
end

run_specs = Spec::Rake::SpecTask.new(:run_specs) do |t|
  t.spec_files = FileList['test/*_spec.rb']
	t.verbose = true
	t.warning = true
	t.spec_opts << "--format nested"
end

task :default  => :run_specs


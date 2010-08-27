require 'rake'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['test/*_spec.rb']
	t.verbose = true
	t.warning = true
end

task :default  => :spec

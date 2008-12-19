require 'rubygems'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/clean'

require 'yard'
require 'yard/rake/yardoc_task'

require 'spec/rake/spectask'

require 'merb-core'
require 'merb-core/tasks/merb'

GEM_NAME = "merb-recaptcha"
GEM_VERSION = "1.0.2"
AUTHOR = "Anton Ageev"
EMAIL = "antage@gmail.com"
HOMEPAGE = "http://github.com/antage/merb-recaptcha/"
SUMMARY = "Merb plugin that provides helpers for recaptcha.net service"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb-recaptcha'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = [ "README.rdoc", "LICENSE" ]
  s.rdoc_options << "--main" << "README.rdoc"
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.require_path = 'lib'
  s.files = %w(LICENSE README.rdoc Rakefile TODO merb-recaptcha.gemspec) + Dir["lib/**/*"].select { |f| File.file?(f) }
  s.test_files = %w(spec/spec_helper.rb) + Dir["spec/*_spec.rb"] + Dir["spec/fixture/app/**/*"].select { |f| File.file?(f) }

  s.add_runtime_dependency "merb-core", ">= 1.0.0"
  s.add_runtime_dependency "builder", "~> 2.0"
  s.add_development_dependency "rspec", ">= 1.1.0"
  s.add_development_dependency "mocha", ">= 0.9.3"
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "install the plugin as a gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

Rake::RDocTask.new do |rdoc|
  files = ["README.rdoc", "LICENSE", "lib/**/*.rb"]
  rdoc.rdoc_files.add(files)
  rdoc.main = "README.rdoc"
  rdoc.title = "merb-recaptcha docs"
  rdoc.rdoc_dir = "doc"
  rdoc.options << "--line-numbers" << "--inline-source"
end

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts << '--format' << 'specdoc' << '--colour'
  t.spec_opts << '--loadby' << 'random'
  t.spec_files = Pathname.glob(ENV['FILES'] || 'spec/**/*_spec.rb')
  t.rcov = false
end

task :default => :spec

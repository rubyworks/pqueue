require 'rubygems/package_task'

gemspec = Gem::Specification.load('pqueue.gemspec')

Gem::PackageTask.new(gemspec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
end

desc "Run tests"
task :test do
  sh 'ruby -Ilib test/test_pqueue.rb'
end

task :default => :test

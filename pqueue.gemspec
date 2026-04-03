Gem::Specification.new do |s|
  s.name        = 'pqueue'
  s.version     = '2.2.0'
  s.summary     = 'Queue of Prioritized Elements'
  s.description = 'A priority queue is like a standard queue, except that each inserted ' \
                  'element is given a certain priority, based on the result of the comparison ' \
                  'block given at instantiation time. Retrieving an element from the queue ' \
                  'will always return the one with the highest priority.'

  s.authors     = ['Trans', 'K. Kodama', 'Ronald Butler', 'Olivier Renaud', 'Rick Bradley']
  s.email       = ['transfire@gmail.com']

  s.homepage    = 'https://github.com/rubyworks/pqueue'
  s.license     = 'BSD-2-Clause'

  s.required_ruby_version = '>= 3.1'

  s.files       = Dir['lib/**/*', 'License.txt', 'README.md', 'History.md']
  s.require_paths = ['lib']

  s.add_development_dependency 'rake', '>= 13'
  s.add_development_dependency 'minitest', '>= 5'
end

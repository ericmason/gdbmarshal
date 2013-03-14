Gem::Specification.new do |s|
  s.name = 'gdbmarshal'
  s.version = '0.1'
  s.summary = 'GDBM subclass that takes objects as values'
  s.email = 'eric@ericmason.net'
  s.homepage = 'https://github.com/ericmason/gdbmarshal'
  s.has_rdoc = true
  s.authors = ["Eric Mason"]
  s.files = Dir.glob("{bin,lib}/**/*") + %w{Rakefile README.rdoc}
  s.requirements = ["none"]
  s.add_development_dependency "rspec"
  s.require_path = 'lib'
end
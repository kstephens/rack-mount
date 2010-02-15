Gem::Specification.new do |s|
  s.name     = 'rack-mount'
  s.version  = '0.5.1'
  s.date     = '2010-02-15'
  s.summary  = 'Stackable dynamic tree based Rack router'
  s.description = s.summary

  s.add_dependency 'rack', '>= 1.0.0'

  s.files = Dir['lib/**/*.rb']

  s.has_rdoc = true
  s.extra_rdoc_files = %w[README.rdoc LICENSE]

  s.author   = 'Joshua Peek'
  s.email    = 'josh@joshpeek.com'
  s.homepage = 'http://github.com/josh/rack-mount'
end

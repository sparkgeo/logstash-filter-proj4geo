Gem::Specification.new do |s|
  s.name          = 'logstash-filter-proj4geo'
  s.version       = '0.0.1'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Logstash filter to convert from a SRS to Web Mercator'
  s.homepage      = 'https://github.com/sparkgeo/logstash-filter-proj4geo'
  s.authors       = ['kalmas']
  s.email         = 'alain@sparkgeo.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "filter" }

  s.add_dependency 'rgeo', '2.1.1'
  s.add_dependency 'rgeo-proj4', '2.0.0'

  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60", "<= 2.99"
  
  s.add_development_dependency 'logstash-devutils', '1.3.3'
end
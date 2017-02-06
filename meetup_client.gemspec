# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'meetup_client'
  s.date        = Time.now().strftime("%Y-%m-%d")
  s.summary     = "Easy way to access the Meetup.com API"
  s.description = "Easy way to access the Meetup.com API"
  s.authors     = ["Cosimo Ranieri"]
  s.email       = 'co.ranieri@gmail.com'
  s.files       = %w(README.md Rakefile meetup_client.gemspec)
  s.files      += Dir.glob("lib/**/*.rb")
  s.files      += Dir.glob("spec/**/*")
  s.version     = '0.0.9'
  s.homepage    = 'https://rubygems.org/gems/meetup_client'
  s.license     = 'MIT'
  s.add_development_dependency "bundler", "~> 1.5"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "pry"
end

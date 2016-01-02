$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gmapsderails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gmapsderails"
  s.version     = Gmapsderails::VERSION
  s.authors     = ["wroc"]
  s.email       = ["wroc@example.com"]
  s.homepage    = "https://github.com/wroc/gmapsderails.git"
  s.summary     = "Google Maps data coordination"
  s.description = "Google Maps with Rails"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_development_dependency "bundler", "~> 1.11"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end

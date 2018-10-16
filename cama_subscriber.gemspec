$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cama_subscriber/version"

require "digest"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cama_subscriber"
  s.version     = CamaSubscriber::VERSION
  s.authors     = ["Owen Peredo"]
  s.email       = ["owenperedo@gmail.com"]
  s.homepage    = ""
  s.summary     = "A plugin to manage email subscriptions and newsletters."
  s.description = s.summary
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails"

  s.add_development_dependency "sqlite3"
end

$:.push File.expand_path('../lib', __FILE__)
require 'paper_generation/version'
Gem::Specification.new do |s|
  s.name        = 'paper_generation'
  s.version     = PaperGeneration::VERSION
  s.date        = '2017-01-08'
  s.platform    = Gem::Platform::RUBY

  s.summary     = "Question Paper Generation"
  s.description = "A gem to select question ids from the given question bank for question paper generation."
  s.authors     = ["Shobhit Dixit"]
  s.email       = 'shobhit.dixit@metacube.com'
  # s.files       = `git ls-files`.split("\n")
  s.files       = Dir['lib/*.rb'] + Dir['lib/overrides/*.rb'] + Dir['lib/paper_generation/*.rb']
  s.require_paths = ['lib']
  # s.homepage    =
  #   'http://rubygems.org/gems/hola'
  # s.license       = 'MIT'
end

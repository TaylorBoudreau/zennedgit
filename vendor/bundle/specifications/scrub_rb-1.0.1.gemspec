# -*- encoding: utf-8 -*-
# stub: scrub_rb 1.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "scrub_rb"
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jonathan Rochkind"]
  s.date = "2014-09-16"
  s.email = ["jonathan@dnil.net"]
  s.homepage = "https://github.com/jrochkind/scrub_rb"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Pure-ruby polyfill of MRI 2.1 String#scrub, for ruby 1.9 and 2.0 any interpreter"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end

# -*- encoding: utf-8 -*-
# stub: zendesk_api 1.13.2 ruby lib

Gem::Specification.new do |s|
  s.name = "zendesk_api"
  s.version = "1.13.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Steven Davidovitz", "Michael Grosser"]
  s.date = "2015-12-23"
  s.description = "Ruby wrapper for the REST API at https://www.zendesk.com. Documentation at https://developer.zendesk.com."
  s.email = ["support@zendesk.com"]
  s.homepage = "https://developer.zendesk.com"
  s.licenses = ["Apache License Version 2.0"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.0")
  s.rubygems_version = "2.4.5"
  s.summary = "Zendesk REST API Client"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bump>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_runtime_dependency(%q<faraday>, ["~> 0.9"])
      s.add_runtime_dependency(%q<hashie>, ["!= 3.3.0", "< 4.0", ">= 1.2"])
      s.add_runtime_dependency(%q<inflection>, [">= 0"])
      s.add_runtime_dependency(%q<multipart-post>, ["~> 2.0"])
      s.add_runtime_dependency(%q<mime-types>, ["~> 2.99"])
      s.add_runtime_dependency(%q<scrub_rb>, ["~> 1.0.1"])
    else
      s.add_dependency(%q<bump>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<faraday>, ["~> 0.9"])
      s.add_dependency(%q<hashie>, ["!= 3.3.0", "< 4.0", ">= 1.2"])
      s.add_dependency(%q<inflection>, [">= 0"])
      s.add_dependency(%q<multipart-post>, ["~> 2.0"])
      s.add_dependency(%q<mime-types>, ["~> 2.99"])
      s.add_dependency(%q<scrub_rb>, ["~> 1.0.1"])
    end
  else
    s.add_dependency(%q<bump>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<faraday>, ["~> 0.9"])
    s.add_dependency(%q<hashie>, ["!= 3.3.0", "< 4.0", ">= 1.2"])
    s.add_dependency(%q<inflection>, [">= 0"])
    s.add_dependency(%q<multipart-post>, ["~> 2.0"])
    s.add_dependency(%q<mime-types>, ["~> 2.99"])
    s.add_dependency(%q<scrub_rb>, ["~> 1.0.1"])
  end
end

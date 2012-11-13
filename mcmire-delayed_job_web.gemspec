# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{mcmire-delayed_job_web}
  s.version = "1.1.3.rc4"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Erick Schmitt", "Elliot Winkler"]
  s.date = %q{2012-11-12}
  s.default_executable = %q{delayed_job_web}
  s.description = %q{Web interface for delayed_job inspired by resque}
  s.email = %q{ejschmitt@gmail.com}
  s.executables = ["delayed_job_web"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.markdown"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "bin/delayed_job_web",
    "lib/delayed_job_web.rb",
    "lib/delayed_job_web/application/app.rb",
    "lib/delayed_job_web/application/public/images/poll.png",
    "lib/delayed_job_web/application/public/javascripts/application.js",
    "lib/delayed_job_web/application/public/javascripts/jquery-1.7.1.min.js",
    "lib/delayed_job_web/application/public/javascripts/jquery.relatize_date.js",
    "lib/delayed_job_web/application/public/stylesheets/reset.css",
    "lib/delayed_job_web/application/public/stylesheets/style.css",
    "lib/delayed_job_web/application/views/enqueued.haml",
    "lib/delayed_job_web/application/views/error.haml",
    "lib/delayed_job_web/application/views/failed.haml",
    "lib/delayed_job_web/application/views/job.haml",
    "lib/delayed_job_web/application/views/layout.haml",
    "lib/delayed_job_web/application/views/next_more.haml",
    "lib/delayed_job_web/application/views/overview.haml",
    "lib/delayed_job_web/application/views/pending.haml",
    "lib/delayed_job_web/application/views/stats.haml",
    "lib/delayed_job_web/application/views/working.haml",
    "mcmire-delayed_job_web.gemspec",
    "test/helper.rb",
    "test/test_delayed_job_web.rb"
  ]
  s.homepage = %q{http://github.com/ejschmitt/delayed_job_web}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Web interface for delayed_job}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.2"])
      s.add_runtime_dependency(%q<haml>, ["~> 3.1.3"])
      s.add_runtime_dependency(%q<activerecord>, ["> 2.0.0"])
      s.add_runtime_dependency(%q<delayed_job>, ["> 2.0.3"])
      s.add_runtime_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<rack-test>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0.9.2"])
      s.add_dependency(%q<haml>, ["~> 3.1.3"])
      s.add_dependency(%q<activerecord>, ["> 2.0.0"])
      s.add_dependency(%q<delayed_job>, ["> 2.0.3"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<bundler>, ["> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<rack-test>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0.9.2"])
    s.add_dependency(%q<haml>, ["~> 3.1.3"])
    s.add_dependency(%q<activerecord>, ["> 2.0.0"])
    s.add_dependency(%q<delayed_job>, ["> 2.0.3"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<bundler>, ["> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<rack-test>, [">= 0"])
  end
end


# frozen_string_literal: true

require_relative "lib/social365/version"

Gem::Specification.new do |spec|
  spec.name = "social365-ruby-client"
  spec.version = Social365::VERSION
  spec.authors = ["SOCIAL365 DEV Team"]
  spec.email = ["support@social365.live"]

  spec.summary = "Ruby Client to interact with the Social365 API"
  spec.description = "This gem provides a low level client with convenience methods to interact with the www.social365.live API's. The gem is being actively developed and currently supports, only the image creation module."
  spec.homepage = "https://www.social365.live"
  spec.license = "AGPL-3.0"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["allowed_push_host"] = "www.rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/wordjelly/social365-ruby-client"
  spec.metadata["changelog_uri"] = "https://www.github.com/wordjelly/social365-ruby-client"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
=begin
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
=end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "typhoeus"
  spec.add_dependency "activesupport"
  spec.add_dependency "byebug"
  spec.add_dependency "nokogiri"

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

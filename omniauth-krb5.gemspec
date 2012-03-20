# encoding: utf-8
require File.expand_path('../lib/omniauth-krb5/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'rkerberos'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'

  gem.authors = ['Dave Naffis']
  gem.email = ['dave@intridea.com']
  gem.description = %q{Kerberos strategy for OmniAuth.}
  gem.summary = gem.description
  gem.homepage = 'http://github.com/naffis/omniauth-krb5'

  gem.name = 'omniauth-krb5'
  gem.require_paths = ['lib']
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = OmniAuth::Krb5::VERSION
end

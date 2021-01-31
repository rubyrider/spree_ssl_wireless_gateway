source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'spree', github: 'spree/spree', branch: 'master'
gem 'rails-controller-testing'

unless ENV['WITHOUT_SPREE_AUTH_DEVISE'] == 'true'
  gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: 'master'
end

gem 'faraday'

gemspec

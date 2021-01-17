# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_ssl_wireless_gateway/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_ssl_wireless_gateway'
  s.version     = SpreeSslWirelessGateway.version
  s.summary     = 'Payment Gateway For SSL Wireless Bangladesh'
  s.description = 'SSLWireless is a Bangladeshi Company that is the largest payment gateway'
  s.required_ruby_version = '>= 2.2.7'

  s.author    = 'Irfan Ahmed'
  s.email     = 'irfandhk@gmail.com'
  s.homepage  = 'https://github.com/rubyrider/spree_ssl_wireless_gateway'
  s.license = 'BSD-3-Clause'

  s.files       = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 3.2.0', '< 5.0'
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_api', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_frontend', spree_version
  s.add_dependency 'spree_extension'

  s.add_development_dependency 'spree_dev_tools'
end

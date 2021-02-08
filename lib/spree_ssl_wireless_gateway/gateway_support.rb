module SpreeSslWirelessGateway
  class GatewaySupport < ::Spree::Gateway
    preference :supported_countries, :string, default: %w(BD)
    preference :default_currency, :string, default: 'BDT'
    preference :money_format, :string, default: :cents
    preference :homepage_url, :string, default: 'https://sandbox.sslcommerz.com/'
    preference :sanbox_url, :string, default: 'https://sandbox.sslcommerz.com/'
    preference :test_mode, :boolean, default: true
    preference :server, :string, default: 'https://securepay.sslcommerz.com'.freeze
    preference :display_name, :string, default: 'SSL Wireless Gateway'.freeze
  end
end

module SpreeSslWirelessGateway
  class GatewaySupport < Gateway
    self.live_url = 'https://securepay.sslcommerz.com'.freeze
    
    self.supported_countries = %w(BD)
    self.default_currency    = 'BDT'
    self.money_format        = :cents
    self.supported_cardtypes = %i[visa master american_express]
    
    self.homepage_url = 'https://sandbox.sslcommerz.com/'
    self.display_name = 'SSL Wireless Gateway'
    
    def authorize
    
    end
    
    def purchase
    
    end
    
    def capture
    
    end
    
    def void
    
    end
    
    def credit
    
    end
    
    private
  end
end

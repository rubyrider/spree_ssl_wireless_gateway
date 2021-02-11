class ::Spree::Gateway::SslWireless < ::Spree::Gateway
  
  MINIMUM_INSTALLMENT_PERIOD = 3
  
  preference :merchant_id, :string
  preference :api_key, :string
  preference :product_category, :string
  preference :host, :string
  preference :server, :string, default: 'https://sandbox.sslcommerz.com'.freeze
  preference :emi_enable, :boolean, default: false
  preference :emi_maximum_installments, default: 6
  preference :emi_minimum_amount, default: 5000

  def provider_class
    ::Spree::Gateway::SslWireless
  end
  
  def installment_range
    (MINIMUM_INSTALLMENT_PERIOD..preferences[:emi_maximum_installments].to_i).select {|i| i % MINIMUM_INSTALLMENT_PERIOD == 0 }
  end
  
  def method_type
    'all_online'
  end
  
  def payment_profiles_supported?
    true
  end

  def auto_capture?
    false
  end

  # :authorize, :purchase, :capture, :void, :credit
  #
  # def authorize(money, creditcard, gateway_options)
  #   Rails.logger.debug("[#{__method__.upcase}]: #{[money, creditcard, gateway_options]}")
  # end
  #
  # def purchase(money, creditcard, gateway_options)
  #   Rails.logger.debug("[#{__method__.upcase}]: #{[money, creditcard, gateway_options]}")
  # end
  #
  # def capture(money, creditcard, gateway_options)
  #   Rails.logger.debug("[#{__method__.upcase}]: #{[money, creditcard, gateway_options]}")
  # end
  #
  # def credit(money, creditcard, gateway_options)
  #   Rails.logger.debug("[#{__method__.upcase}]: #{[money, creditcard, gateway_options]}")
  # end
  #
  # def cancel(_response)
  #   raise ::NotImplementedError, 'You must implement cancel method for this payment method.'
  # end
  #
  def create_profile(payment)
    Rails.logger.debug("[CREATE_PROFILE]: #{payment.as_json}")
  end
end


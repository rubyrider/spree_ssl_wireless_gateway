  class AllPaymentMethod < ::Spree::PaymentMethod
    preference :merchant_id, :string
    preference :secret, :string
    preference :product_category, :string
    preference :success_url, :string
    preference :fail_url, :string
    preference :cancel_url, :string
    preference :ipn_url, :string
    preference :server, :string, default: 'https://sandbox.sslcommerz.com'.freeze

    def provider_class
      ::SpreeSslWirelessGateway::PaymentMethod
    end
    
    def payment_source_class
      GatewaySupport
    end

    def cancel(_response)
      raise ::NotImplementedError, 'You must implement cancel method for this payment method.'
    end
  end


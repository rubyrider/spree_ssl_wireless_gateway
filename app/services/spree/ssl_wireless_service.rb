module Spree
  class SslWirelessService
    attr_accessor :response
    
    def easy_check_out_init(order_number, payment_method_id, emi = {})
      @emi  = emi
      @payment_method = ::Spree::PaymentMethod.find(payment_method_id)
      params          = PaymentProcessor.new(order_number, payment_method_id, emi).as_json
      Rails.logger.debug "[Endpoint: #{__method__}]: #{build_endpoint('gwprocess/v4/api.php')}"
      Rails.logger.debug "[Params: #{__method__}]: #{params}"
      
      response = Faraday.post(build_endpoint('gwprocess/v4/api.php')) do |request|
        request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        request.options.timeout         = 30
        request.body                    = params
      end
      
      self.response = JSON response.body
      
      formatted_response
    end
    
    def valid?(id, payment_method_id)
      @payment_method = Spree::PaymentMethod.find(payment_method_id)
      
      path = 'validator/api/validationserverAPI.php'
      params = {
          val_id: id,
          store_id:         @payment_method.preferences[:merchant_id],
          store_passwd:     @payment_method.preferences[:api_key],
      }
      headers = {}
      headers['Content-Type'] = 'application/x-www-form-urlencoded'
      response = Faraday.get(build_endpoint(path), params, headers)
      @status = JSON(response.body)['status']
      
      case @status
      when 'VALIDATED', 'VALID'
        true
      else
        false
      end
    end
    
    private
      
      def formatted_response
        {
            status:  self.response['status'].downcase,
            data:    self.response['GatewayPageURL'],
            logo:    self.response['storeLogo'],
            message: self.response['failedreason']
        }
      end
      
      def build_endpoint(path)
        URI.join(@payment_method.preferences[:server], path)
      end
  end
end

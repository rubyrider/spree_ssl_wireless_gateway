module Spree
  module CheckoutControllerDecorator
    def self.prepended(base)
      base.skip_before_action :verify_authenticity_token, only: :feedback, if: proc { params[:state] == 'payment' }
      base.before_action :process_payments, only: :feedback, if: proc { params[:state] == 'payment' }
    end
    
    def feedback
      update
    end

    private
  
      def rescue_from_spree_gateway_error(exception)
        flash.now[:notice] = exception.message
        @order.errors.add(:base, exception.message)
        
        render :edit
      end

    def process_payments
      order_params = SslWirelessFeedback.call(params).to_oder_param
      params[:order] = order_params[:order]
      params[:payment_source] = order_params[:payment_source]

      raise ::Spree::Core::GatewayError, 'Insufficient fund, please try again' if params[:state] == 'fail'
      raise ::Spree::Core::GatewayError, 'Payment has been cancelled, we hope you return soon' if params[:state] == 'cancel'

      Rails.logger.debug("[PROCESS_PAYMENT]: #{params}")
      @order.tap(&:process_payments!)
    end
  end
end

::Spree::CheckoutController.prepend ::Spree::CheckoutControllerDecorator

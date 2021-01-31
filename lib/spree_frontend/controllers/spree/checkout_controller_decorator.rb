module Spree
  module CheckoutControllerDecorator
    def self.prepended(base)
      base.before_action :set_ssw_gateway_params, only: :update, if: proc { params[:state] == 'payment_confirm' }
    end

    def set_ssw_gateway_params
    
    end
  end
end

# ::Spree::CheckoutController.prepend Spree::CheckoutControllerDecorator

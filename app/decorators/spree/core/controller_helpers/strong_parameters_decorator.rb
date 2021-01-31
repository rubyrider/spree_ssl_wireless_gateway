module Spree
  module Core
    module ControllerHelpers
      module StrongParametersDecorator
        def permitted_attributes
          Spree::PermittedAttributes
        end
        
        def permitted_payment_attributes
          super + ::Spree::SslWirelessFeedback::SSL_GATEWAY_ATTRIBUTES
        end
      end
    end
  end
end

::Spree::CheckoutController.prepend(Spree::Core::ControllerHelpers::StrongParametersDecorator)

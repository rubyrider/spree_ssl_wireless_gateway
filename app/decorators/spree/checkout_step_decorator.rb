module Spree
  module CheckoutStepDecorator
    def self.prepended(base)
      base.remove_checkout_step :confirm
    end
  end
end

Spree::Order.prepend ::Spree::CheckoutStepDecorator

class ::Spree::Api::V1::SslWirelessController < ::Spree::Api::V2::BaseController
  include ::Spree::Api::V2::Storefront::OrderConcern
  
  def initiate
    data = ::Spree::SslWirelessService.new.easy_check_out_init(
        params.to_unsafe_h[:order],
        params.to_unsafe_h[:payment_method_id],
        JSON(params.to_unsafe_h[:cart_json])
    )
    
    render json: data, status: :ok
  end
  
  def feedback
    @feedback = ::Spree::SslWirelessFeedback.call(params).to_oder_param
  end
end

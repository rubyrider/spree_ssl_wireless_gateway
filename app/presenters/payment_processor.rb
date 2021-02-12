class PaymentProcessor
  attr_reader :order_number, :order, :shipment, :payment_method, :emi
  
  include Spree
  
  def initialize(order_number, payment_method_id, emi = {})
    @emi            = emi
    @order_number   = order_number
    @order          = Spree::Order.find_by(number: order_number)
    @payment_method = Spree::PaymentMethod.find_by(id: payment_method_id)
    
    Rails.logger.debug "[PAYMENT_METHOD]: #{@payment_method.as_json}"
    
    @shipment = order&.shipments&.last

    @selected_installment = @emi.fetch('emi_selected_installment', 0).to_i
    
    if @selected_installment.nonzero?
      @order.emi_selected_installment = @selected_installment
      @order.save!(validate: false)
    end
    
    
    self
  end
  
  
  def as_json(options = nil)
    {
        store_id:            @payment_method.preferences[:merchant_id],
        store_passwd:        @payment_method.preferences[:api_key],
        total_amount:        order.total.to_s,
        amount:              order.amount.to_s,
        currency:            order.currency,
        tran_id:             order.number,
        success_url:         "#{@payment_method.preferences[:host]}/checkout/feedback/payment",
        fail_url:            "#{@payment_method.preferences[:host]}/checkout/feedback/fail",
        cancel_url:          "#{@payment_method.preferences[:host]}/checkout/feedback/cancel",
        cus_name:            order&.bill_address&.full_name,
        cus_email:           order&.user&.email || order&.email,
        cus_add1:            order&.bill_address&.address1&.presence,
        cus_add2:            order&.bill_address&.address2&.presence,
        cus_state:           order&.bill_address&.state&.name&.presence,
        cus_postcode:        order&.bill_address&.zipcode&.presence,
        cus_country:         order&.bill_address&.country&.name&.presence,
        cus_city:            order&.bill_address&.city&.presence,
        cus_phone:           order&.bill_address&.phone.presence,
        cus_fax:             '',
        shipping_method:     order&.ship_address.present? ? 'YES' : 'NO',
        ship_name:           shipment&.shipping_method&.name,
        ship_add1:           order&.ship_address&.address1&.presence,
        ship_add2:           order&.ship_address&.address2&.presence,
        ship_city:           order&.ship_address&.city&.presence,
        ship_state:          order&.ship_address&.city&.presence,
        ship_postcode:       order&.ship_address&.zipcode&.presence,
        ship_country:        order&.ship_address&.country&.name&.presence,
        value_a:             order_number,
        value_b:             payment_method&.id,
        value_c:             shipment&.shipping_method&.id,
        value_d:             order&.ship_address&.id,
        num_of_item:         order.item_total.to_s,
        product_name:        order.products.map(&:name).join(', '),
        product_profile:     "By #{order.store&.name}",
        product_category:    @payment_method.preferences[:product_category],
        discount_amount:     order&.promo_total&.to_s,
        convenience_fee:     order&.taxable_adjustment_total,
        emi_option:          allow_emi?,
        emi_max_inst_option: @payment_method.preferences[:emi_maximum_installments].to_i,
        emi_selected_inst:   @selected_installment,
        emi_allow_only:      allow_emi?
    }
  end
  
  private
    
    def number_of_installments
      [
          @selected_installment,
          @payment_method.preferences[:emi_maximum_installments].to_i
      ].sort.first
    end
    
    def allow_emi?
      @selected_installment > 0
    end
end

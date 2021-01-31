module Spree
  class SslWirelessFeedback
    SSL_GATEWAY_ATTRIBUTES = %i(bank_transaction_id gateway_transaction_id
    validation_id card_masked_number card_brand response_code
    source_issuer currency_amount currency_type gateway_raw_response)
    
    SUCCESS_PAYMENT_STATUS   = 'VALID'
    FAILED_PAYMENT_STATUS    = 'FAILED'
    CANCELLED_PAYMENT_STATUS = 'CANCELLED'
    
    GATEWAY_PAYMENT_STATUSES = [SUCCESS_PAYMENT_STATUS, FAILED_PAYMENT_STATUS, CANCELLED_PAYMENT_STATUS]
    
    GATEWAY_TO_SPREE_RESPONSE = {
        SUCCESS_PAYMENT_STATUS   => 'completed',
        FAILED_PAYMENT_STATUS    => 'failed',
        CANCELLED_PAYMENT_STATUS => 'failed'
    }
    
    attr_reader :params, :order, :payment_method
    
    def self.call(params)
      new(params)
    end
    
    def initialize(params)
      @params         = params
      @order          = Spree::Order.find_by(number: params[:tran_id])
      @payment_method = Spree::PaymentMethod.find(payment_method_id)
    end
    
    def to_oder_param
      @to_oder_param                  ||= {}
      @to_oder_param[:order]          = {
          payments_attributes:
              [
                  {
                      payment_method_id:      payment_method_id,
                      bank_transaction_id:    bank_transaction_id,
                      gateway_transaction_id: gateway_transaction_id,
                      validation_id:          validation_transaction_id,
                      card_masked_number:     validation_transaction_id,
                      card_brand:             card_brand,
                      response_code:          response_code,
                      source_issuer:          source_issuer,
                      currency_amount:        currency_amount,
                      currency_type:          currency_type,
                      amount:                 amount,
                      gateway_raw_response:   params.to_json,
                  }
              ]
      }
      
      @to_oder_param[:payment_source] ||= {
          "#{payment_method_id}" => {
              gateway_customer_profile_id: @order&.user_id,
              number:                      card_number,
              name:                        customer_full_name
          }
      }
      
      @to_oder_param
    end
    
    private
      
      def completed?
        payment_status == 'completed'
      end
      
      def failed?
        !completed?
      end
      
      def payment_status
        GATEWAY_TO_SPREE_RESPONSE[response_code]
      end
      
      def source_issuer
        @source_issuer ||= params.fetch(:card_issuer, nil)
      end
      
      def response_code
        @response_code ||= params.fetch(:status, 'FAILED')
      end
      
      def card_brand
        @card_type ||= params.fetch(:card_brand, '')
      end
      
      def card_masked_number
        @card_masked_number ||= params.fetch(:card_no, nil)
      end
      
      def currency_amount
        @currency_amount ||= params.fetch(:currency_amount, '')
      end
      
      def currency_type
        @currency_type ||= params.fetch(:currency_type, '')
      end
      
      def gateway_transaction_id
        @gateway_transaction_id ||= params.fetch(:tran_id, nil)
      end
      
      def bank_transaction_id
        @bank_transaction_id ||= params.fetch(:bank_tran_id, nil)
      end
      
      def validation_transaction_id
        @validation_transaction_id ||= params.fetch(:val_id, nil)
      end
      
      def amount
        @amount ||= params.fetch(:amount, 0)
      end
      
      def customer_full_name
        @customer_full_name ||= order&.bill_address&.full_name
      end
      
      def card_number
        @card_number ||= params.fetch(:card_no, nil)
      end
      
      def payment_method_id
        @payment_method_id ||= params.fetch(:value_b, nil)
      end
  end
end

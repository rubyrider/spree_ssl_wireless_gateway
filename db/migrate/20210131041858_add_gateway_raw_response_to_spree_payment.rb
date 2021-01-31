class AddGatewayRawResponseToSpreePayment < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_payments, :gateway_raw_response, :text
  end
end

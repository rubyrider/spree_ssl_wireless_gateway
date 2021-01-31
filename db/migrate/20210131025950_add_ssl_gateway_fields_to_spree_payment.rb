class AddSslGatewayFieldsToSpreePayment < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_payments, :bank_transaction_id, :string
    add_index :spree_payments, :bank_transaction_id, name: 'gt_ban_tran_id'
    add_column :spree_payments, :validation_id, :string
    add_index :spree_payments, :validation_id, name: 'gt_val_id'
    add_index :spree_payments, :bank_transaction_id
    add_column :spree_payments, :gateway_transaction_id, :string
    add_index :spree_payments, :gateway_transaction_id, name: 'gt_tran_id'
    add_column :spree_payments, :source_issuer, :string
    add_index :spree_payments, :source_issuer
    add_column :spree_payments, :currency_amount, :string
    add_index :spree_payments, :currency_amount
    add_column :spree_payments, :currency_type, :string
    add_index :spree_payments, :currency_type
    add_column :spree_payments, :card_brand, :string
    add_index :spree_payments, :card_brand
    add_column :spree_payments, :card_masked_number, :string
    add_index :spree_payments, :card_masked_number
  end
end

class AddEmiOptionsToSpreeOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_orders, :emi_selected_installment, :integer, default: 0, null: false
  end
end

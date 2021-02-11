module EmiDecorator
  def self.prepended(base)
    base.validates :emi_selected_installment, presence: true, inclusion: { in: [0, 3, 6, 9], max: 9, min: 0 }
  end
end

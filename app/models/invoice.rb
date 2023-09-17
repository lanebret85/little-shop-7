class Invoice < ApplicationRecord
  enum :status, {"cancelled" => 0, "completed" => 1, "in progress" => 2}

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def total_revenue
   invoice_items.sum('quantity*unit_price')
  end

end
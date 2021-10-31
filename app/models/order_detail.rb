class OrderDetail < ApplicationRecord

  belongs_to :item
  belongs_to :order

  def with_tax_price
    (price * 1.1).floor
  end

  def subtotal
    with_tax_price * amount
  end
  
  enum status: { impossible: 0, wait: 1, production: 2, completion: 3}

end

class Order
  attr_accessor :order_id, :name

  def initialize(order_id, name)
    @order_id = order_id
    @name = name
  end
end
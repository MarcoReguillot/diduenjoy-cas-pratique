class Item
  attr_accessor :name,
                :price,
                :ref,
                :warranty,
                :duration

  ALLOWED_ATTRIBUTES = %i[name price ref warranty duration].freeze
  def initialize(name = nil, price = nil, ref = nil, warranty = nil, duration = nil)
    @name = name
    @price = price
    @ref = ref
    @warranty = warranty
    @duration = duration
  end
end
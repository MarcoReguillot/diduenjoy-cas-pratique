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

  def dump(spaces: 0)
    ALLOWED_ATTRIBUTES.each do |var|
      # next if self.send(var).nil?
      puts " " * spaces + "#{var}: #{self.send(var)}"
    end
  end
end
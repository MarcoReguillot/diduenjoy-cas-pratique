class Item
  attr_accessor :item_id,
                :package_id,
                :name,
                :price,
                :ref,
                :warranty,
                :duration

  def initialize(item_id, package_id, name, price, ref, warranty, duration)
    @item_id = item_id
    @package_id = package_id
    @name = name
    @price = price
    @ref = ref
    @warranty = warranty
    @duration = duration
  end
end
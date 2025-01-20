class Package
  attr_accessor :items

  def initialize(items: {})
    @items = items
  end

  def dump(spaces: 0)
    puts((" " * spaces) + "Items:" + items.count.to_s)
    @items.each do |item_id, item|
      puts(" " * (spaces + 2) + "Item: #{item_id}")
      item.dump(spaces: spaces + 4)
    end
  end
end
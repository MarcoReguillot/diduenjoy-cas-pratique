require './lib/IDatabaseObject'

class Package
  attr_accessor :items, :order_id

  def db_table_name
    'packages'
  end

  def db_row
    {
      packageid: @package_id,
      orderid: @order_id
    }
  end

  def db_primary_key
    'packageid'
  end

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

  def save_to_db(db)
    @package_id = db.saveObject(self)
    @items.each do |item_id, item|
      item.package_id = @package_id
      item.save_to_db(db)
    end
  end
end
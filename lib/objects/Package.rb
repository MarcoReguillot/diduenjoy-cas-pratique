require './lib/IDatabaseObject'

class Package
  attr_accessor :items, :order_id

  # Override the db_table_name method of the IDatabaseObject class
  def db_table_name
    'packages'
  end

  # Override the db_row method of the IDatabaseObject class
  def db_row
    {
      packageid: @package_id,
      orderid: @order_id
    }
  end

  # Override the db_primary_key method of the IDatabaseObject class
  def db_primary_key
    'packageid'
  end

  def initialize(items: {})
    @items = items
  end

  # Prints the Package object
  # @param spaces [Integer] the number of spaces to print before the Package object (indentation)
  def dump(spaces: 0)
    puts((" " * spaces) + "Items:" + items.count.to_s)
    @items.each do |item_id, item|
      puts(" " * (spaces + 2) + "Item: #{item_id}")
      item.dump(spaces: spaces + 4)
    end
  end

  # Saves the Package object to the database and its associated Item objects
  def save_to_db(db)
    @package_id = db.saveObject(self)
    @items.each do |item_id, item|
      item.package_id = @package_id
      item.save_to_db(db)
    end
  end
end
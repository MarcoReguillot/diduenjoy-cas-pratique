require './lib/IDatabaseObject'

class Order < IDatabaseObject
  attr_accessor :name, :packages

  # Override the db_table_name method of the IDatabaseObject class
  def db_table_name
    'orders'
  end

  # Override the db_row method of the IDatabaseObject class
  def db_row
    {
      orderid: @order_id,
      odername: @name
    }
  end

  # Override the db_primary_key method of the IDatabaseObject class
  def db_primary_key
    'orderid'
  end

  def initialize(name, packages: {})
    @name = name
    @packages = packages
  end

  # Prints the Order object
  # @param spaces [Integer] the number of spaces to print before the Order object (indentation)
  def dump(spaces: 0)
    puts(" " * spaces + "Order: #{@name}")
    puts(" " * (spaces + 2) + "Packages:")
    @packages.each do |package_id, package|
      puts(" " * (spaces + 4) + "Package: #{package_id}")
      package.dump(spaces: spaces + 6)
    end
  end

  # Saves the Order object to the database and its associated Package objects
  def save_to_db(db)
    @order_id = db.saveObject(self)
    @packages.each do |package_id, package|
      package.order_id = @order_id
      package.save_to_db(db)
    end
  end
end
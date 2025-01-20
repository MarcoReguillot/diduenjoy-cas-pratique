require './lib/IDatabaseObject'

class Order < IDatabaseObject
  attr_accessor :name, :packages, :order_id

  def db_table_name
    'orders'
  end

  def db_row
    {
      orderid: @order_id,
      odername: @name
    }
  end

  def initialize(name, packages: {})
    @name = name
    @packages = packages
  end

  def dump(spaces: 0)
    puts(" " * spaces + "Order: #{@name}")
    puts(" " * (spaces + 2) + "Packages:")
    @packages.each do |package_id, package|
      puts(" " * (spaces + 4) + "Package: #{package_id}")
      package.dump(spaces: spaces + 6)
    end
  end

  def save_to_db(db)
    @order_id = db.get_next_id(self.db_table_name, 'orderid')
    db.saveObject(self)
    @packages.each do |package_id, package|
      package.order_id = @order_id
      package.save_to_db(db)
    end
  end
end
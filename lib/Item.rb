require './lib/IDatabaseObject'

class Item < IDatabaseObject
  attr_accessor :name,
                :price,
                :ref,
                :warranty,
                :duration,
                :item_id,
                :package_id

  def db_table_name
    'items'
  end

  def db_row
    warranty_value = case @warranty
      when 'NO'
        false
      when 'YES'
        true
      else
        nil
      end
    {
      itemid: @item_id,
      name: @name,
      price: @price,
      ref: @ref,
      packageid: @package_id,
      warranty: warranty_value,
      duration: @duration
    }
  end

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

  def save_to_db(db)
    @item_id = db.get_next_id(self.db_table_name, 'itemid')
    db.saveObject(self)
  end
end
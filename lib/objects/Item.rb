require './lib/IDatabaseObject'


class Item < IDatabaseObject
  attr_accessor :name,
                :price,
                :ref,
                :warranty,
                :duration,
                :package_id

  
  def initialize(name = nil, price = nil, ref = nil, warranty = nil, duration = nil)
    @name = name
    @price = price
    @ref = ref
    @warranty = warranty
    @duration = duration
  end

  # Override the db_table_name method of the IDatabaseObject class
  def db_table_name
    'items'
  end

  # Override the db_row method of the IDatabaseObject class
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

  # Override the db_primary_key method of the IDatabaseObject class
  def db_primary_key
    'itemid'
  end


  # Used to define the attributes that can be set on an Item object
  ALLOWED_ATTRIBUTES = %i[name price ref warranty duration].freeze

  # Prints the Item object
  # @param spaces [Integer] the number of spaces to print before the Item object (indentation)
  def dump(spaces: 0)
    ALLOWED_ATTRIBUTES.each do |var|
      # next if self.send(var).nil?
      puts " " * spaces + "#{var}: #{self.send(var)}"
    end
  end

  # Saves the Item object to the database
  def save_to_db(db)
    @item_id = db.saveObject(self)
  end
end
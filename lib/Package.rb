class Package
  attr_accessor :items

  def initialize(items: {})
    @items = items
  end
end
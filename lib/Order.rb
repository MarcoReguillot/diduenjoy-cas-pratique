class Order
  attr_accessor :name, :packages

  def initialize(name, packages: {})
    @name = name
    @packages = packages
  end
end
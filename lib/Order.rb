class Order
  attr_accessor :name, :packages

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
end
require './lib/Item'
require './lib/Order'
require './lib/Package'
require './lib/ExcelParser'

orders = {}

ExcelParser.new('Orders.xlsx').parse_lines do |parsed_line|
    order = orders[parsed_line]
    unless order
        orders[parsed_line.order_name] = Order.new(parsed_line.order_name)
        order = orders[parsed_line.order_name]
    end
    package = order.packages[parsed_line.package_id]
    unless package
        order.packages[parsed_line.package_id] = Package.new
        package = order.packages[parsed_line.package_id]
    end
    item = package.items[parsed_line.item_id]
    unless item
        package.items[parsed_line.item_id] = Item.new
        item = package.items[parsed_line.item_id]
    end
    if Item::ALLOWED_ATTRIBUTES.include?(parsed_line.label.to_sym)
        item.send("#{parsed_line.label}=", parsed_line.value)
    else
        STDERR.puts "Unknown attribute: #{parsed_line.label}"
    end
end
print orders
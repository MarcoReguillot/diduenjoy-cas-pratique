require './lib/Item'
require './lib/Order'
require './lib/Package'
require './lib/ExcelParser'


def get_orders(file_path)
    orders = {}

    ExcelParser.new(file_path).parse_lines do |parsed_line|
        order = orders[parsed_line.order_name]
        unless order
            order = Order.new(parsed_line.order_name)
            orders[parsed_line.order_name] = order
        end
        package = order.packages[parsed_line.package_id]
        unless package
            package = Package.new
            order.packages[parsed_line.package_id] = package
        end
        item = package.items[parsed_line.item_id]
        unless item
            item = Item.new
            package.items[parsed_line.item_id] = item
        end
        if Item::ALLOWED_ATTRIBUTES.include?(parsed_line.label.to_sym)
            item.send("#{parsed_line.label}=", parsed_line.value)
        else
            STDERR.puts "Unknown attribute: #{parsed_line.label}"
        end
    end
    orders
end

def print_orders(orders)
    orders.each do |order_id, order|
        order.dump
    end
end

orders = get_orders(ARGV[0])
print_orders(orders)
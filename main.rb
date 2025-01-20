require './lib/Item'
require './lib/Order'
require './lib/Package'
require './lib/ExcelParser'
require './lib/Database'

# Reads an Excel file (thanks to ExcelParser class) and creates the Order, Package and Item data tree.
# @param file_path [String] the path to the Excel file
# @return [Hash] the orders data tree
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

# Prints the orders data tree
def print_orders(orders)
    orders.each do |order_id, order|
        order.dump
    end
end

# Saves the orders data tree to the database
def save_to_db(orders, db)
    orders.each do |order_name, order|
        order.save_to_db(db)
    end
end

orders = get_orders(ARGV[0])
print_orders(orders)

db = Database.new('due', 'due', 'due', 'localhost', 5432)

save_to_db(orders, db)
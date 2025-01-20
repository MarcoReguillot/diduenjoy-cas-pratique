require './lib/Item'
require './lib/Order'
require './lib/Package'
require './lib/ExcelParser'

ExcelParser.new('Orders.xlsx').parse_lines do |parsed_line|
  puts parsed_line
end
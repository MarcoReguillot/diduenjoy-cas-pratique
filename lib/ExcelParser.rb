require 'rubyXL'

class ParsedLine
  attr_accessor :package_id, :item_id, :label, :value, :order_name

  def to_s
    "#{package_id}, #{item_id}, #{label}, #{value}, #{order_name}"
  end
end

class ExcelParser
  def initialize(file_path)
    @file_path = file_path
    @workbook = RubyXL::Parser.parse(file_path)
  end

  def parse_lines
    @workbook.worksheets.each do |sheet|
      line_index = 1
      while sheet.sheet_data[line_index]
        yield parse_line(sheet.sheet_data[line_index], sheet.sheet_name)
        line_index += 1
      end
    end
  end

  def parse_line(line, order_name)
    parsed_line = ParsedLine.new
    parsed_line.package_id = line[0].value
    parsed_line.item_id = line[1].value
    parsed_line.label = line[2].value
    parsed_line.value = line[3].value
    parsed_line.order_name = order_name
    parsed_line
  end
end
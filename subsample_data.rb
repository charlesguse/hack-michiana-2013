#!/usr/bin/env ruby

input = ARGV[0]
year  = ARGV[1]

YEAR = 0
COUNTY_DESCRIPTION = 1
UNIT_NAME = 5
DEPARTMENT = 13
AMOUNT = 14
DESIRED_COLUMNS = [YEAR, COUNTY_DESCRIPTION, UNIT_NAME, DEPARTMENT, AMOUNT]
NAME = "county_tree_map_data"
data = File.open(input)

heading = data.first.chomp.split('|').map{|el| el.to_sym}

def select_columns data, columns
  columns.inject([]){|result, column| result << data[column]}
end

a = data.each_with_index
         .map do |el, index|
           next if index == 0
           select_columns el.split('|'), DESIRED_COLUMNS
         end.compact
         .select{|el| el[0] == year}

File.open("#{NAME}.csv", 'w:UTF-8') {|f| f.puts a.map{|el| el.join('|')}}

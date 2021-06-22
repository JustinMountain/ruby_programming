require 'csv'

puts 'EventManager initialized.'

# contents = File.read('event_attendees.csv')
# puts contents

# lines = File.readlines('event_attendees.csv')
# lines.each_with_index do |line, index|
#   next if index == 0
#   columns = line.split(",")
#   name = columns[2]
#   p name
# end

def clean_zipcode(zipcode)
  # if zipcode.nil?
  #   zipcode = "00000"
  # elsif zipcode.length < 5
  #   # until zipcode.length == 5
  #   #   zipcode.prepend("0")
  #   # end
  #   zipcode = zipcode.rjust(5, "0")
  # else zipcode.length > 5
  #   zipcode = zipcode[0..4]
  # end
  zipcode.to_s.rjust(5, "0")[0..4]
end

contents = CSV.open(
  'event_attendees.csv', 
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  puts "#{name} #{zipcode}"
end
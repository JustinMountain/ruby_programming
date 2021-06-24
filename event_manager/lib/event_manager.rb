require 'csv'
require "google/apis/civicinfo_v2"
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def legislators_by_zipcode(zipcode)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  
  begin
    civic_info.representative_info_by_address(
      address: zipcode,
      levels: 'country',
      roles: ['legislatorUpperBody', 'LegislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thankyou_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exists?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone(phone)
  clean_number = phone.tr('^0-9', '')

  if clean_number.length == 10
    return clean_number
  elsif clean_number.length == 11 && clean_number[0] == "1"
    clean_number = clean_number[1..11]
  else 
    clean_number = "No valid number"
  end
end

def peak_registration_times(reg_times)
  peak_reg_time = Hash.new(0)

  reg_times.each { |time| peak_reg_time[time] += 1 }
  peak_reg_time = peak_reg_time.sort_by {|key, value| -value}.to_h
  p peak_reg_time

end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv', 
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

registration_times = []


contents.each do |row|
  id = row[0]
  name = row[:first_name]

  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  # form_letter = erb_template.result(binding)
  # save_thankyou_letter(id, form_letter)

  phone = clean_phone(row[:homephone])
  # puts phone

  registration_times << Time.strptime(row[:regdate], "%m/%d/%Y %k:%M").hour

end

peak_registration_times(registration_times)


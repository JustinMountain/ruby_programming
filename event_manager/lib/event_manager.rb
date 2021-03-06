require 'csv'
require "google/apis/civicinfo_v2"
require 'erb'
require 'time'
require 'date'

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
  puts "The best times to target ads are #{peak_reg_time.keys[0]}h, #{peak_reg_time.keys[1]}h, and #{peak_reg_time.keys[2]}h."
end

def peak_registration_days(reg_days)
  peak_reg_day = Hash.new(0)

  reg_days.each { |day| peak_reg_day[day] += 1 }
  peak_reg_day = peak_reg_day.sort_by {|key, value| -value}.to_h
  puts "The best days to target ads are #{what_day(peak_reg_day.keys[0])} (#{peak_reg_day.values[0]}), #{what_day(peak_reg_day.keys[1])} (#{peak_reg_day.values[1]}), and #{what_day(peak_reg_day.keys[2])} (#{peak_reg_day.values[2]})."
end

def what_day(day_as_number)
  if day_as_number == 0
    return "Sunday"
  elsif day_as_number == 1
    return "Monday"
  elsif day_as_number == 2
    return "Tuesday"
  elsif day_as_number == 3
    return "Wednesday"
  elsif day_as_number == 4
    return "Thursday"
  elsif day_as_number == 5
    return "Friday"
  elsif day_as_number == 6
    return "Saturday"
  end
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
registration_days = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]

  registration_times << Time.strptime(row[:regdate], "%m/%d/%Y %k:%M").hour
  registration_days << Time.strptime(row[:regdate], "%m/%d/%Y %k:%M").wday

  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  # form_letter = erb_template.result(binding)
  # save_thankyou_letter(id, form_letter)

  phone = clean_phone(row[:homephone])
  # puts phone
end

peak_registration_times(registration_times)
peak_registration_days(registration_days)
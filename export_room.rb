#!/usr/bin/env ruby
require 'httparty'
require 'json'
require 'date'
require 'fileutils'

rate_limit_reached = false
token = JSON.parse(File.read('.token'))['token']
rooms = JSON.parse(File.read('hipchat_export/rooms/list.json'))['rooms']
latest_date = Date.today.prev_day
earliest_date = Date.new(2014, 8, 26)
rooms.each do |room|
  break if rate_limit_reached
  dir = "hipchat_export/rooms/#{room['name']}"
  (earliest_date..latest_date).each do |date|
    url = "https://hipchat.com/v2/room/#{room['room_id']}/history?auth_token=#{token}&date=#{(date.next_day).strftime('%F')}T00:00:00%2B08:00&end-date=#{date.strftime('%F')}T00:00:00%2B08:00"
    response = HTTParty.get(url)
    json = JSON.parse(response.body)
    rate_limit_reached = (response.code == 429)
    if rate_limit_reached
      puts 'rate limit reached'
      break
    end
    sleep(3)
    FileUtils.mkdir_p(dir) unless Dir.exists?(dir)
    puts "exporting #{dir}/#{date.strftime('%F')}.json"
    File.open("#{dir}/#{date.strftime('%F')}.json", 'w') do |f|
      f.write(JSON.pretty_generate json)
    end
  end
  puts "generating #{dir}/list.json"
  File.open("#{dir}/list.json", 'w') do |f|
    f.write(JSON.pretty_generate Dir.entries(dir)[2..-2])
  end
end